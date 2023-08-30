-- Decompiled using luadec 2.2 rev:  for Lua 5.2 from https://github.com/viruscamp/luadec
-- Command line: E:\Work\MODDING\Github\TTDS-FirstCutscene\first-cutscene-release\WDC_pc_Menu_data\Menu_main_temp.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
require("RichPresence.lua")
require("Utilities.lua")
require("AspectRatio.lua")
require("MenuUtils.lua")
require("Menu_JumpScrollList.lua")
require("Menu_Characters.lua")
require("Menu_ConceptGallery.lua")
require("Menu_Music.lua")
require("Menu_Options.lua")
require("Menu_Seasons.lua")
require("Menu_VideoMenu.lua")
require("UI_ListButton.lua")
require("UI_ListButtonLite.lua")
require("UI_Legend.lua")
require("UI_Popup.lua")

--droyti LAL support
local loadAnyLevelStatus, droytiLal = pcall(require, "Menu_loadAnyLevel.lua")

--our cutscene loading script


if ResourceExists("DebugLoader.lua") then
  require("DebugLoader.lua")
  require("MenuBootUtils.lua")
end

local kScene = "ui_menuMain.scene"
local kKeyArtScene = "adv_clementineHouse400.scene"
local mControllerAmbient, mControllerIdle, mControllerNowPlaying, mRefCounterAmbient = nil, nil, nil, nil
local bgMain = {isMenuMain = true}
bgMain.transitionTo = function(self, otherBG)
  -- function num : 0_0 , upvalues : _ENV, kScene
  if not otherBG then
    ChorePlay("ui_menuMain_show")
    Menu_Main_EnableAmbient(true)
    Sleep(1.5)
  else
    if otherBG.sharesBGWithMain then
      SceneHide(kScene, false)
    end
  end
end

bgMain.transitionFrom = function(self, otherBG)
  -- function num : 0_1 , upvalues : _ENV, kScene
  if not otherBG then
    ChorePlayAndWait("ui_menuMain_hide")
  else
    if otherBG.sharesBGWithMain then
      SceneHide(kScene, true)
    end
  end
end

local EnableAmbient = function(bEnable)
  -- function num : 0_2 , upvalues : mControllerAmbient, _ENV
  if bEnable then
    mControllerAmbient = ChorePlayAndSync("ui_menu_ambientFadeIn", mControllerAmbient)
  else
    mControllerAmbient = ChorePlayAndSync("ui_menu_ambientFadeOut", mControllerAmbient)
  end
end

mRefCounterAmbient = ReferenceCounter(EnableAmbient)
local OpenDebugMenu = function()
  -- function num : 0_3 , upvalues : _ENV, kScene
  if SceneIsActive(kScene) then
    WidgetInputHandler_EnableInput(false)
    MenuBoot_CreateDebugMenu()
  end
end

local UpdateLegend = function()
  -- function num : 0_4 , upvalues : _ENV
  Legend_Clear()
  Legend_Add("faceButtonDown", "legend_select")
  if IsPlatformXboxOne() then
    Legend_Add("faceButtonUp", MenuUtils_LegendStringForProfileUser(Menu_Text("legend_changeProfile")), "PlatformOpenAccountPickerUI()")
  end
end

Menu_LoadLevel_Copy = function(levelEpisode, level)
  SubProject_Switch(levelEpisode, level .. ".lua")
end

Menu_Main = function()
  -- function num : 0_5 , upvalues : _ENV, kKeyArtScene, kScene, bgMain, UpdateLegend
  if not SceneIsActive(kKeyArtScene) then
    MenuUtils_AddScene(kKeyArtScene)
  end
  SceneHide(kKeyArtScene, false)
  SceneHide("ui_menuMain", false)
  local menu = Menu_Create(ListMenu, "ui_menuMain", kScene)
  menu.align = "left"
  menu.background = bgMain
  menu.Show = function(self, direction)
    -- function num : 0_5_0 , upvalues : _ENV, UpdateLegend
    Menu_Main_SetIdle("env_clementineHouse400_mainMenu")
    if direction and direction < 0 then
      ChorePlay("ui_alphaGradient_show")
    end
    ;
    (Menu.Show)(self)
    RichPresence_Set("richPresence_mainMenu", false)
    UpdateLegend()
  end

  menu.Hide = function(self, direction)
    -- function num : 0_5_1 , upvalues : _ENV
    ChorePlay("ui_alphaGradient_hide")
    ;
    (Menu.Hide)(self)
  end

  menu.Populate = function(self)
    -- function num : 0_5_2 , upvalues : _ENV, menu, UpdateLegend
    local buttonSeasons = Menu_Add(ListButtonLite, "seasons", "label_seasonSelect", "Menu_Seasons()")
    AgentSetProperty(buttonSeasons.agent, "Text Glyph Scale", 1.5)
    if Menu_VideoPlayer_CanSupportVideo() then
      Menu_Add(ListButtonLite, "videos", "label_videos", "Menu_VideoMenu()")
    end
    Menu_Add(ListButtonLite, "characters", "label_characters", "Menu_Characters()")
    Menu_Add(ListButtonLite, "art", "label_art", "Menu_ConceptGallery()")
    Menu_Add(ListButtonLite, "music", "label_music", "Menu_Music()")
    Menu_Add(ListButtonLite, "settings", "label_settings", "Menu_Options()")
    Menu_Add(ListButtonLite, "credits", "label_credits", "Menu_ShowCredits( 0 )")
    
    

    --------------------------------------
    --LAL support
    if(loadAnyLevelStatus) then
        Menu_Add(ListButtonLite, "loadanylevel", "Load Any Level", "Menu_LoadAnyLevel()")
    end
    
    --cutscene mod button
    Menu_Add(ListButtonLite, "firstcutscenelevel", "Launch Demo Scene", "Menu_LoadLevel_Copy(\"" .. "WalkingDead302" .. "\", \"" .. "Demo_Scene" .. "\")") --"PlayFirstCutsceneLevel()")
  --------------------------------------



    
    if IsPlatformPC() or IsPlatformMac() then
      Menu_Add(ListButtonLite, "exit", "label_exitGame", "UI_Confirm( \"popup_quit_header\", \"popup_quit_message\", \"EngineQuit()\" )")
    end
    local legendWidget = Menu_Add(Legend)
    legendWidget.Place = function(self)
      -- function num : 0_5_2_0 , upvalues : menu
      self:AnchorToAgent(menu.agent, "left", "bottom")
    end

    UpdateLegend()
  end

  menu.onModalPopped = function(self)
    -- function num : 0_5_3 , upvalues : _ENV, UpdateLegend
    (Menu.onModalPopped)(self)
    UpdateLegend()
  end

  Menu_Show(menu)
end

Menu_Main_Start = function()
  -- function num : 0_6 , upvalues : _ENV
  if Input_UseTouch() then
    ClickText_Enable(true)
  end
  local prefs = GetPreferences()
  if PropertyIsLocal(prefs, "Menu - User Gamma Setting") then
    RenderSetIntensity(PropertyGet(prefs, "Menu - User Gamma Setting"))
    PropertyRemove(prefs, "Menu - User Gamma Setting")
    SavePrefs()
  end
  RenderForce_16_by_9_AspectRatio(true)
  RenderDelay(1)
  WaitForNextFrame()
  Menu_Main()
end

Menu_Main_GetKeyArtScene = function()
  -- function num : 0_7 , upvalues : kKeyArtScene
  return kKeyArtScene
end

Menu_Main_SetIdle = function(chore)
  -- function num : 0_8 , upvalues : mControllerIdle, _ENV
  if mControllerIdle then
    ControllerKill(mControllerIdle)
  end
  if chore then
    mControllerIdle = ChorePlay(chore, 10)
    if mControllerIdle then
      ControllerSetLooping(mControllerIdle, true)
    end
  end
end

Menu_Main_EnableAmbient = function(bEnable)
  -- function num : 0_9 , upvalues : mRefCounterAmbient
  mRefCounterAmbient:Enable(bEnable)
end

Menu_Main_SetNowPlaying = function(text)
  -- function num : 0_10 , upvalues : _ENV, mControllerNowPlaying
  local chore = nil
  if text then
    local nowPlaying = AgentFind("ui_menuMain_nowPlaying")
    AgentSetProperty(nowPlaying, kText, text)
    chore = "ui_nowPlaying_show"
  else
    do
      chore = "ui_nowPlaying_hide"
      mControllerNowPlaying = ChorePlayAndSync(chore, mControllerNowPlaying)
    end
  end
end

if IsToolBuild() then
  Preload_SetSubProjectShaderPack("Menu", FileStripExtension(kScene))
end
if ResourceExists("DebugLoader.lua") then
  Callback_OnLoadDebugMenu:Add(OpenDebugMenu)
end
SceneOpen(kScene, "Menu_Main_Start")