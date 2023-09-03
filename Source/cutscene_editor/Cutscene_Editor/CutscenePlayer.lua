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





KTBM_TextUI_IsCursorOverBounds = function(vector_originPosition, vector_extentsMin, vector_extentsMax)
    local vector_cursorPos = CursorGetPos();

    local vector_offsetExtentsMin = VectorAdd(vector_originPosition, vector_extentsMin);
    local vector_offsetExtentsMax = VectorAdd(vector_originPosition, vector_extentsMax);
    
    local case1 = vector_cursorPos.x >= vector_offsetExtentsMin.x;
    local case2 = vector_cursorPos.y >= vector_offsetExtentsMin.y;
    local case3 = vector_cursorPos.y <= vector_offsetExtentsMax.y;
    local case4 = vector_cursorPos.x <= vector_offsetExtentsMax.x;
    
    local finalCase = case1 and case2 and case3 and case4;
    
    return finalCase;
end

--general fucntion to create text objects (used for choice texts)
local CreateTextAgent = function(name, text, posx, posy, posz, halign, valign)
    local pos       = Vector(posx, posy, posz)
    local textAgent = AgentCreate(name, "ui_text.prop", pos)

    if halign then
        TextSetHorizAlign(textAgent, halign)
    end
    
    if valign then
        TextSetVertAlign(textAgent, valign)
    end
    
    TextSet(textAgent, text)
    
    AgentSetProperty(textAgent, "Text Render Layer", 99)
    
    return textAgent
end

--to change controls
--find button here: https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
--change to number: https://www.rapidtables.com/convert/number/hex-to-decimal.html

player_AnimationPrewierPlay = function(player_agent_name_2, ii) --set and play animation controller on the ii agent
    --ControllerKill(player_animationPreview[ii]);
    --ControllerKill(player_animationPreviewDummy[ii]);

    player_animationPreview[ii] = PlayAnimation(player_agent_name_2, tostring(player_save_data[ii].anm));
    ControllerSetContribution(player_animationPreview[ii], 1);
    ControllerSetPriority(player_animationPreview[ii], 200);
    ControllerSetLooping(player_animationPreview[ii], true);



    local dummy_name = "Dummy" .. tostring(ii);
    player_animationPreviewDummy[ii] = PlayAnimation(dummy_name, tostring(player_save_data[ii].anm));
    ControllerSetContribution(player_animationPreviewDummy[ii], 1);
    ControllerSetPriority(player_animationPreviewDummy[ii], 200);
    if player_save_data[ii].mode == 2 then
        ControllerSetLooping(player_animationPreviewDummy[ii] , false);
    else
        ControllerSetLooping(player_animationPreviewDummy[ii] , true);
    end
    
end


player_resetAnimation = function(ii)
    --ControllerKill(player_animationPreview[ii]);
    --ControllerKill(player_animationPreviewDummy[ii]);


    local player_agent_name = player_agents_data.agents_names[ii];
    local player_LoadAgentPos = Vector(player_save_data[ii].pos_x, player_save_data[ii].pos_y, player_save_data[ii].pos_z);
    Custom_SetAgentWorldPosition(player_agent_name, player_LoadAgentPos, Custom_CutsceneDev_SceneObject);
    local player_LoadAgentRot = Vector(player_save_data[ii].rot_x, player_save_data[ii].rot_y, player_save_data[ii].rot_z);
    Custom_SetAgentRotation(player_agent_name, player_LoadAgentRot, Custom_CutsceneDev_SceneObject);
    local dummy_name = "Dummy" .. tostring(ii);
    Custom_SetAgentWorldPosition(dummy_name, Vector(0, 0, 0), Custom_CutsceneDev_SceneObject);
    Custom_SetAgentRotation(dummy_name, Vector(0, 0, 0), Custom_CutsceneDev_SceneObject);
end



CutscenePlayer = function(name_of_the_cutscene, clip_to_start_from)
    
    player_name_of_the_cutscene = name_of_the_cutscene;
    local player_cutscene_names_path = "Custom_Cutscenes/" .. player_name_of_the_cutscene .."/player.ini";
    player_cutscene_data = LIP.load(player_cutscene_names_path); --cutscene data, info from player file
    
    local player_agents_names_path = "Custom_Cutscenes/" .. player_name_of_the_cutscene .."/agents.ini";
    player_agents_data = LIP.load(player_agents_names_path); --agents data, info from agents file, controls agent indexes
    
    player_n_n = #(player_agents_data.agents_names);

    player_clip = clip_to_start_from;


    player_Dummy_array = {}
    for i = 1, player_n_n do
        local dummy_name = "Dummy" .. tostring(i);
        player_Dummy_array[i] = AgentCreate(dummy_name, "dummy.prop", Vector(0, 0, 0), Vector(0,0,0), Custom_CutsceneDev_SceneObject, false, false);
        --local dummy_controller_test = PlayAnimation(dummy_name, "sk55_jane_walkHoldBabySnowstorm.anm");
        --ControllerKill(dummy_controller_test);
    end

    
    local player_clip_names_path =  "Custom_Cutscenes/" .. player_name_of_the_cutscene .. "/" .. tostring(player_clip) ..".ini";;
    player_save_data = LIP.load(player_clip_names_path); --clip data
    
    player_start_time = GetTotalTime();
    player_clip_finished = 0;

    --for movement
    --move_to_pos_finish = {};
    --move_to_rot_finish = {};
    move_start_time_pos = {};
    move_start_time_rot = {};
    root_iteration = {};
    DummyPosNew = {};
    DummyRotNew = {};
    --root_reset = {};

    for i = 1, player_n_n do
        --move_to_pos_finish[i] = 0;
        --move_to_rot_finish[i] = 0;
        move_start_time_pos[i] = GetTotalTime();
        move_start_time_rot[i] = GetTotalTime();
        root_iteration[i] = 0;
        local dummy_name = "Dummy" .. tostring(i);
        DummyPosNew[i] = AgentGetPos(dummy_name);
        --root_reset[i] = 0;
    end
    move_start_time_pos_camera = GetTotalTime();
    move_start_time_rot_camera = GetTotalTime();
    OffSet_y = {};

    --animation controllers arrays
    player_animationPreview = {};
    player_animationPreviewDummy = {};






    --choice UI
    --make agents
    agent_choice_ui_1 = AgentCreate("agent_choice_ui_1", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0,0,0), Custom_CutsceneDev_SceneObject, false, false)
    agent_choice_ui_2 = AgentCreate("agent_choice_ui_2", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0,0,0), Custom_CutsceneDev_SceneObject, false, false)
    agent_choice_ui_3 = AgentCreate("agent_choice_ui_3", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0,0,0), Custom_CutsceneDev_SceneObject, false, false)
    agent_choice_ui_4 = AgentCreate("agent_choice_ui_4", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0,0,0), Custom_CutsceneDev_SceneObject, false, false)
        
    --set UI textures
    ShaderSwapTexture(agent_choice_ui_1, "ui_boot_title.d3dtx", "custom_cutscene_choice_ui.d3dtx");
    ShaderSwapTexture(agent_choice_ui_2, "ui_boot_title.d3dtx", "custom_cutscene_choice_ui.d3dtx");
    ShaderSwapTexture(agent_choice_ui_3, "ui_boot_title.d3dtx", "custom_cutscene_choice_ui.d3dtx");
    ShaderSwapTexture(agent_choice_ui_4, "ui_boot_title.d3dtx", "custom_cutscene_choice_ui.d3dtx");

    --set properties, transparency, etc
    --Custom_AgentSetProperty("agent_choice_ui_1", "Render After Anti-Aliasing", true, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_1", "Render Depth Test", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_1", "Render Depth Write", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_1", "Render Depth Write Alpha", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_1", "Render Layer", 95, Custom_CutsceneDev_SceneObject)
    
    --Custom_AgentSetProperty("agent_choice_ui_2", "Render After Anti-Aliasing", true, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_2", "Render Depth Test", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_2", "Render Depth Write", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_2", "Render Depth Write Alpha", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_2", "Render Layer", 95, Custom_CutsceneDev_SceneObject)

    --Custom_AgentSetProperty("agent_choice_ui_3", "Render After Anti-Aliasing", true, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_3", "Render Depth Test", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_3", "Render Depth Write", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_3", "Render Depth Write Alpha", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_3", "Render Layer", 95, Custom_CutsceneDev_SceneObject)

    --Custom_AgentSetProperty("agent_choice_ui_4", "Render After Anti-Aliasing", true, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_4", "Render Depth Test", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_4", "Render Depth Write", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_4", "Render Depth Write Alpha", false, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty("agent_choice_ui_4", "Render Layer", 95, Custom_CutsceneDev_SceneObject)
    
    --attach to camera
    AgentAttach("ui_boot_title", "myNewFreecamera");
    AgentAttach("agent_choice_ui_1", agent_name_cutsceneCamera);
    AgentAttach("agent_choice_ui_2", agent_name_cutsceneCamera);
    AgentAttach("agent_choice_ui_3", agent_name_cutsceneCamera);
    AgentAttach("agent_choice_ui_4", agent_name_cutsceneCamera);

    --set position, scale and rotation
    --left up
    Custom_AgentSetProperty("agent_choice_ui_1", "Render Axis Scale", Vector(1,0.25,1), Custom_CutsceneDev_SceneObject);
    Custom_SetAgentPosition("agent_choice_ui_1", Vector(5,-3,22), Custom_CutsceneDev_SceneObject)
    Custom_SetAgentRotation("agent_choice_ui_1", Vector(0,180,0), Custom_CutsceneDev_SceneObject);
    --right up
    Custom_AgentSetProperty("agent_choice_ui_2", "Render Axis Scale", Vector(1,0.25,1), Custom_CutsceneDev_SceneObject);
    Custom_SetAgentPosition("agent_choice_ui_2", Vector(-5,-3,22), Custom_CutsceneDev_SceneObject)
    Custom_SetAgentRotation("agent_choice_ui_2", Vector(0,180,0), Custom_CutsceneDev_SceneObject);
    --left down
    Custom_AgentSetProperty("agent_choice_ui_3", "Render Axis Scale", Vector(1,0.25,1), Custom_CutsceneDev_SceneObject);
    Custom_SetAgentPosition("agent_choice_ui_3", Vector(5,-5,22), Custom_CutsceneDev_SceneObject)
    Custom_SetAgentRotation("agent_choice_ui_3", Vector(0,180,0), Custom_CutsceneDev_SceneObject);
    --right down
    Custom_AgentSetProperty("agent_choice_ui_4", "Render Axis Scale", Vector(1,0.25,1), Custom_CutsceneDev_SceneObject);
    Custom_SetAgentPosition("agent_choice_ui_4", Vector(-5,-5,22), Custom_CutsceneDev_SceneObject)
    Custom_SetAgentRotation("agent_choice_ui_4", Vector(0,180,0), Custom_CutsceneDev_SceneObject);



    --text

    --calculations for text size

    --for left texts (1 and 3)

    --x = 4.9 for 1 symbol
    --x = 6.1 for 16 symbols
    --therefore step = 0.08 for each additional symbol
    --x = 9.2 for maximum - most left

    --for right texts (2 and 4)

    --x = -4.7 for 1 symbol
    --x = -3.5 for 16 symbols
    --therefore step = 0.08 for each additional symbol
    --x = -0.4 for maximum - most left

    agent_choice_ui_text_1 = CreateTextAgent("agent_choice_ui_text_1", "UI Choice Text 1", 0.0, 0.0, 0, 0, 0);
    AgentAttach("agent_choice_ui_text_1", agent_name_cutsceneCamera);
    Custom_SetAgentPosition("agent_choice_ui_text_1", Vector(6.1,-2.71,21), Custom_CutsceneDev_SceneObject)
    Custom_SetAgentRotation("agent_choice_ui_text_1", Vector(0,180,0), Custom_CutsceneDev_SceneObject);
    TextSetScale(agent_choice_ui_text_1, 0.75);

    agent_choice_ui_text_2 = CreateTextAgent("agent_choice_ui_text_2", "UI Choice Text 2", 0.0, 0.0, 0, 0, 0);
    AgentAttach("agent_choice_ui_text_2", agent_name_cutsceneCamera);
    Custom_SetAgentPosition("agent_choice_ui_text_2", Vector(-3.5,-2.71,21), Custom_CutsceneDev_SceneObject)
    Custom_SetAgentRotation("agent_choice_ui_text_2", Vector(0,180,0), Custom_CutsceneDev_SceneObject);
    TextSetScale(agent_choice_ui_text_2, 0.75);

    agent_choice_ui_text_3 = CreateTextAgent("agent_choice_ui_text_3", "UI Choice Text 3", 0.0, 0.0, 0, 0, 0);
    AgentAttach("agent_choice_ui_text_3", agent_name_cutsceneCamera);
    Custom_SetAgentPosition("agent_choice_ui_text_3", Vector(6.1,-4.65,21), Custom_CutsceneDev_SceneObject)
    Custom_SetAgentRotation("agent_choice_ui_text_3", Vector(0,180,0), Custom_CutsceneDev_SceneObject);
    TextSetScale(agent_choice_ui_text_3, 0.75);

    agent_choice_ui_text_4 = CreateTextAgent("agent_choice_ui_text_4", "UI Choice Text 4", 0.0, 0.0, 0, 0, 0);
    AgentAttach("agent_choice_ui_text_4", agent_name_cutsceneCamera);
    Custom_SetAgentPosition("agent_choice_ui_text_4", Vector(-3.5,-4.65,21), Custom_CutsceneDev_SceneObject)
    Custom_SetAgentRotation("agent_choice_ui_text_4", Vector(0,180,0), Custom_CutsceneDev_SceneObject);
    TextSetScale(agent_choice_ui_text_4, 0.75);

    agent_choice_ui_timer = CreateTextAgent("agent_choice_ui_timer", "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––", 0.0, 0.0, 0, 0, 0);
    AgentAttach("agent_choice_ui_timer", agent_name_cutsceneCamera);
    Custom_SetAgentPosition("agent_choice_ui_timer", Vector(7,-6,21), Custom_CutsceneDev_SceneObject)
    Custom_SetAgentRotation("agent_choice_ui_timer", Vector(0,180,0), Custom_CutsceneDev_SceneObject);
    TextSetScale(agent_choice_ui_timer, 0.75);


    chosen_text = 0;
    SwitchDelay = 0;






    Callback_OnPostUpdate:Add(CutscenePlayerUpdate);

end



CutscenePlayerUpdate = function()
    --debug
    --local highlightedText = "IF YOU SEE THIS IT STARTED!!";
    --TextSet(Custom_CutsceneDev_CutsceneToolsHighlightText, highlightedText);
    --AgentSetWorldPos(Custom_CutsceneDev_CutsceneToolsHighlightText, Vector(100, 100, 100));


    --player_cutscene_data
    --player_agents_data
    --player_save_data
    if (GetTotalTime() > (player_cutscene_data[player_clip].duration + player_start_time)) or chosen_text > 0 then -- switch to next clip
        
        
        if chosen_text == 0 then
            player_clip = player_cutscene_data[player_clip].next_clip;
        elseif chosen_text == 1 then
            player_clip = player_cutscene_data[player_clip].next_choice1;
        elseif chosen_text == 2 then
            player_clip = player_cutscene_data[player_clip].next_choice2;
        elseif chosen_text == 3 then
            player_clip = player_cutscene_data[player_clip].next_choice3;
        elseif chosen_text == 4 then
            player_clip = player_cutscene_data[player_clip].next_choice4;
        end
        chosen_text = 0;
        local player_clip_names_path =  "Custom_Cutscenes/" .. player_name_of_the_cutscene .. "/" .. tostring(player_clip) ..".ini";;

        
        player_start_time = GetTotalTime(); --reset timer
        player_save_data = LIP.load(player_clip_names_path); --next clip data
        
        --for movement
        for i = 1, player_n_n do
            ControllerKill(player_animationPreview[i]);
            ControllerKill(player_animationPreviewDummy[i]);
            player_resetAnimation(i);
            --root_reset[i] = 0;
            
            --move_to_pos_finish[i] = 0;
            --move_to_rot_finish[i] = 0;
            move_start_time_pos[i] = GetTotalTime();
            move_start_time_rot[i] = GetTotalTime();


            --reset pos to prevent animation single frame mess ups when killing controllers
            
            --player_resetAnimation(i);
            root_iteration[i] = 0;
            local dummy_name = "Dummy" .. tostring(i);
            DummyPosNew[i] = AgentGetPos(dummy_name); -- for mode 2, important, do not remove
            DummyRotNew[i] = AgentGetRot(dummy_name);
            --local player_agent_name = player_agents_data.agents_names[i];
            --local player_LoadAgentPos = Vector(player_save_data[i].pos_x, player_save_data[i].pos_y, player_save_data[i].pos_z);
            --Custom_SetAgentWorldPosition(player_agent_name, player_LoadAgentPos, Custom_CutsceneDev_SceneObject);
            --local player_LoadAgentRot = Vector(player_save_data[i].rot_x, player_save_data[i].rot_y, player_save_data[i].rot_z);
            --Custom_SetAgentRotation(player_agent_name, player_LoadAgentRot, Custom_CutsceneDev_SceneObject);
            --local dummy_name = "Dummy" .. tostring(i);
            --Custom_SetAgentWorldPosition(dummy_name, Vector(0, 0, 0), Custom_CutsceneDev_SceneObject);
            --Custom_SetAgentRotation(dummy_name, Vector(0, 0, 0), Custom_CutsceneDev_SceneObject);
        
        
        end

        local player_LoadAgentPos = Vector(player_save_data.camera.pos_x, player_save_data.camera.pos_y, player_save_data.camera.pos_z);
        Custom_SetAgentWorldPosition(agent_name_cutsceneCamera, player_LoadAgentPos, Custom_CutsceneDev_SceneObject);
        local player_LoadAgentRot = Vector(player_save_data.camera.rot_x, player_save_data.camera.rot_y, player_save_data.camera.rot_z);
        Custom_SetAgentRotation(agent_name_cutsceneCamera, player_LoadAgentRot, Custom_CutsceneDev_SceneObject);





        move_start_time_pos_camera = GetTotalTime();
        move_start_time_rot_camera = GetTotalTime();
        player_clip_finished = 0; --reset for one time stuff
    else
        --every frame stuff
        for i = 1, player_n_n do
            local player_agent_name = player_agents_data.agents_names[i];
            if player_save_data[i].mode == 0 then
                if player_save_data[i].speed == 0 then
                    --move_to_pos_finish[i] = 1;
                    local player_LoadAgentPos = Vector(player_save_data[i].pos_x, player_save_data[i].pos_y, player_save_data[i].pos_z);
                    Custom_SetAgentWorldPosition(player_agent_name, player_LoadAgentPos, Custom_CutsceneDev_SceneObject);
                    
                else --Move_To control
                    local Position1 = Vector(player_save_data[i].pos_x, player_save_data[i].pos_y, player_save_data[i].pos_z);
                    local Position2 = Vector(player_save_data[i].move_to_x, player_save_data[i].move_to_y, player_save_data[i].move_to_z);
                    

                    local length_x = Position2.x - Position1.x;
                    local length_y = Position2.y - Position1.y;
                    local length_z = Position2.z - Position1.z;


                    if GetTotalTime() > (move_start_time_pos[i] + player_save_data[i].speed) then
                        --move_to_pos_finish[i] = 1;
                        --if move_to_rot_finish[i] == 1 then

                            --move_start_time_pos[i] = GetTotalTime();
                            --local player_LoadAgentPos = Vector(player_save_data[i].pos_x, player_save_data[i].pos_y, player_save_data[i].pos_z);
                            local player_LoadAgentPos = Vector(player_save_data[i].move_to_x, player_save_data[i].move_to_y, player_save_data[i].move_to_z);
                            Custom_SetAgentWorldPosition(player_agent_name, player_LoadAgentPos, Custom_CutsceneDev_SceneObject);
                        --end
                    else
                        --move_to_pos_finish[i] = 0;
                        local time_passed_pos = GetTotalTime()-move_start_time_pos[i];
                        local Position3 = Vector(Position1.x+length_x*time_passed_pos/player_save_data[i].speed,Position1.y+length_y*time_passed_pos/player_save_data[i].speed,Position1.z+length_z*time_passed_pos/player_save_data[i].speed);
                        Custom_SetAgentWorldPosition(player_agent_name, Position3, Custom_CutsceneDev_SceneObject);    
                    end

                end
                if player_save_data[i].r_speed == 0 then
                    --move_to_rot_finish[i] = 1;
                    local player_LoadAgentRot = Vector(player_save_data[i].rot_x, player_save_data[i].rot_y, player_save_data[i].rot_z);
                    Custom_SetAgentRotation(player_agent_name, player_LoadAgentRot, Custom_CutsceneDev_SceneObject);
                else

                    local Rotation1 = Vector(player_save_data[i].rot_x, player_save_data[i].rot_y, player_save_data[i].rot_z);
                    local Rotation2 = Vector(player_save_data[i].rot_to_x, player_save_data[i].rot_to_y, player_save_data[i].rot_to_z);
                
                    local r_length_x = Rotation2.x - Rotation1.x;
                    local r_length_y = Rotation2.y - Rotation1.y;
                    local r_length_z = Rotation2.z - Rotation1.z;


                    if GetTotalTime() > (move_start_time_rot[i] + player_save_data[i].r_speed) then
                        --move_to_rot_finish[i] = 1;
                        --if move_to_pos_finish[i] == 1 then

                            --move_start_time_rot[i] = GetTotalTime();
                            --local player_LoadAgentRot = Vector(player_save_data[i].rot_x, player_save_data[i].rot_y, player_save_data[i].rot_z);
                            local player_LoadAgentRot = Vector(player_save_data[i].rot_to_x, player_save_data[i].rot_to_y, player_save_data[i].rot_to_z);
                            Custom_SetAgentRotation(player_agent_name, player_LoadAgentRot, Custom_CutsceneDev_SceneObject);
                        --end
                    else
                        --move_to_rot_finish[i] = 0;
                        local time_passed_rot = GetTotalTime()-move_start_time_rot[i];
                        local Rotation3 = Vector(Rotation1.x+r_length_x*time_passed_rot/player_save_data[i].r_speed,Rotation1.y+r_length_y*time_passed_rot/player_save_data[i].r_speed,Rotation1.z+r_length_z*time_passed_rot/player_save_data[i].r_speed);
                        Custom_SetAgentRotation(player_agent_name, Rotation3, Custom_CutsceneDev_SceneObject);
                    end
                end

            elseif player_save_data[i].mode == 1 then

            


                local ControllerPos = Vector(player_save_data[i].pos_x, player_save_data[i].pos_y, player_save_data[i].pos_z);
                local ControllerRot = Vector(player_save_data[i].rot_x, player_save_data[i].rot_y, player_save_data[i].rot_z);
                local dummy_name = "Dummy" .. tostring(i);
                local DummyPos = AgentGetPos(dummy_name);
                local DummyRot = AgentGetRot(dummy_name);

                OffSet_y[i] = player_save_data[i].rot_y*3.142/180

                ControllerPos.x = ControllerPos.x + DummyPos.x*math.cos(OffSet_y[i]) + DummyPos.z*math.sin(OffSet_y[i]);
                ControllerPos.y = ControllerPos.y + DummyPos.y;
                ControllerPos.z = ControllerPos.z + DummyPos.z*math.cos(OffSet_y[i]) - DummyPos.x*math.sin(OffSet_y[i]);


                ControllerRot.x = ControllerRot.x + DummyRot.x;
                ControllerRot.y = ControllerRot.y + DummyRot.y;
                ControllerRot.z = ControllerRot.z + DummyRot.z;


                Custom_SetAgentWorldPosition(player_agent_name, ControllerPos, Custom_CutsceneDev_SceneObject);
                Custom_SetAgentRotation(player_agent_name, ControllerRot, Custom_CutsceneDev_SceneObject);
            elseif player_save_data[i].mode == 2 then
                --root reset resets positions and sets up non-looping animation to the Dummy
                --if root_reset[i] == 0 then
                    
                    --player_resetAnimation(i);

                    --ControllerKill(player_animationPreview[i]);
                    --ControllerKill(player_animationPreviewDummy[i]);
                    --player_AnimationPrewierPlay(player_agent_name, i);

                    --root_iteration[i] = 0;
                    --root_reset[i] = 1;
                --end
            
                local ControllerPos = Vector(player_save_data[i].pos_x, player_save_data[i].pos_y, player_save_data[i].pos_z);
                local ControllerRot = Vector(player_save_data[i].rot_x, player_save_data[i].rot_y, player_save_data[i].rot_z);
                local dummy_name = "Dummy" .. tostring(i);
                local DummyPos = AgentGetPos(dummy_name);
                local DummyRot = AgentGetRot(dummy_name);


                DummyPos.x = DummyPos.x + DummyPosNew[i].x*root_iteration[i];
                DummyPos.y = DummyPos.y + DummyPosNew[i].y*root_iteration[i];
                DummyPos.z = DummyPos.z + DummyPosNew[i].z*root_iteration[i];

                DummyRot.x = DummyRot.x + DummyRotNew[i].x*root_iteration[i];
                DummyRot.y = DummyRot.y + DummyRotNew[i].y*root_iteration[i];
                DummyRot.z = DummyRot.z + DummyRotNew[i].z*root_iteration[i];


                OffSet_y[i] = player_save_data[i].rot_y*3.142/180

                ControllerPos.x = ControllerPos.x + DummyPos.x*math.cos(OffSet_y[i]) + DummyPos.z*math.sin(OffSet_y[i]);
                ControllerPos.y = ControllerPos.y + DummyPos.y;
                ControllerPos.z = ControllerPos.z + DummyPos.z*math.cos(OffSet_y[i]) - DummyPos.x*math.sin(OffSet_y[i]);

                ControllerRot.x = ControllerRot.x + DummyRot.x;
                ControllerRot.y = ControllerRot.y + DummyRot.y;
                ControllerRot.z = ControllerRot.z + DummyRot.z;



                Custom_SetAgentWorldPosition(player_agent_name, ControllerPos, Custom_CutsceneDev_SceneObject);
                Custom_SetAgentRotation(player_agent_name, ControllerRot, Custom_CutsceneDev_SceneObject);

                --controlls continuous root motion
                if ControllerIsPlaying(player_animationPreviewDummy[i]) == false then
                    local dummy_name = "Dummy" .. tostring(i);
                    DummyPosNew[i] = AgentGetPos(dummy_name);
                    DummyRotNew[i] = AgentGetRot(dummy_name);
                    player_animationPreviewDummy[i] = PlayAnimation(dummy_name, tostring(player_save_data[i].anm));
                    ControllerSetContribution(player_animationPreviewDummy[i], 1);
                    ControllerSetPriority(player_animationPreviewDummy[i], 200);
                    ControllerSetLooping(player_animationPreviewDummy[i] , false);
                    root_iteration[i] = root_iteration[i] + 1;

                end 

            end
        
            
            
        
        end

        --Camera movement

        if player_save_data.camera.speed == 0 then
            --move_to_pos_finish[i] = 1;
            local player_LoadAgentPos = Vector(player_save_data.camera.pos_x, player_save_data.camera.pos_y, player_save_data.camera.pos_z);
            Custom_SetAgentWorldPosition(agent_name_cutsceneCamera, player_LoadAgentPos, Custom_CutsceneDev_SceneObject);
                    
        else --Move_To control
            local Position1 = Vector(player_save_data.camera.pos_x, player_save_data.camera.pos_y, player_save_data.camera.pos_z);
            local Position2 = Vector(player_save_data.camera.move_to_x, player_save_data.camera.move_to_y, player_save_data.camera.move_to_z);
            
            local length_x = Position2.x - Position1.x;
            local length_y = Position2.y - Position1.y;
            local length_z = Position2.z - Position1.z;


            if GetTotalTime() > (move_start_time_pos_camera + player_save_data.camera.speed) then
                        
                local player_LoadAgentPos = Vector(player_save_data.camera.move_to_x, player_save_data.camera.move_to_y, player_save_data.camera.move_to_z);
                Custom_SetAgentWorldPosition(agent_name_cutsceneCamera, player_LoadAgentPos, Custom_CutsceneDev_SceneObject);
                        
            else
                    
                local time_passed_pos = GetTotalTime()-move_start_time_pos_camera;
                local Position3 = Vector(Position1.x+length_x*time_passed_pos/player_save_data.camera.speed,Position1.y+length_y*time_passed_pos/player_save_data.camera.speed,Position1.z+length_z*time_passed_pos/player_save_data.camera.speed);
                Custom_SetAgentWorldPosition(agent_name_cutsceneCamera, Position3, Custom_CutsceneDev_SceneObject);    
            end

        end
        if player_save_data.camera.r_speed == 0 then
            local player_LoadAgentRot = Vector(player_save_data.camera.rot_x, player_save_data.camera.rot_y, player_save_data.camera.rot_z);
            Custom_SetAgentRotation(agent_name_cutsceneCamera, player_LoadAgentRot, Custom_CutsceneDev_SceneObject);
        else

            local Rotation1 = Vector(player_save_data.camera.rot_x, player_save_data.camera.rot_y, player_save_data.camera.rot_z);
            local Rotation2 = Vector(player_save_data.camera.rot_to_x, player_save_data.camera.rot_to_y, player_save_data.camera.rot_to_z);
                
            local r_length_x = Rotation2.x - Rotation1.x;
            local r_length_y = Rotation2.y - Rotation1.y;
            local r_length_z = Rotation2.z - Rotation1.z;


            if GetTotalTime() > (move_start_time_rot_camera + player_save_data.camera.r_speed) then
                        
                local player_LoadAgentRot = Vector(player_save_data.camera.rot_to_x, player_save_data.camera.rot_to_y, player_save_data.camera.rot_to_z);
                Custom_SetAgentRotation(agent_name_cutsceneCamera, player_LoadAgentRot, Custom_CutsceneDev_SceneObject);

            else
                local time_passed_rot = GetTotalTime()-move_start_time_rot_camera;
                local Rotation3 = Vector(Rotation1.x+r_length_x*time_passed_rot/player_save_data.camera.r_speed,Rotation1.y+r_length_y*time_passed_rot/player_save_data.camera.r_speed,Rotation1.z+r_length_z*time_passed_rot/player_save_data.camera.r_speed);
                Custom_SetAgentRotation(agent_name_cutsceneCamera, Rotation3, Custom_CutsceneDev_SceneObject);
            end
        end
        
        
        
        --start length = 94
        
        if player_cutscene_data[player_clip].choices > 0 then

            local duration_step = player_cutscene_data[player_clip].duration/94;
            local duration_pass = player_cutscene_data[player_clip].duration + player_start_time - GetTotalTime(); --remaining time

            local duration_timer = duration_pass/duration_step;
            local duration_timer_normalized = math.floor(duration_timer+0.5)
            if duration_timer_normalized <= 0 then
                duration_timer_normalized = 0;
            elseif duration_timer_normalized < 1 then
                duration_timer_normalized = 1;
            end

            
            local duration_timer_text = ""
            if duration_timer_normalized ~= 0 then
                for i = 1, duration_timer_normalized do
                    duration_timer_text = duration_timer_text .. "–"
                end
            end
            TextSet(agent_choice_ui_timer, duration_timer_text);
            --TextSet(agent_choice_ui_text_1, tostring(duration_pass/duration_step)); --debug
        end
        


        --boundary check to support different resolutions
        --if RenderGetScreenResolution().x > RenderGetScreenResolution().y then
        --    correction_x = 1;
        --    correction_y = RenderGetScreenResolution().y / RenderGetScreenResolution().x;
        --    correction_y_2 = RenderGetAspectRatio() * correction_y;
        --else
        --    correction_y = 1;
        --    correction_x = 1;
        --end

        local bool_isOverChoice1 = KTBM_TextUI_IsCursorOverBounds(Vector(0.31, 0.7, 0), Vector(-0.183, -0.06, 0), Vector(0.183, 0.06, 0));
        local bool_isOverChoice2 = KTBM_TextUI_IsCursorOverBounds(Vector(0.69, 0.7, 0), Vector(-0.183, -0.06, 0), Vector(0.183, 0.06, 0));
        local bool_isOverChoice3 = KTBM_TextUI_IsCursorOverBounds(Vector(0.31, 0.83, 0), Vector(-0.183, -0.06, 0), Vector(0.183, 0.06, 0));
        local bool_isOverChoice4 = KTBM_TextUI_IsCursorOverBounds(Vector(0.69, 0.83, 0), Vector(-0.183, -0.06, 0), Vector(0.183, 0.06, 0));
        
        
        if Custom_InputKeyPress(1) and GetTotalTime() > SwitchDelay then
            if bool_isOverChoice1 and player_cutscene_data[player_clip].choices > 0 then
                --TextSet(agent_debug_boundary_1, "DETECTION! 1"); --debug
                chosen_text = 1;
            elseif bool_isOverChoice2 and player_cutscene_data[player_clip].choices > 1 then
                --TextSet(agent_choice_ui_text_2, "DETECTION! 2"); --debug
                chosen_text = 2;
            elseif bool_isOverChoice3 and player_cutscene_data[player_clip].choices > 2 then
                --TextSet(agent_choice_ui_text_3, "DETECTION! 3"); --debug
                chosen_text = 3;
            elseif bool_isOverChoice4 and player_cutscene_data[player_clip].choices > 3 then
                --TextSet(agent_choice_ui_text_4, "DETECTION! 4"); --debug
                chosen_text = 4;
            end
            SwitchDelay = GetTotalTime() + 0.3;
        end
        
        
        --local propertySet_agentProperties = AgentGetRuntimeProperties(agent_choice_ui_1);
        --local vector_extentsMin = PropertyGet(propertySet_agentProperties, "Extents Min");
        --local vector_extentsMax = PropertyGet(propertySet_agentProperties, "Extents Max");
        --TextSet(agent_choice_ui_text_3, tostring(vector_extentsMin)); --debug
        --TextSet(agent_choice_ui_text_4, tostring(vector_extentsMax)); --debug
        
        --TextSet(agent_choice_ui_text_1, tostring(RenderGetAspectRatio())); --debug
        --TextSet(agent_choice_ui_text_2, tostring(correction_y_2)); --debug
        --TextSet(agent_choice_ui_text_3, tostring(RenderGetScreenResolution().x)); --debug
        --TextSet(agent_choice_ui_text_4, tostring(RenderGetScreenResolution().y)); --debug



    end

    --one time stuff
    if player_clip_finished == 0 then
        for i = 1, player_n_n do
            local player_agent_name = player_agents_data.agents_names[i];
            --voice lines
            local voice_line_anm = tostring(player_save_data[i].voice_line);-- .. ".anm";
            local voice_line_snd = tostring(player_save_data[i].voice_line);-- .. ".wav";
            
            if voice_line_snd ~= "empty" then
                --local controller_sound = SoundPlay(voice_line_snd);
                local controller_sound = SoundPlay(voice_line_snd);
                
                local voiceController = PlayAnimation(player_agent_name, voice_line_anm);--tostring(voice_line_anm));
                ControllerSetContribution(voiceController, 1);
                ControllerSetPriority(voiceController, 300);
                ControllerSetLooping(voiceController , false);
            

                --voice_line_snd = voice_line_snd .. " HIT";
                
            end
            player_AnimationPrewierPlay(player_agent_name, i); --play animation
        end
                


        --choice UI


        --if player_cutscene_data[player_clip].choices == 0 then
            Custom_SetAgentPosition("agent_choice_ui_1", Vector(5,-3,-1000), Custom_CutsceneDev_SceneObject)
            Custom_SetAgentPosition("agent_choice_ui_2", Vector(5,-3,-1000), Custom_CutsceneDev_SceneObject)
            Custom_SetAgentPosition("agent_choice_ui_3", Vector(5,-3,-1000), Custom_CutsceneDev_SceneObject)
            Custom_SetAgentPosition("agent_choice_ui_4", Vector(5,-3,-1000), Custom_CutsceneDev_SceneObject)
            TextSet(agent_choice_ui_text_1, " ");
            TextSet(agent_choice_ui_text_2, " ");
            TextSet(agent_choice_ui_text_3, " ");
            TextSet(agent_choice_ui_text_4, " ");
            TextSet(agent_choice_ui_timer, " ");

        --text

        --calculations for text size

        --for left texts (1 and 3)

        --x = 4.9 for 1 symbol
        --x = 6.1 for 16 symbols
        --therefore step = 0.08 for each additional symbol
        --x = 9.2 for maximum - most left

        --for right texts (2 and 4)

        --x = -4.7 for 1 symbol
        --x = -3.5 for 16 symbols
        --therefore step = 0.08 for each additional symbol
        --x = -0.4 for maximum - most left


        if player_cutscene_data[player_clip].choices > 0 then
            Custom_SetAgentPosition("agent_choice_ui_1", Vector(5,-3,22), Custom_CutsceneDev_SceneObject)
            TextSet(agent_choice_ui_text_1, player_cutscene_data[player_clip].choice1_text);

            
            local choice_text_length = 4.9 + ((string.len(player_cutscene_data[player_clip].choice1_text)-1)*0.08);
            if choice_text_length > 9.2 then
                choice_text_length = 9.2
            end
            Custom_SetAgentPosition("agent_choice_ui_text_1", Vector(choice_text_length,-2.71,21), Custom_CutsceneDev_SceneObject)
            
            if player_cutscene_data[player_clip].choices > 1 then
                Custom_SetAgentPosition("agent_choice_ui_2", Vector(-5,-3,22), Custom_CutsceneDev_SceneObject)
                TextSet(agent_choice_ui_text_2, player_cutscene_data[player_clip].choice2_text);
                
                local choice_text_length = -4.7 + ((string.len(player_cutscene_data[player_clip].choice2_text)-1)*0.08);
                if choice_text_length > -0.4 then
                        choice_text_length = -0.4
                end
                Custom_SetAgentPosition("agent_choice_ui_text_2", Vector(choice_text_length,-2.71,21), Custom_CutsceneDev_SceneObject)

                if player_cutscene_data[player_clip].choices > 2 then
                    Custom_SetAgentPosition("agent_choice_ui_3", Vector(5,-5,22), Custom_CutsceneDev_SceneObject)
                    TextSet(agent_choice_ui_text_3, player_cutscene_data[player_clip].choice3_text);
                    
                    
                    local choice_text_length = 4.9 + ((string.len(player_cutscene_data[player_clip].choice3_text)-1)*0.08);
                    if choice_text_length > 9.2 then
                        choice_text_length = 9.2
                    end
                    Custom_SetAgentPosition("agent_choice_ui_text_3", Vector(choice_text_length,-4.65,21), Custom_CutsceneDev_SceneObject)


                    if player_cutscene_data[player_clip].choices > 3 then
                        Custom_SetAgentPosition("agent_choice_ui_4", Vector(-5,-5,22), Custom_CutsceneDev_SceneObject)
                        TextSet(agent_choice_ui_text_4, player_cutscene_data[player_clip].choice4_text);
                    
                        local choice_text_length = -4.7 + ((string.len(player_cutscene_data[player_clip].choice4_text)-1)*0.08);
                        if choice_text_length > -0.4 then
                            choice_text_length = -0.4
                        end
                        Custom_SetAgentPosition("agent_choice_ui_text_4", Vector(choice_text_length,-4.65,21), Custom_CutsceneDev_SceneObject)
                    end
                end
            end
            TextSet(agent_choice_ui_timer, "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––");
        end








            
        player_clip_finished = 1;



        --custom scripts
        --use nil or comment out the custom_script= line with ; in player.ini if unused
        local player_custom_script = player_cutscene_data[player_clip].custom_script;
        if player_custom_script ~= nil then
            getfenv()[player_custom_script]();
        end
    end 

    --debug
    --local highlightedText = voice_line_snd;--"IF YOU SEE THIS IT FINISHED!!" .. " Custom_CutsceneDev_Freecam_InputMouseAmountX " .. tostring(Custom_CutsceneDev_Freecam_InputMouseAmountX);
    --TextSet(Custom_CutsceneDev_CutsceneToolsHighlightText, highlightedText);
    --AgentSetWorldPos(Custom_CutsceneDev_CutsceneToolsHighlightText, Vector(100, 100, 100));

end









--sk55_jane_walkHoldBabySnowstorm.anm
--sk54_leeBodyHurt_toWalkLimp.anm
--359047430