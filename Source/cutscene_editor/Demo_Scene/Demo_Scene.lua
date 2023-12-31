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
local kScene = "adv_richmondStreet"; --(the name of the scene asset file)
local agent_name_scene = "adv_richmondStreet.scene"; --(the name of the scene agent object)

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
    --load "ProjectSeason3" to  work with ANF, load "ProjectSeason4" to work in any other season (S2, S4, Michonne)
    ResourceSetEnable("ProjectSeason3");
    ResourceSetEnable("WalkingDead301");
    ResourceSetEnable("WalkingDead302");
    ResourceSetEnable("WalkingDead303");
    ResourceSetEnable("WalkingDead304");
    ResourceSetEnable("WalkingDead305"); 
     

    --IMPORTANT - Name agents with their Telltale names, if you give them an entirely custom names they might break
    agent_mari = AgentCreate("Mariana", "sk62_mariana.prop", Vector(0, 0, 0), Vector(0,0,0), kScene, false, false)
    
    agent_anf_1 = AgentCreate("Rufus", "sk61_rufus.prop", Vector(0, 0, 0), Vector(0,0,0), kScene, false, false)
    agent_anf_2 = AgentCreate("Eli", "sk61_eli.prop", Vector(0, 0, 0), Vector(0,0,0), kScene, false, false)
    agent_anf_3 = AgentCreate("Roxanne", "sk62_roxanne.prop", Vector(0, 0, 0), Vector(0,0,0), kScene, false, false)
    

    agent_zombie_1 = AgentCreate("Zombie_1", "sk61_zombie.prop", Vector(0, 0, 0), Vector(0,0,0), kScene, false, false)
    agent_zombie_2 = AgentCreate("Zombie_2", "sk61_zombieBulldozered.prop", Vector(0, 0, 0), Vector(0,0,0), kScene, false, false)
    agent_zombie_3 = AgentCreate("Zombie_3", "sk61_zombieCracked.prop", Vector(0, 0, 0), Vector(0,0,0), kScene, false, false)
    agent_zombie_4 = AgentCreate("Zombie_4", "sk61_zombieFaceless.prop", Vector(0, 0, 0), Vector(0,0,0), kScene, false, false)
    agent_zombie_5 = AgentCreate("Zombie_5", "sk61_zombieGuts.prop", Vector(0, 0, 0), Vector(0,0,0), kScene, false, false)
    agent_zombie_6 = AgentCreate("Zombie_6", "sk61_zombie.prop", Vector(0, 0, 0), Vector(0,0,0), kScene, false, false)
    agent_zombie_7 = AgentCreate("Zombie_7", "sk61_zombieFaceless.prop", Vector(0, 0, 0), Vector(0,0,0), kScene, false, false)

    
    Custom_SetAgentWorldPosition("Tripp", Vector(0, -1000, 0), kScene);
    Custom_SetAgentWorldPosition("Kate", Vector(0, -1000, 0), kScene);
    Custom_SetAgentWorldPosition("Conrad", Vector(0, -1000, 0), kScene);
    Custom_SetAgentWorldPosition("Eleanor", Vector(0, -1000, 0), kScene);
    Custom_SetAgentWorldPosition("Jesus", Vector(0, -1000, 0), kScene);

    Custom_SetAgentWorldPosition("Javier", Vector(0, 0, 0), kScene);


    
    --light for Act 1 ANF guards and Mariana
    local flashlightColor = RGBColor(255, 255, 255, 50)
    local envlight_groupEnabled = AgentGetProperty("light_Directional", "EnvLight - Enabled Group", kScene)
    local envlight_groups = AgentGetProperty("light_Directional", "EnvLight - Groups", kScene)
    local flashlightTestLight_spot = AgentCreate("flashlightTestLight_spot", "module_env_light.prop", Vector(0,1.8,2), Vector(160, 0, 0), kScene, false, false)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Type", 1, kScene) --0 point light, 1 spot light
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Intensity", 1, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Enlighten Intensity", 0, kScene) --season 1 and season 2 only
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Radius", 80, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Distance Falloff", 1, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Spot Angle Inner", 10, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Spot Angle Outer", 90, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Color", flashlightColor, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Enabled Group", envlight_groupEnabled, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Groups", envlight_groups, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Shadow Type", 0, kScene) -- 0 to disable shadows
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Wrap", 0.0, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Shadow Quality", 3, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - HBAO Participation Type", 2, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Shadow Near Clip", 0.0, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Shadow Depth Bias", -0.5, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Mobility", 2, kScene) --lets the light to move around
    AgentAttach("flashlightTestLight_spot", "Rufus");

    
    local flashlightTestLight_spot = AgentCreate("flashlightTestLight_spot_2", "module_env_light.prop", Vector(0,2,2), Vector(160, 0, 0), kScene, false, false)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Type", 1, kScene) --0 point light, 1 spot light
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Intensity", 1, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Enlighten Intensity", 0, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Radius", 5, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Distance Falloff", 1, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Spot Angle Inner", 10, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Spot Angle Outer", 50, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Color", flashlightColor, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Enabled Group", envlight_groupEnabled, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Groups", envlight_groups, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Shadow Type", 0, kScene) -- 0 to disable shadows
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Wrap", 0.0, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Shadow Quality", 3, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - HBAO Participation Type", 2, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Shadow Near Clip", 0.0, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Shadow Depth Bias", -0.5, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Mobility", 2, kScene) --lets the light to move around
    AgentAttach("flashlightTestLight_spot_2", "Mariana");

    for i = 1, 7 do 
        local light_name = "flashlightTestLight_spot_z_" .. tostring(i);
        local zombie_name = "Zombie_" .. tostring(i);
        local flashlightTestLight_spot = AgentCreate(light_name, "module_env_light.prop", Vector(0,2,2), Vector(160, 0, 0), kScene, false, false)
        Custom_AgentSetProperty(light_name, "EnvLight - Type", 1, kScene) --0 point light, 1 spot light
        Custom_AgentSetProperty(light_name, "EnvLight - Intensity", 1, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Enlighten Intensity", 0, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Radius", 5, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Distance Falloff", 1, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Spot Angle Inner", 10, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Spot Angle Outer", 50, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Color", flashlightColor, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Enabled Group", envlight_groupEnabled, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Groups", envlight_groups, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Shadow Type", 0, kScene) -- 0 to disable shadows
        Custom_AgentSetProperty(light_name, "EnvLight - Wrap", 0.0, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Shadow Quality", 3, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - HBAO Participation Type", 2, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Shadow Near Clip", 0.0, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Shadow Depth Bias", -0.5, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Mobility", 2, kScene) --lets the light to move around
        AgentAttach(light_name, zombie_name);
    end


    for i = 1, 2 do 
        local light_name = "flashlightTestLight_point_gun_" .. tostring(i);
        local flashlightColor = RGBColor(255, 205, 0, 255)
        local flashlightTestLight_point = AgentCreate(light_name, "module_env_light.prop", Vector(0,-1000,0), Vector(90, 0, 0), kScene, false, false)
        Custom_AgentSetProperty(light_name, "EnvLight - Type", 0, kScene) --0 point light, 1 spot light
        Custom_AgentSetProperty(light_name, "EnvLight - Intensity", 2.0, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Enlighten Intensity", 0, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Radius", 10, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Distance Falloff", 0, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Spot Angle Inner", 10, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Spot Angle Outer", 40, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Color", flashlightColor, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Enabled Group", envlight_groupEnabled, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Groups", envlight_groups, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Shadow Type", 1, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Wrap", 0.0, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Shadow Quality", 3, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - HBAO Participation Type", 1, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Shadow Near Clip", 0.0, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Shadow Depth Bias", 0.0, kScene)
        Custom_AgentSetProperty(light_name, "EnvLight - Mobility", 2, kScene) --lets the light to move around
    end

    agent_gun_1 = AgentCreate("Rifle_1", "obj_gunAK47.prop", Vector(-0.56, 0.90, 0.11), Vector(90,0,-24), kScene, false, false)
    agent_gun_2 = AgentCreate("Rifle_2", "obj_gunAK47.prop", Vector(-0.56, 0.90, 0.11), Vector(90,0,-24), kScene, false, false)
    
    agent_bat = AgentCreate("Bat", "obj_batAluminum.prop", Vector(-0.541, 0.93, -0.03), Vector(10,-15,50), kScene, false, false)
    
    --wrist_L
    --wrist_R
    local nodeName = "wrist_R";
    if AgentHasNode(agent_anf_1, nodeName) then
        AgentAttachToNode(agent_gun_1, agent_anf_1, nodeName);
    end
    if AgentHasNode(agent_anf_2, nodeName) then
        AgentAttachToNode(agent_gun_2, agent_anf_2, nodeName);
    end
    if AgentHasNode("Javier", nodeName) then
        AgentAttachToNode(agent_bat, "Javier", nodeName);
    end
    Custom_AgentSetProperty("Bat",  "Runtime: Visible", false, kScene)
    
    
    
    Callback_OnPostUpdate:Add(gun_light_update);
    
    
    --MODE_FREECAM = true;

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
    
    --CutsceneEditor("demo_cutscene","sk61_tripp.prop");
    CutscenePlayer("demo_cutscene", 0, 1, 1);
    --CutscenePlayer("demo_cutscene", 3, 0, 1);


end










--custom functions




clip_81_played_once = 0;
clip_82_played_once = 0;

gun_1_check = 0;
gun_2_check = 0;
gun_1_timer = 0;
gun_2_timer = 0;

gun_light = function(gun_number)
    if gun_number == 1 then
        local gun_pos = AgentGetWorldPos("Pistol_1");
        Custom_SetAgentWorldPosition("flashlightTestLight_point_gun_1", gun_pos, kScene);
        gun_1_timer = GetTotalTime()+0.05;
        gun_1_check = 1;
    else
        local gun_pos = AgentGetWorldPos("Pistol_2");
        Custom_SetAgentWorldPosition("flashlightTestLight_point_gun_2", gun_pos, kScene);
        gun_2_timer = GetTotalTime()+0.05;
        gun_2_check= 1;
    end
end

gun_light_update = function()
    if gun_1_check == 1 then
        if GetTotalTime() > gun_1_timer then
            Custom_SetAgentWorldPosition("flashlightTestLight_point_gun_1", Vector(0, -1000, 0), kScene);
            gun_1_check = 0;
        end
    end

    if gun_2_check == 1 then
        if GetTotalTime() > gun_2_timer then
            Custom_SetAgentWorldPosition("flashlightTestLight_point_gun_2", Vector(0, -1000, 0), kScene);
            gun_2_check = 0;
        end
    end
end




persistent_data = {};
persistent_data_check = {};


--mood manager

moods = function()

    --QTE set up
    agent_demo_scene_qte = AgentCreate("agent_demo_scene_qte", "ui_nextTimeOn_titleLogo.prop", Vector(0, 0, 0), Vector(0,0,0), Custom_CutsceneDev_SceneObject, false, false)
    ShaderSwapTexture(agent_demo_scene_qte, "ui_nextTimeOn_titleLogo.d3dtx", "demo_scene_qte_e.d3dtx");
    --set properties, transparency, etc
    Custom_AgentSetProperty("agent_demo_scene_qte", "Render Depth Test", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_demo_scene_qte", "Render Depth Write", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_demo_scene_qte", "Render Depth Write Alpha", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_demo_scene_qte", "Render Layer", 95, Custom_CutsceneDev_SceneObject)
    AgentAttach("agent_demo_scene_qte", agent_name_cutsceneCamera);
    Custom_AgentSetProperty("agent_demo_scene_qte", "Render Axis Scale", Vector(1.8,1,1), Custom_CutsceneDev_SceneObject);
    Custom_SetAgentPosition("agent_demo_scene_qte", Vector(0,-4.5,22), Custom_CutsceneDev_SceneObject);
    Custom_SetAgentRotation("agent_demo_scene_qte", Vector(0,180,0), Custom_CutsceneDev_SceneObject);
    Custom_AgentSetProperty("agent_demo_scene_qte",  "Runtime: Visible", false, kScene)



    controller_amb = SoundPlay("S3_AMB_Richmond_Alley_Dusk");
    ControllerSetLooping(controller_amb, true);
    ControllerSetSoundVolume(controller_amb, 0.3);
    ControllerFadeIn(controller_amb, 2.0);

    controller_music1 = SoundPlay("music1_mus_loop_Neutral_21");
    ControllerSetSoundVolume(controller_music1, 0.3);
    

    mood_clip = 0;
    Callback_OnPostUpdate:Add(moods_update);
end

moods_update = function()
    if player_clip ~= mood_clip then
        mood_clip = player_clip;
        pcall(ControllerKill, mood_clem)
        pcall(ControllerKill, mood_javi)
        pcall(ControllerKill, mood_mari)
        pcall(ControllerKill, mood_gabe)

        if player_clip == 7 then
            mood_gabe = PlayAnimation("Gabe", "gabe_face_moodShockA");
            ControllerSetLooping(mood_gabe , true); 
            ControllerSetContribution(mood_gabe, 0.6);
        elseif player_clip == 26 then
            mood_gabe = PlayAnimation("Gabe", "gabe_face_moodAngryA");
            ControllerSetLooping(mood_gabe , true); 
            ControllerSetContribution(mood_gabe, 0.6);
        elseif player_clip == 27 then
            mood_mari = PlayAnimation("Mariana", "clementine_face_moodWorryA");
            ControllerSetLooping(mood_mari , true);
            ControllerSetContribution(mood_mari, 0.6); 
        elseif player_clip == 28 then
            mood_gabe = PlayAnimation("Gabe", "gabe_face_moodAngryB");
            ControllerSetLooping(mood_gabe , true); 
            ControllerSetContribution(mood_gabe, 0.6);
        elseif player_clip == 30 then
            mood_javi = PlayAnimation("Javier", "javier_face_moodSternA");
            ControllerSetLooping(mood_javi , true); 
            ControllerSetContribution(mood_javi, 0.6);
        elseif player_clip == 31 then
            mood_gabe = PlayAnimation("Gabe", "gabe_face_moodAngryC");
            ControllerSetLooping(mood_gabe , true); 
            ControllerSetContribution(mood_gabe, 0.6);
        --elseif player_clip == 33 then
        --    mood_javi = PlayAnimation("Javier", "javier_face_moodSternB");
        --    ControllerSetLooping(mood_javi , true); 
        --    ControllerSetContribution(mood_javi, 0.6);
        elseif player_clip == 35 then
            mood_javi = PlayAnimation("Javier", "javier_face_moodAngryE");
            ControllerSetLooping(mood_javi , true); 
            ControllerSetContribution(mood_javi, 0.6);
        elseif player_clip == 62 then
            mood_gabe = PlayAnimation("Gabe", "gabe_face_moodDoubtA");
            ControllerSetLooping(mood_gabe , true); 
            ControllerSetContribution(mood_gabe, 0.6);
        elseif player_clip == 63 then
            mood_mari = PlayAnimation("Mariana", "clementine_face_moodThinkA");
            ControllerSetLooping(mood_mari , true); 
            ControllerSetContribution(mood_mari, 0.6);
        elseif player_clip == 64 then
            mood_clem = PlayAnimation("Clementine", "clementine_face_moodFearB");
            ControllerSetLooping(mood_clem , true); 
            ControllerSetContribution(mood_clem, 0.6);
        elseif player_clip == 65 then
            mood_javi = PlayAnimation("Javier", "javier_face_moodWorryBX");
            ControllerSetLooping(mood_javi , true); 
            ControllerSetContribution(mood_javi, 0.6);
        elseif player_clip == 70 then
            mood_mari = PlayAnimation("Mariana", "clementine_face_moodWorryB");
            ControllerSetLooping(mood_mari , true); 
            ControllerSetContribution(mood_mari, 0.6);
        elseif player_clip == 75 then
            mood_gabe = PlayAnimation("Gabe", "gabe_face_moodFearC");
            ControllerSetLooping(mood_gabe , true); 
            ControllerSetContribution(mood_gabe, 0.6);
            mood_mari = PlayAnimation("Mariana", "clementine_face_moodFearA");
            ControllerSetLooping(mood_mari , true); 
            ControllerSetContribution(mood_mari, 0.6);
        elseif player_clip == 79 then
            mood_javi = PlayAnimation("Javier", "javier_face_moodPainC");
            ControllerSetLooping(mood_javi , true); 
            ControllerSetContribution(mood_javi, 0.6);

        end
    
    end




end

path_1 = function()

    local persistent_data_save = {path = 1};
    persistent_data.persistent = persistent_data_save;
    local persistent_data_path = "Custom_Cutscenes/demo_cutscene/persistent.ini";
    LIP.save(persistent_data_path, persistent_data);

end

path_2 = function()

    local persistent_data_save = {path = 2};
    persistent_data.persistent = persistent_data_save;
    local persistent_data_path = "Custom_Cutscenes/" .. player_name_of_the_cutscene .."/persistent.ini";
    LIP.save(persistent_data_path, persistent_data);
end


check_path_update = function()   

    if check_done == 0 then
        if GetTotalTime() > check_path_time then

            local persistent_data_path = "Custom_Cutscenes/" .. player_name_of_the_cutscene .."/persistent.ini";
            persistent_data_check = LIP.load(persistent_data_path);
            
            if persistent_data_check.persistent.path == 1 then
                chosen_text = 1;
            else
                chosen_text = 2;
            end
            check_done = 1;
        end
    end
end

check_path = function()
    check_done = 0;
    check_path_time = GetTotalTime() + 3;
    Callback_OnPostUpdate:Add(check_path_update);   

end
    
javi_eyes_look_clip_26 = function()
    clip_26_done = 0;
    clip_26_time = GetTotalTime() + 1.5;
    Callback_OnPostUpdate:Add(javi_eyes_look_clip_26_update);   
end
javi_eyes_look_clip_26_update = function()
    if clip_26_done == 0 then
        if GetTotalTime() < clip_26_time then
            Custom_SetAgentWorldPosition("obj_lookAtJavierEyes", Vector(0, 0, -1000), kScene);
        else
            clip_26_done = 1
        end
    end
end

gabe_animation_clip_32 = function()
    gabe_animation_clip_32_controller = PlayAnimation("Gabe", "sk61_javierStandA_armsOut_add");
    ControllerSetLooping(gabe_animation_clip_32_controller , false);
    mari_animation_clip_32_controller = PlayAnimation("Mariana", "sk62_clementineStandA_lookAround_add");
    ControllerSetLooping(mari_animation_clip_32_controller , false);
    
end


mari_animation_clip_41 = function()

    Custom_SetAgentWorldPosition("Javier", Vector(0, -1000, 0), kScene); -- Javier one-frame teleport fix

    clip_41_done = 0;
    clip_41_time = GetTotalTime() + 3.1;
   
    mari_animation_clip_41_controller_2 = PlayAnimation("Mariana", "sk62_clementineStandA_enragedGestureB_add");
    ControllerSetLooping(mari_animation_clip_41_controller_2 , false);

    Callback_OnPostUpdate:Add(mari_animation_clip_41_update);   
    
end

mari_animation_clip_41_update = function()
    if clip_41_done == 0 then
        if GetTotalTime() > clip_41_time then
            mari_animation_clip_41_controller_3 = PlayAnimation("Mariana", "sk62_clementineStandA_fingerJabFwdR_add");
            ControllerSetLooping(mari_animation_clip_41_controller_3 , false);
            mari_animation_clip_41_controller = PlayAnimation("Mariana", "a371251351");
            ControllerSetLooping(mari_animation_clip_41_controller , false); 
            local controller_sound = SoundPlay("a371251351");
            clip_41_done = 1;
        end
    end
end


mari_animation_clip_42 = function()
    clip_42_done = 0;
    clip_42_time = GetTotalTime() + 0.5;
    Callback_OnPostUpdate:Add(mari_animation_clip_42_update);   
    
end

mari_animation_clip_42_update = function()
    if clip_42_done == 0 then
        if GetTotalTime() > clip_42_time then
            mari_animation_clip_41_controller = PlayAnimation("Mariana", "a371251352");
            ControllerSetLooping(mari_animation_clip_41_controller , false); 
            local controller_sound = SoundPlay("a371251352");
            clip_42_done = 1;
        end
    end
end

music_clip_45 = function()
    controller_sting1 = SoundPlay("sting1_mus_sting_Tense_02");
    controller_music2 = SoundPlay("music2_mus_loop_Tense_30");
    ControllerSetSoundVolume(controller_music2, 0.4);
end

anm_clip_53 = function()
    anm_clip_53_controller = PlayAnimation("Eli", "sk61_javierStandA_lookAround_add");
    ControllerSetLooping(anm_clip_53_controller , false);    
end

anm_clip_54 = function()
    clip_55_done = 0;
    clip_55_time = GetTotalTime() + 3;
    anm_clip_54_controller = PlayAnimation("Rufus", "sk61_javierTense_lookBehindRight_add");
    ControllerSetLooping(anm_clip_54_controller , false);
    Callback_OnPostUpdate:Add(anm_clip_54_update);   
end


anm_clip_54_update = function()
    if clip_55_done == 0 then
        if GetTotalTime() < clip_55_time then
            Custom_SetAgentWorldPosition("obj_lookAtRufusEyes", Vector(1000, 0, 0), kScene);
        else
            clip_55_done = 1
        end
    end
end



voice_clip_56 = function()
    clip_56_done = 0;
    clip_56_time = GetTotalTime() + 2;
    Callback_OnPostUpdate:Add(voice_clip_56_update);   
end

voice_clip_56_update = function()
    if clip_56_done == 0 then
        if GetTotalTime() > clip_56_time then
            local controller_sound = SoundPlay("a371560889");
            clip_56_done = 1;
        end
    end
end


voice_clip_57 = function()
    clip_57_done = 0;
    clip_57_done_2 = 0;
    clip_57_time = GetTotalTime() + 2;
    clip_57_time_2 = GetTotalTime() + 4;
    Callback_OnPostUpdate:Add(voice_clip_57_update);   
end

voice_clip_57_update = function()
    if clip_57_done == 0 then
        if GetTotalTime() > clip_57_time then
            rufus_animation_clip_57_controller = PlayAnimation("Rufus", "a371560891");
            ControllerSetLooping(rufus_animation_clip_57_controller , false);
            local controller_sound = SoundPlay("a371560891");
            clip_57_done = 1;
        end
    end
    if clip_57_done_2 == 0 then
        if GetTotalTime() > clip_57_time_2 then
            eli_animation_clip_57_controller = PlayAnimation("Eli", "a371560892");
            ControllerSetLooping(eli_animation_clip_57_controller , false);
            local controller_sound = SoundPlay("a371560892");
            clip_57_done_2 = 1;
        end
    end
end


clem_anm_clip_60 = function()

    clip_60_done = 0;
    clip_60_time = GetTotalTime() + 1;
    Callback_OnPostUpdate:Add(clem_anm_clip_60_update);   

end

clem_anm_clip_60_update = function()
    if clip_60_done == 0 then
        if GetTotalTime() > clip_60_time then
            clem_anm_clip_60_controller = PlayAnimation("Clementine", "sk62_clementine400StandA_lookLeft_add");
            ControllerSetContribution(clem_anm_clip_60_controller, 0.5);
            ControllerSetLooping(clem_anm_clip_60_controller , false);
            clip_60_done = 1;
        end
    end
end


sounds_clip_66 = function()
    
    local controller_sound = SoundPlay("S4_Zombie_Nick_Low_2");

    controller_sting2 = SoundPlay("sting2_mus_sting_Tense_04");
    ControllerSetSoundVolume(controller_sting2, 0.4);
end



spawn_guns_clip_67 = function()
    mari_animation_clip_63_controller = PlayAnimation("Mariana", "sk62_clementineStandA_toTense");
    ControllerSetLooping(mari_animation_clip_63_controller , false); 
    ControllerSetContribution(mari_animation_clip_63_controller, 0.6);
    ControllerSetPriority(mari_animation_clip_63_controller, 300);
    
    agent_pistol_1 = AgentCreate("Pistol_1", "obj_gunM1911.prop", Vector(-0.05, 0.778, 0.25), Vector(90,95,0), kScene, false, false)--DO NOT get these numbers from starting clip
    agent_pistol_2 = AgentCreate("Pistol_2", "obj_gunP250.prop", Vector(-0.08, 0.87, 0.25), Vector(5,0,-60), kScene, false, false)--DO NOT get these numbers from starting clip

    Custom_SetAgentWorldPosition("Javier", Vector(0, 0, 0), kScene);
    Custom_SetAgentWorldPosition("Clementine", Vector(0, 0, 0), kScene);
    
    --wrist_L
    --wrist_R
    local nodeName = "wrist_R";
    if AgentHasNode("Javier", nodeName) then
        AgentAttachToNode(agent_pistol_1, "Javier", nodeName);
    end
    if AgentHasNode("Clementine", nodeName) then
        AgentAttachToNode(agent_pistol_2, "Clementine", nodeName);
    end

    controller_music3 = SoundPlay("music_3_mus_loop_Action_09b");
    ControllerSetSoundVolume(controller_music3, 0.4);
    ControllerSetLooping(controller_music3, true);
end


sounds_clip_68 = function()
    clip_68_done = 0;
    clip_68_time = GetTotalTime() + 0.5;
    clip_68_time_2 = GetTotalTime() + 0.8;
    clip_68_time_3 = GetTotalTime() + 1.5;
    clip_68_time_4 = GetTotalTime() + 2.1;
    clip_68_time_5 = GetTotalTime() + 3;
    clip_68_time_6 = GetTotalTime() + 3.4;
    clip_68_time_7 = GetTotalTime() + 3.9;
    clip_68_time_8 = GetTotalTime() + 4.2;
    clip_68_time_9 = GetTotalTime() + 4.6;
    clip_68_time_10 = GetTotalTime() + 4.8;

    clip_68_time_hit = 1.23
    clip_68_time_hit_2 = 2.06
    clip_68_time_hit_3 = 4
    local controller_sound = SoundPlay("S4_Zombie3D_LP_1")
    local controller_sound = SoundPlay("S4_GUN_Shot_Pistol_1911_Int_01");
    Callback_OnPostUpdate:Add(sounds_clip_68_update);   
end

sounds_clip_68_update = function()
    if clip_68_done ~= 10 then
        if clip_68_done == 0 then
            if GetTotalTime() > clip_68_time then
                local controller_sound = SoundPlay("S4_SFX_Clem_Gun_p250_Shot_2");
                gun_light(2);
                clip_68_done = 1;
            end
        elseif clip_68_done == 1 then
            if GetTotalTime() > clip_68_time_2 then
                local controller_sound = SoundPlay("S4_SFX_Clem_Gun_p250_Shot_1");
                gun_light(2);
                clip_68_done = 2;
            end
        elseif clip_68_done == 2 then
            if GetTotalTime() > clip_68_time_hit then
                local controller_sound = SoundPlay("S4_GUN_Shot_Pistol_1911_Int_03");
                gun_light(1);
                clip_68_done = 22;
            end
        elseif clip_68_done == 22 then
            if GetTotalTime() > clip_68_time_3 then
                local controller_sound = SoundPlay("S4_SFX_Clem_Gun_p250_Shot_3");
                gun_light(2);
                clip_68_done = 3;
            end
        elseif clip_68_done == 3 then
            if GetTotalTime() > clip_68_time_hit_2 then
                local controller_sound = SoundPlay("S4_GUN_Shot_Pistol_1911_Int_01");
                gun_light(1);
                clip_68_done = 33;
            end
        elseif clip_68_done == 33 then
            if GetTotalTime() > clip_68_time_4 then
                local controller_sound = SoundPlay("S4_SFX_Clem_Gun_p250_Shot_1");
                gun_light(2);
                clip_68_done = 4;
            end
        elseif clip_68_done == 4 then
            if GetTotalTime() > clip_68_time_5 then
                local controller_sound = SoundPlay("S4_GUN_Shot_Pistol_1911_Int_05");
                gun_light(1);
                clip_68_done = 5;
            end
        elseif clip_68_done == 5 then
            if GetTotalTime() > clip_68_time_6 then
                local controller_sound = SoundPlay("S4_GUN_Shot_Pistol_1911_Int_06");
                gun_light(1);
                clip_68_done = 6;
            end
        elseif clip_68_done == 6 then
            if GetTotalTime() > clip_68_time_7 then
                local controller_sound = SoundPlay("S4_SFX_Clem_Gun_p250_Shot_4");
                gun_light(2);
                clip_68_done = 7;
            end
        elseif clip_68_done == 7 then
            if GetTotalTime() > clip_68_time_hit_3 then
                local controller_sound = SoundPlay("S4_GUN_Shot_Pistol_1911_Int_04");
                gun_light(1);
                clip_68_done = 77;
            end
        elseif clip_68_done == 77 then
            if GetTotalTime() > clip_68_time_8 then
                local controller_sound = SoundPlay("S4_GUN_Shot_Pistol_1911_Int_07");
                gun_light(1);
                clip_68_done = 8;
            end
        elseif clip_68_done == 8 then
            if GetTotalTime() > clip_68_time_9 then
                local controller_sound = SoundPlay("S4_GUN_Shot_Pistol_1911_Int_02");
                gun_light(1);

                clip_68_done = 9;
            end
        elseif clip_68_done == 9 then
            if GetTotalTime() > clip_68_time_10 then
                local controller_sound = SoundPlay("S4_SFX_Clem_Gun_p250_Shot_5");
                gun_light(2);
                clip_68_done = 10;
            end
        end 
    end   
end


spawn_knife_clip_70 = function()
    --agent_knife_1 = AgentCreate("Knife_1", "obj_knifeKABAR.prop", Vector(-0.33, 0.8, 0.25), Vector(5,15,0), kScene, false, false) --DO NOT get these numbers from starting clip
    agent_knife_1 = AgentCreate("Knife_1", "obj_knifeKABAR.prop", Vector(-0.165, 0.705, 0.12), Vector(5,55,0), kScene, false, false) --DO NOT get these numbers from starting clip
    Custom_SetAgentWorldPosition("Mariana", Vector(0, 0, 0), kScene);
    Custom_SetAgentWorldRotation("Mariana", Vector(0.98, -326, 0), kScene);
    --wrist_L
    --wrist_R
    local nodeName = "wrist_R";
    if AgentHasNode("Mariana", nodeName) then
        AgentAttachToNode(agent_knife_1, "Mariana", nodeName); 
    end
    Custom_AgentSetProperty("Knife_1",  "Runtime: Visible", false, kScene)

    clip_70_done = 0;
    clip_70_time = GetTotalTime() + 0.6;
    Callback_OnPostUpdate:Add(spawn_knife_clip_70_update); 
    
end

spawn_knife_clip_70_update = function()
    if clip_70_done == 0 then
        if GetTotalTime() > clip_70_time then
            local controller_sound = SoundPlay("S4_sfx_draw_knife_sheath");
            Custom_AgentSetProperty("Knife_1",  "Runtime: Visible", true, kScene)
            clip_70_done = 1;
        end
    end
end


knife_re_pos_clip_71 = function()
    clip_71_done = 0;
    clip_71_done_stab1 = 0;
    clip_71_done_stab2 = 0;
    clip_71_done_body = 0;
    clip_71_time = GetTotalTime() + 2.5;
    clip_71_time_stab1 = GetTotalTime() + 1;
    clip_71_time_stab2 = GetTotalTime() + 2.66;
    clip_71_time_body = GetTotalTime() + 4;
    Callback_OnPostUpdate:Add(knife_re_pos_clip_71_update); 
end


knife_re_pos_clip_71_update = function()
    if clip_71_done == 0 then
        if GetTotalTime() > clip_71_time then

            Custom_SetAgentWorldRotation("Knife_1", Vector(235,235,0), kScene);
            clip_71_done = 1;
        end
        if clip_71_done_stab1 == 0 and GetTotalTime() > clip_71_time_stab1 then

            local controller_sound = SoundPlay("S4_sfx_stab_gore_blood_05");
            clip_71_done_stab1 = 1;
        end
    
    end
    if clip_71_done_stab2 == 0 then
        if GetTotalTime() > clip_71_time_stab2 then
            local controller_sound = SoundPlay("S4_sfx_stab_gore_blood_04");
            local controller_sound = SoundPlay("S3_NV_Mariana_fighting_alt07.wav");
            clip_71_done_stab2 = 1;
        end
    end
    if clip_71_done_body == 0 then
        if GetTotalTime() > clip_71_time_body then
            local controller_sound = SoundPlay("S4_SFX_bodyfall_8");
            clip_71_done_body = 1;
        end
    end

end



mari_anm_clip_73 = function()
    mari_animation_clip_73_controller = PlayAnimation("Mariana", "clementine_headGesture_nodYesQuick_add");
    ControllerSetLooping(mari_animation_clip_73_controller , false); 
    mari_animation_clip_73_controller_2 = PlayAnimation("Mariana", "clementine_headEyeGesture_lookLeft_add");
    ControllerSetLooping(mari_animation_clip_73_controller_2 , false); 
end




sounds_clip_74 = function()
    local controller_sound = SoundPlay("S4_ZombieBG_Scott_23");
end



mari_pos_correction_clip_75 = function()
    Custom_SetAgentWorldPosition("Mariana", Vector(0, 0, 0), kScene); -- Mari one-frame teleport fix
    Custom_SetAgentWorldPosition("Gabe", Vector(0, 0, 0), kScene); -- Gabe one-frame teleport fix
end 


sounds_clip_76 = function()
    local controller_sound = SoundPlay("S4_SFX_Clem_Gun_p250_Shot_4");
    gun_light(2);
    clip_76_time = GetTotalTime() + 0.66;
    clip_76_done = 0;   
    Callback_OnPostUpdate:Add(sounds_clip_76_update);   
end

sounds_clip_76_update = function()
    if clip_76_done == 0 then
        if GetTotalTime() > clip_76_time then
            gun_light(2);
            local controller_sound = SoundPlay("S4_SFX_Clem_Gun_p250_Shot_5");  
            clip_76_done = 1;
        end
    end
    
end

sounds_clip_77 = function()
    local controller_sound = SoundPlay("S4_ZombieBG_Scott_1");
    Callback_OnPostUpdate:Add(sounds_clip_78_update);   
end



sounds_clip_78_update = function()
    if clip_78_start == 0 then
        if clip_78_click1 == 0 then
            local controller_sound = SoundPlay("S4_SFX_Gun_Handle_ClickSlide_04");
            clip_78_click1 = 1;
        end
        if clip_78_click2 == 0 and GetTotalTime() > clip_78_time_click2 then
            local controller_sound = SoundPlay("S4_SFX_Gun_Handle_ClickSlide_04");
            clip_78_click2 = 1;
        end
    end
end

sounds_clip_78 = function()
    clip_78_click1 = 0;
    clip_78_click2 = 0;
    clip_78_time_click2 = GetTotalTime() + 0.66;
    clip_78_start = 0;   
end



gun_visible_clip_78 = function()
    Custom_AgentSetProperty("Pistol_1",  "Runtime: Visible", true, kScene)
    Custom_AgentSetProperty("Bat",  "Runtime: Visible", false, kScene)
    sounds_clip_78();
end

knife_re_pos_clip_80 = function()
    Custom_SetAgentWorldRotation("Knife_1", Vector(30,-295,-45), kScene);
end


spawn_bat_clip_81 = function()
    
    Custom_AgentSetProperty("Pistol_1",  "Runtime: Visible", false, kScene)
    Custom_AgentSetProperty("Bat",  "Runtime: Visible", true, kScene)
    --QTE stuff
    Custom_AgentSetProperty("agent_demo_scene_qte",  "Runtime: Visible", true, kScene)
    clip_81_time = GetTotalTime() + 3.5;
    clip_81_time_2 = GetTotalTime() + 3.7;
    clip_81_done = 0;
    QTE_done = 0;
    if clip_81_played_once == 0 then
        Callback_OnPostUpdate:Add(clip_81_QTE_update); 
        clip_81_played_once = 1;
    end
end

clip_81_QTE_update = function()
    if clip_81_done == 0 then
        if GetTotalTime() > clip_81_time and QTE_done == 1 then
            chosen_text = 1;
            clip_81_done = 1;
        elseif Custom_InputKeyPress(69) then -- Check if E is pressed 
            QTE_done = 1;
            Custom_AgentSetProperty("agent_demo_scene_qte",  "Runtime: Visible", false, kScene)
        end
    end
    if GetTotalTime() > clip_81_time_2 then
        clip_81_done = 1;
    end
end

snd_clip_82 = function()
    Custom_AgentSetProperty("agent_demo_scene_qte",  "Runtime: Visible", false, kScene)
    clip_82_done = 0;
    clip_82_time = GetTotalTime() + 1.2;
    if clip_82_played_once == 0 then
        Callback_OnPostUpdate:Add(snd_clip_82_update);  
        clip_82_played_once = 1;
    end
end

snd_clip_82_update = function()
    if clip_82_done == 0 then
        if GetTotalTime() > clip_82_time then
            local controller_sound = SoundPlay("a371257243");
            local controller_sound = SoundPlay("S2_gore_eating4");
            clip_82_done = 1;
        end
    end
end

qte_disable_clip_83= function()
    Custom_AgentSetProperty("agent_demo_scene_qte",  "Runtime: Visible", false, kScene)
end


weapons_visible_clip_84 = function()
    Custom_AgentSetProperty("Knife_1",  "Runtime: Visible", false, kScene)
    Callback_OnPostUpdate:Add(weapons_visible_clip_84_update);   
    clip_84_done = 0;
    clip_84_time = GetTotalTime() + 1; 
end

weapons_visible_clip_84_update = function()
    if clip_84_done == 0 then
        if GetTotalTime() > clip_84_time then
            Custom_AgentSetProperty("Bat",  "Runtime: Visible", false, kScene)
            clip_84_done = 1;
        end
    end
    
end

shot_clip_85 = function()
    clip_85_done = 0;
    clip_85_time = GetTotalTime() + 1.5;
    Callback_OnPostUpdate:Add(shot_clip_85_update);   
end

shot_clip_85_update= function()
    if clip_85_done == 0 then
        if GetTotalTime() > clip_85_time then
            clem_animation_clip_85_controller = PlayAnimation("Clementine", "sk61_javierStandAAimPistol_fire_add");
            gun_light(2);
            local controller_sound = SoundPlay("S4_SFX_Clem_Gun_p250_Shot_1");
            ControllerKill(controller_music3);
            controller_sting3 = SoundPlay("sting3_mus_sting_Tense_07");
            ControllerSetSoundVolume(controller_sting3, 0.5);
            ControllerSetLooping(clem_animation_clip_85_controller , false); 
            clip_85_done = 1;
        end
    end  
end


cutscene_end_clip_88 = function()
    SubProject_Switch("Menu", "Menu_main.lua")
end




--open the scene with this script
SceneOpen(kScene, kScript);