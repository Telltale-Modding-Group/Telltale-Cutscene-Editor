--[[
-------------------------------------------------------------------------
This script is the main level script for the cutscene.
It also contains the main logic in here that I created for doing a cutscene.

It's worth noting for this ctuscene script, it is bascially implemented in its own completely original level, and not an existing level script.
Granted, you can still implement this kind of cutscene logic into an existing level script, however for the sake of exploration and simplicity I created my own.

The basic process of making/creating a cutscene goes something like this.
- Take an existing TWD level (preferably something close to what is intended).
- Completely strip all of the agents in the original scene that we don't need.
- Instantiate our own agents into the scene (those can be enviorment assets, characters, objects, etc.)
- Setup our cutscene content (cameras, angles, sequence clips, audio, etc.)
- Finally, we have update functions where we programmatically create and do things during the cutscene (camera work, acting)

Is there are better way to do this? If you are telltale dev yes... 
But we are not and don't have your chore editor... so we have to make do with lua scripting at the moment.

CUTSCENE SYSTEM EXPLANATION
For sequencing I have a basic psudeo timeline objects. 
You will see those in the script and they go by the names of [sequence_clips] and [sequence_cameraAngles].
There are a few more but to elaborate on but I'll go over how this sequencing system works. 
Also worth noting that we don't have a chore editor yet, so have to make do with lua scripting at the moment.

1. For the sequencing we have a time sequence value variable that gets incremented 1 every single frame. - (could I have actually grabbed the game time? yes, that does exist however I did it this way first and it worked... in a newer version of this psudeo system I will definetly try to attempt to use it)
2. This time sequence variable is [sequence_currentTimer] and it basically acts as our psudeo playhead. - (but not quite with the way I coded it and you'll see later)
3. [sequence_clips] contains an array of clip objects, these will be accessed sequentially as the scene goes on.
4. [sequence_cameraAngles] contains an array of camera angle objects.
5. The camera angles are referenced by the sequence clips by the variable [angleIndex] inside the clip object. - (normally I geuss you would include this camera data inside the clip object, however I kept it seperate because we often in cinema cut back to shots thta have these angles)
6. For the current clip that we are on, the object also has a [shotDuration] field which obviously tells us how long the shot will last.
7. When the playhead value [sequence_currentTimer] reaches the end of the current clip [shotDuration].
8. we then move on to the next shot in the sequence by incrementing [sequence_currentShotIndex] and by also resetting [sequence_currentTimer] back to zero. - (Yes, you could change it so [sequence_currentTimer] keeps counting as the game goes on, or again also use the actual game time value which we have access to, but this is the way I did it first :P but also didn't really want to deal with very long numbers)
9. when we do that, now our current clip is the next shot in the sequence, and this cycle repeats until the sequence effectively ends.
]]--

--include our custom scripts/extensions
--these scripts contain a ton of functionality and useful functions to make things easier for us.

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
local kScript = "DemoScene"; --(the name of this script and also the name of the level function at the bottom of the script, which will be called as soon as this scene opens)
local kScene = "adv_richmondStreet"; --(the name of the scene asset file)
local agent_name_scene = "adv_richmondStreet.scene"; --(this is the name of the scene agent object, using it to set post processing effects later)




--cutscene development variables variables (these are variables required by the development scripts)
Custom_CutsceneDev_SceneObject = kScene; --dont touch (the development scripts need to reference the main level)
Custom_CutsceneDev_SceneObjectAgentName = agent_name_scene; --dont touch (the development scripts also need to reference the name of the scene agent)
Custom_CutsceneDev_UseSeasonOneAPI = false; --dont touch (this is leftover but if the development tools were implemented inside season 1 we need to use the S1 functions because the api changes)
Custom_CutsceneDev_FreecamUseFOVScale = false; --changes the camera zooming from modifing the FOV directly, to modifying just the FOV scalar (only useful if for some reason the main field of view property is chorelocked or something like that)



--cutscene variables
local MODE_FREECAM = false; --enable freecam rather than the cutscene camera
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
--now starting to get into the actual juice...
--this section contains a bunch of setup functions that are basically here to get things ready for use when we need them during the actual cutscene itself.

--creates a camera that will be used for the cutscene (yes usually you create multiple but I haven't wrapped my head around how your camera layer stack system works telltale!)
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
    --AgentSetPos(cameraAgent, Vector(0,0,0));
    --AgentSetRot(cameraAgent, Vector(0,0,0));


    --Custom_SetAgentWorldPosition(agent_name_cutsceneCameraParent , Vector(-3.609,1.401,-4.179), kScene);
    --Custom_SetAgentWorldRotation(agent_name_cutsceneCameraParent , Vector(5.166,160.948,0), kScene);


    --AgentSetPos(cameraAgent, Vector(-3.609,1.401,-4.179));
    --AgentSetRot(cameraAgent, Vector(5.166,160.948,0));
    
    --set the clipping planes of the camera (in plain english, how close the camera can see objects, and how far the camera can see)
    --if the near is set too high we start loosing objects in the foreground.
    --if the far is set to low we will only see part or no skybox at all
    Custom_AgentSetProperty(agent_name_cutsceneCamera, "Clip Plane - Far", 2500, kScene);
    Custom_AgentSetProperty(agent_name_cutsceneCamera, "Clip Plane - Near", 0.05, kScene);

    --bulk remove the original cameras that were in the scene
    Custom_RemovingAgentsWithPrefix(kScene, "cam_");

    --push our new current camera to the scene camera layer stack (since we basically removed all of the original cameras just the line before this)
    CameraPush(agent_name_cutsceneCamera);
end

--sets up our cutscene objects
Cutscene_SetupCutsceneContent = function()
    --find the character objects in the scene, we are going to need them during the cutscene so we need to get them (you could also get them during update but that wouldn't be performance friendly)


end





--'ControllerStop' or ControllerPause; ControllerIsPlaying; AnimationGetLength("animation.anm"); AgentDuplicate

--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE UPDATE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE UPDATE ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| CUTSCENE UPDATE ||||||||||||||||||||||||||||||||||||||||||||||




--main level script, this function gets called when the scene loads
--its important we call everything here and set up everything so our work doesn't go to waste
DemoScene = function()
    ---debug


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


    Custom_SetAgentWorldPosition("Tripp", Vector(0, -1000, 0), kScene);
    Custom_SetAgentWorldPosition("Kate", Vector(0, -1000, 0), kScene);
    Custom_SetAgentWorldPosition("Conrad", Vector(0, -1000, 0), kScene);
    Custom_SetAgentWorldPosition("Eleanor", Vector(0, -1000, 0), kScene);
    Custom_SetAgentWorldPosition("Jesus", Vector(0, -1000, 0), kScene);
    
    --light for Act 1 ANF guards and Mariana
    local flashlightColor = RGBColor(255, 255, 255, 50)
    local envlight_groupEnabled = AgentGetProperty("light_Directional", "EnvLight - Enabled Group", kScene)
    local envlight_groups = AgentGetProperty("light_Directional", "EnvLight - Groups", kScene)
    local flashlightTestLight_spot = AgentCreate("flashlightTestLight_spot", "module_env_light.prop", Vector(0,1.8,2), Vector(160, 0, 0), kScene, false, false)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Type", 1, kScene) --0 point light, 1 spot light
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Intensity", 1, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Enlighten Intensity", 0, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Radius", 80, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Distance Falloff", 1, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Spot Angle Inner", 10, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Spot Angle Outer", 90, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Color", flashlightColor, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Enabled Group", envlight_groupEnabled, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Groups", envlight_groups, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot", "EnvLight - Shadow Type", 0, kScene)
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
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Shadow Type", 0, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Wrap", 0.0, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Shadow Quality", 3, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - HBAO Participation Type", 2, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Shadow Near Clip", 0.0, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Shadow Depth Bias", -0.5, kScene)
    Custom_AgentSetProperty("flashlightTestLight_spot_2", "EnvLight - Mobility", 2, kScene) --lets the light to move around
    AgentAttach("flashlightTestLight_spot_2", "Mariana");




    agent_gun_1 = AgentCreate("Rifle_1", "obj_gunAK47.prop", Vector(-0.56, 0.90, 0.11), Vector(90,0,-24), kScene, false, false)
    agent_gun_2 = AgentCreate("Rifle_2", "obj_gunAK47.prop", Vector(-0.56, 0.90, 0.11), Vector(90,0,-24), kScene, false, false)
    
    --wrist_L
    --wrist_R
    local nodeName = "wrist_R";
    if AgentHasNode(agent_anf_1, nodeName) then
        AgentAttachToNode(agent_gun_1, agent_anf_1, nodeName);
    end
    if AgentHasNode(agent_anf_2, nodeName) then
        AgentAttachToNode(agent_gun_2, agent_anf_2, nodeName);
    end
    
    
    
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
    CutscenePlayer("demo_cutscene", 0);
    --CutscenePlayer("demo_cutscene", 50); 

    -- clip 25 and before -- works, 26 and beyond - breaks

--;b,o,u,t,p,n,j

end

--custom functions

persistent_data = {};
persistent_data_check = {};


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

    Custom_SetAgentWorldPosition("Javier", Vector(-0.62880742549896, 0, 1.3940000534058), kScene); -- Javier one-frame teleport fix

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


--open the scene with this script



SceneOpen(kScene, kScript);