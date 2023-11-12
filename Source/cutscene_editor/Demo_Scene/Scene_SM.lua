require("FCM_Utilities.lua");
require("FCM_AgentExtensions.lua");
require("FCM_Color.lua");
require("FCM_Printing.lua");
require("FCM_PropertyKeys.lua");
require("FCM_Development_Freecam.lua");
require("FCM_Development_AgentBrowser.lua");
require("FCM_DepthOfFieldAutofocus.lua");
require("FCM_Scene_PrepareLevel.lua");
require("LIP.lua")
local LIP = require("LIP.lua")
require("CutsceneEditor.lua");
require("CutscenePlayer.lua");

--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| SCRIPT VARIABLES ||||||||||||||||||||||||||||||||||||||||||||||

--main level variables
local kScript = "DemoScene"; --(the name of the level function which will be called as soon as this scene opens)
local kScene = "adv_johnsHouseWoodsTile"; --(the name of the scene asset file)
local agent_name_scene = "adv_johnsHouseWoodsTile.scene"; --(the name of the scene agent object)

--cutscene development variables variables (these are variables required by the development scripts)
Custom_CutsceneDev_SceneObject = kScene; --dont touch (the development scripts need to reference the main level)
Custom_CutsceneDev_SceneObjectAgentName = agent_name_scene; --dont touch (the development scripts also need to reference the name of the scene agent)
Custom_CutsceneDev_UseSeasonOneAPI = false; --dont touch (this is leftover but if the development tools were implemented inside season 1 we need to use the S1 functions because the api changes)
Custom_CutsceneDev_FreecamUseFOVScale = false; --dont touch (changes the camera zooming from modifing the FOV directly, to modifying just the FOV scalar (only useful if for some reason the main field of view property is chorelocked or something like that))

--cutscene variables
local MODE_FREECAM = false; --enable freecam rather than the cutscene camera (better leave this as false and change in the main function itself)
agent_name_cutsceneCamera = "myCutsceneCamera"; --cutscene camera agent name
agent_name_cutsceneCameraParent = "myCutsceneCameraParent"; --cutscene camera parent agent name

--hides the cursor in game
HideCusorInGame = function()
    CursorHide(true); --hide the cursor
    CursorEnable(true); --enable cusor functionality
end

--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE SETUP ||||||||||||||||||||||||||||||||||||||||||||||


Cutscene_CreateCutsceneCamera = function()
    --generic camera prop (prefab) asset
    local cam_prop = "module_camera.prop";
    
    --set a default position/rotation for the camera. (in theory this doesn't matter, but if the script somehow breaks during update the camera will stay in this position).
    local newPosition = Vector(0,0,0);
    local newRotation = Vector(0,0,0);
    
    --instaniate our cutscene camera object
    cameraAgent = AgentCreate(agent_name_cutsceneCamera, cam_prop, newPosition, newRotation, kScene, false, false);
    local cameraParentAgent = AgentCreate(agent_name_cutsceneCameraParent, "group.prop", newPosition, newRotation, kScene, false, false);

    AgentAttach(cameraAgent, cameraParentAgent);

    --set the clipping planes of the camera (how close the camera can see objects, and how far the camera can see)
    --if the near is set too high we start loosing objects in the foreground.
    --if the far is set to low we will only see part or no skybox at all
    Custom_AgentSetProperty(agent_name_cutsceneCamera, "Clip Plane - Far", 2500, kScene);
    Custom_AgentSetProperty(agent_name_cutsceneCamera, "Clip Plane - Near", 0.05, kScene);

    
    --Custom_AgentSetProperty(agent_name_cutsceneCamera, "Field of View", 50, Custom_CutsceneDev_SceneObject); --FOV correction for S2
    
    --bulk remove the original cameras that were in the scene
    Custom_RemovingAgentsWithPrefix(kScene, "cam_");

    --push our new current camera to the scene camera layer stack (since we basically removed all of the original cameras just the line before this)
    CameraPush(agent_name_cutsceneCamera);
end


--main level script, this function gets called when the scene loads

DemoScene = function()
   
    --loading resources from all episodes of Season 3 (loading cross-season resources this way is not recommended and may break the scene)
    ResourceSetEnable("ProjectSeason4");
    ResourceSetEnable("WalkingDeadM101");
    ResourceSetEnable("WalkingDeadM102");
    ResourceSetEnable("WalkingDeadM103");
 


    MODE_FREECAM = true;

    --if we are not in freecam mode, go ahead and create the cutscene camera
    if (MODE_FREECAM == false) then
        Cutscene_CreateCutsceneCamera(); --create our cutscene camera in the scene
        --create our free camera and our cutscene dev tools
    else
        Custom_CutsceneDev_CreateFreeCamera();
        Custom_CutsceneDev_InitalizeCutsceneTools();
        --add these development update functions, and have them run every frame
        Callback_OnPostUpdate:Add(Custom_CutsceneDev_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(Custom_CutsceneDev_UpdateCutsceneTools_Input);
        Callback_OnPostUpdate:Add(Custom_CutsceneDev_UpdateCutsceneTools_Main);
    end
    
    --PrintSceneListToTXT(kScene, "ObjectList.txt");
    
    CutsceneEditor("cutscene_sm","sk55_michonne.prop");
    --CutscenePlayer("cutscene_sm", 0, 1, 0);



end


--open the scene with this script
SceneOpen(kScene, kScript);