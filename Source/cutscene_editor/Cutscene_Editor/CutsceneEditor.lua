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

local Dummy = nil;

--to change controls
--find button here: https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
--change to number: https://www.rapidtables.com/convert/number/hex-to-decimal.html




--prints an entire scene and its contents to a text file
PrintSceneListToTXT = function(SceneObject, txtName)
    local main_txt_file                 = io.open(txtName, "a")
    local scene_agents                  = SceneGetAgents(SceneObject)
    local print_agent_transformation    = true
    local print_agent_properties        = false
    local print_agent_properties_keyset = false --not that useful
    local print_scene_camera            = false
    
    if print_scene_camera then
        local sceneCamera = SceneGetCamera(SceneObject)
        
        local cam_name        = tostring(AgentGetName(sceneCamera))
        local cam_type        = tostring(TypeName(sceneCamera))
        local cam_pos       = tostring(AgentGetPos(sceneCamera))
        local cam_rot       = tostring(AgentGetRot(sceneCamera))
        local cam_pos_world = tostring(AgentGetWorldPos(sceneCamera))
        local cam_rot_world = tostring(AgentGetWorldRot(sceneCamera))
        
        main_txt_file:write(" ", "\n")
        main_txt_file:write("Camera Name: " .. cam_name, "\n")
        main_txt_file:write("Camera Type: " .. cam_type, "\n")
        main_txt_file:write("Camera Position: " .. cam_pos, "\n")
        main_txt_file:write("Camera Rotation: " .. cam_rot, "\n")
        main_txt_file:write("Camera World Position: " .. cam_pos_world, "\n")
        main_txt_file:write("Camera World Rotation: " .. cam_rot_world, "\n")
        
        local cam_properties = AgentGetProperties(sceneCamera)
        
        if cam_properties then
            --write a quick header to seperate
            main_txt_file:write(" --- Camera Properties ---", "\n")
            
            --get the property keys list
            local cam_property_keys = PropertyGetKeys(cam_properties)
            
            --begin looping through each property key found in the property keys list
            for b, cam_property_key in ipairs(cam_property_keys) do
                --get the key type and the value, as well as the value type
                local cam_property_key_type     = TypeName(PropertyGetKeyType(cam_properties, cam_property_key))
                local cam_property_value        = PropertyGet(cam_properties, cam_property_key)
                local cam_property_value_type = TypeName(PropertyGet(cam_properties, cam_property_key))

                --convert these to a string using a special function to format it nicely
                local cam_propety_key_string       = customKeyToString(cam_property_key)
                local cam_property_key_type_string = customKeyToString(cam_property_value_type)
                
                --convert these to a string using a special function to format it nicely
                local cam_property_value_string      = customKeyToString(cam_property_value)
                local cam_property_value_type_string = customKeyToString(cam_property_key_type)
                
                --begin writing these values to file
                main_txt_file:write("Camera" .. " " .. b .. " [Camera Property]", "\n")
                main_txt_file:write("Camera" .. " " .. b .. " Key: " .. cam_propety_key_string, "\n")
                main_txt_file:write("Camera" .. " " .. b .. " Value: " .. cam_property_value_string, "\n")
                main_txt_file:write("Camera" .. " " .. b .. " Key Type: " .. cam_property_key_type_string, "\n")
                main_txt_file:write("Camera" .. " " .. b .. " Value Type: " .. cam_property_value_type_string, "\n")

                --if the key type is of a table type, then print out the values of the table
                if cam_property_key_type_string == "table" then
                    main_txt_file:write("Camera" .. " " .. b .. " Value Table", "\n")
                    main_txt_file:write(tprint(cam_property_value), "\n")
                end
            end
            
            --write a header to indicate the end of the agent properties information
            main_txt_file:write(" ---Camera Properties END ---", "\n")
        end
    end
    
    --being looping through the list of agents gathered from the scene
    for i, agent_object in pairs(scene_agents) do
        --get the agent name and the type
        local agent_name = tostring(AgentGetName(agent_object))
        local agent_type = tostring(TypeName(agent_object))--type(agent_object)
        
        --start writing the agent information to the file
        main_txt_file:write(i, "\n")
        main_txt_file:write(i .. " Agent Name: " .. agent_name, "\n")
        main_txt_file:write(i .. " Agent Type: " .. agent_type, "\n")
        
        --if true, then it also writes information regarding the transformation properties of the agent
        if print_agent_transformation then
            local agent_pos = tostring(AgentGetPos(agent_object))
            local agent_rot = tostring(AgentGetRot(agent_object))
            
            local agent_pos_world = tostring(AgentGetWorldPos(agent_object))
            local agent_rot_world = tostring(AgentGetWorldRot(agent_object))
            
            main_txt_file:write(i .. " Agent Position: " .. agent_pos, "\n")
            main_txt_file:write(i .. " Agent Rotation: " .. agent_rot, "\n")
            main_txt_file:write(i .. " Agent World Position: " .. agent_pos_world, "\n")
            main_txt_file:write(i .. " Agent World Rotation: " .. agent_rot_world, "\n")
        end

        --get the properties list from the agent
        local agent_properties = AgentGetProperties(agent_object)
        
        --if the properties field isnt null and print_agent_properties is true
        if agent_properties and print_agent_properties then
            --write a quick header to seperate
            main_txt_file:write(i .. " --- Agent Properties ---", "\n")
            
            --get the property keys list
            local agent_property_keys = PropertyGetKeys(agent_properties)
            
            --begin looping through each property key found in the property keys list
            for x, agent_property_key in ipairs(agent_property_keys) do
                --get the key type and the value, as well as the value type
                local agent_property_key_type   = TypeName(PropertyGetKeyType(agent_properties, agent_property_key))
                local agent_property_value      = PropertyGet(agent_properties, agent_property_key)
                local agent_property_value_type = TypeName(PropertyGet(agent_properties, agent_property_key))

                --convert these to a string using a special function to format it nicely
                local agent_propety_key_string       = customKeyToString(agent_property_key)
                local agent_property_key_type_string = customKeyToString(agent_property_value_type)
                
                --convert these to a string using a special function to format it nicely
                local agent_property_value_string      = customKeyToString(agent_property_value)
                local agent_property_value_type_string = customKeyToString(agent_property_key_type)
                
                --begin writing these values to file
                main_txt_file:write(i .. " " .. x .. " [Agent Property]", "\n")
                main_txt_file:write(i .. " " .. x .. " Key: " .. agent_propety_key_string, "\n")
                main_txt_file:write(i .. " " .. x .. " Value: " .. agent_property_value_string, "\n")
                main_txt_file:write(i .. " " .. x .. " Key Type: " .. agent_property_key_type_string, "\n")
                main_txt_file:write(i .. " " .. x .. " Value Type: " .. agent_property_value_type_string, "\n")

                --if the key type is of a table type, then print out the values of the table
                if agent_property_key_type_string == "table" then
                    main_txt_file:write(i .. " " .. x .. " Value Table", "\n")
                    main_txt_file:write(tprint(agent_property_value), "\n")
                end
                
                --for printing the key property set of the agent properties
                if print_agent_properties_keyset then
                    local property_key_set = PropertyGetKeyPropertySet(agent_properties, agent_property_key)
                    
                    main_txt_file:write(i .. " " .. x .. " [Key Property Set] " .. tostring(property_key_set), "\n")
                    
                    for y, property_key in pairs(property_key_set) do
                        main_txt_file:write(i .. " " .. x .. " Key Property Set Key: " .. tostring(property_key), "\n")
                        main_txt_file:write(i .. " " .. x .. " Key Property Set Value: " .. tostring(PropertyGet(agent_properties, property_key)), "\n")
                    end
                end
            end
            
            --write a header to indicate the end of the agent properties information
            main_txt_file:write(i .. " ---Agent Properties END ---", "\n")
            
        end
    end
    
    --close the file stream
    main_txt_file:close()

    --for testing/validating
    --DialogBox_Okay("Printed Output")
end







ResetAnimation = function()
    ControllerKill(animationPreview);
    ControllerKill(animationPreviewDummy);
  
    Custom_SetAgentWorldPosition("Dummy", Vector(0, 0, 0), Custom_CutsceneDev_SceneObject);
    Custom_SetAgentRotation("Dummy", Vector(0, 0, 0), Custom_CutsceneDev_SceneObject);

    Custom_SetAgentWorldPosition(currentAgent_name, Vector(x_x, y_y, z_z), Custom_CutsceneDev_SceneObject);
    Custom_SetAgentRotation(currentAgent_name, Vector(r_x, r_y, z_y), Custom_CutsceneDev_SceneObject);
end

AnimationPrewierPlay = function()
    animationPreview = PlayAnimation(currentAgent_name, AnmTextTitle);
    ControllerSetContribution(animationPreview, 1);
    ControllerSetPriority(animationPreview, 200);
    ControllerSetLooping(animationPreview , true);

    animationPreviewDummy = PlayAnimation(Dummy, AnmTextTitle);
    ControllerSetContribution(animationPreviewDummy, 1);
    ControllerSetPriority(animationPreviewDummy, 200);
    if mode == 2 then
        ControllerSetLooping(animationPreviewDummy , false);
    else
        ControllerSetLooping(animationPreviewDummy , true);
    end
    
end
        

Cutscene_Save = function()

    --clips save system

    for i = 1, n_n do 
        if currentAgent_name == agents_data.agents_names[i] then 
            agent_number = i;
            break
        end
    end



    local Save_agent = agent_number; --name of section

    --local Save_position = Vector(x_x, y_y, z_z);
    --local Save_rotation = Vector(r_x, r_y, r_z);

    local Save_animation = data.info.animationinput;
    local Save_animation_type = mode;
    



    local Save_position_move_to = Vector(move_to_x, move_to_y, move_to_z);
    local Save_rotation_move_to = Vector(rot_to_x, rot_to_y, rot_to_z);
    local Save_speed = data.info.speed;
    local Save_r_speed = data.info.r_speed;
    local Save_voice_line = data.info.voice_line;


    local Save_Array = {pos_x = x_x, pos_y = y_y, pos_z = z_z, rot_x = r_x, rot_y = r_y, rot_z = r_z, anm = Save_animation, mode = Save_animation_type, move_to_x = Save_position_move_to.x, move_to_y = Save_position_move_to.y, move_to_z = Save_position_move_to.z, rot_to_x = Save_rotation_move_to.x, rot_to_y = Save_rotation_move_to.y, rot_to_z = Save_rotation_move_to.z, speed = Save_speed, r_speed = Save_r_speed, voice_line = Save_voice_line};


    save_data[Save_agent] = Save_Array;
 


end

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

Cutscene_Load_Clip_Set_Coords = function(number_of_the_agent)
    local load_agent_name = agents_data.agents_names[number_of_the_agent];
    local LoadAgentPos = Vector(save_data[number_of_the_agent].pos_x, save_data[number_of_the_agent].pos_y, save_data[number_of_the_agent].pos_z);
    local LoadAgentRot = Vector(save_data[number_of_the_agent].rot_x, save_data[number_of_the_agent].rot_y, save_data[number_of_the_agent].rot_z);
    Custom_SetAgentWorldPosition(load_agent_name, LoadAgentPos, Custom_CutsceneDev_SceneObject);
    Custom_SetAgentRotation(load_agent_name, LoadAgentRot, Custom_CutsceneDev_SceneObject);
end

Cutscene_Load_Clip = function(clip)
    --loads agent data from a clip
    --ResetAnimation();
    animation_menu = 0;


    load_file_name = "Custom_Cutscenes/" .. cutscene_name .. "/" .. tostring(clip) .. ".ini";
    if file_exists(load_file_name) then

        save_data = (LIP.load)(load_file_name);
        for i = 1, n_n do
            aaaaa = i;
        --try
            check_valifity = pcall(Cutscene_Load_Clip_Set_Coords, aaaaa);
            if check_valifity == true then
                Cutscene_Load_Clip_Set_Coords(aaaaa);
            end
            --local load_agent_name = agents_data.agents_names[i];
            --local LoadAgentPos = Vector(save_data[i].pos_x, save_data[i].pos_y, save_data[i].pos_z);
            --local LoadAgentRot = Vector(save_data[i].rot_x, save_data[i].rot_y, save_data[i].rot_z);
            --Custom_SetAgentWorldPosition(load_agent_name, LoadAgentPos, Custom_CutsceneDev_SceneObject);
            --Custom_SetAgentRotation(load_agent_name, LoadAgentRot, Custom_CutsceneDev_SceneObject);
        --try end
        end

        NewAgentPos2 = AgentGetPos(currentAgent_name);
        NewAgentRot2 = AgentGetRot(currentAgent_name);
        x_x = NewAgentPos2.x;
        y_y = NewAgentPos2.y;
        z_z = NewAgentPos2.z;
        r_x = NewAgentRot2.x;
        r_y = NewAgentRot2.y;
        r_z = NewAgentRot2.z;
        Cutscene_Load_Agent();
    end
end

Cutscene_Load_Agent = function()
    --update animation_input.ini when new agent selected
    
    for i = 1, n_n do 
        if currentAgent_name == agents_data.agents_names[i] then 
            agent_number_two = i;
            break
        end
    end


    mode = save_data[agent_number_two].mode;
    AnmTextTitle = save_data[agent_number_two].anm;
    speed = save_data[agent_number_two].speed;
    r_speed = save_data[agent_number_two].r_speed;
    voice_line = save_data[agent_number_two].voice_line;
    cam_speed   = save_data.camera.speed;
    cam_r_speed = save_data.camera.r_speed



    move_to_x = save_data[agent_number_two].move_to_x;
    move_to_y = save_data[agent_number_two].move_to_y;
    move_to_z = save_data[agent_number_two].move_to_z;
    rot_to_x = save_data[agent_number_two].rot_to_x;
    rot_to_y = save_data[agent_number_two].rot_to_y;
    rot_to_z = save_data[agent_number_two].rot_to_z;

    data.info.speed = speed;
    data.info.r_speed = r_speed;

    data.info.cam_speed = cam_speed;
    data.info.cam_r_speed = cam_r_speed;

    data.info.voice_line = voice_line;



    data.info.animationinput = AnmTextTitle;




    LIP.save("animation_input.ini", data);


    if mode == 0 then
        modeText = "IN PLACE";
    elseif mode == 1 then
        modeText = "BAKED";
    elseif mode == 2 then 
        modeText = "ROOT MOTION";
    end
end

CutsceneEditor = function(name_of_the_cutscene,propp)

    cutscene_name = name_of_the_cutscene;

    agents_names_path = "Custom_Cutscenes/" .. cutscene_name .."/agents.ini";

    
    agents_data = (LIP.load)(agents_names_path); 
    n_n = #(agents_data.agents_names);


    x_x = 0;---1;
    y_y = 0;--0.02;
    z_z = 0;---7.137;


    r_x = 0;--0;
    r_y = 0;--90;
    r_z = 0;--0;

    --n_n = 0;
    agent_exists_check = 0;

    animation_menu = 0;

    mode = 0; --0 = IN PLACE, 1 = BAKED, 2 = ROOT MOTION
    modeText = "IN PLACE";

    root_reset = 1;
    modeSwitchTime = 0;
    clipSwitchTime = 0;


    agentSelectTime = 0;

    change_angle = 1;
    change_position = 0.006;
    change_position_fast = 0.1;

    AnmTextTitle = none;

    test_variable_switch = 0;
    --dummy agent for animation
    Dummy = AgentCreate("Dummy", "dummy.prop", Vector(0, 0, 0), Vector(0,0,0), Custom_CutsceneDev_SceneObject, false, false);
    local controllersTable_character = AgentGetControllers(Dummy);



    --object to record move-to coords
    Dummy_2 = AgentCreate("Dummy_2", propp, Vector(-1000, -1000, -1000), Vector(0,0,0), kScene, false, false)
    x_x_x = -1000;
    y_y_y = -1000;
    z_z_z = -1000;
    r_x_x = 0;
    r_y_y = 0;
    r_z_z = 0;


    currentAgent_name = none;

    --clip = 1;

    input_Swith = 0;
    inputText = "";


    speed = 0;
    r_speed = 0;
    voice_line = "empty";



    move_to_x = 0;
    move_to_y = 0;
    move_to_z = 0;
    rot_to_x = 0;
    rot_to_y = 0;
    rot_to_z = 0;


    move_to_pos_finish = 0;
    move_to_rot_finish = 0;

    --CHANGE TO INI - LOOK UP LIP INSTRUCTIONS
    --Agent_array = {};
    --for line in io.lines(cutscene_name) do
    --    if tostring(line) == "***" then
    --        break
    --    end
    --    table.insert(Agent_array, tostring(line));
    --    n_n = n_n + 1;
    --end
    save_data = {};


    for i = 1, n_n do 
        agent_number = i;
        local Save_Array = {pos_x = 0, pos_y = 0, pos_z = 0, rot_x = 0, rot_y = 0, rot_z = 0, anm = "empty", mode = 0, move_to_x = 0, move_to_y = 0, move_to_z = 0, rot_to_x = 0, rot_to_y = 0, rot_to_z = 0, speed = 0, r_speed = 0, voice_line = "empty"};
        save_data[agent_number] = Save_Array;
    end
    save_data.camera = {pos_x = 0, pos_y = 0, pos_z = 0, rot_x = 0, rot_y = 0, rot_z = 0, move_to_x = 0, move_to_y = 0, move_to_z = 0, rot_to_x = 0, rot_to_y = 0, rot_to_z = 0, speed = 0, r_speed = 0,};
    


    --Cutscene_Load_Clip();
    Callback_OnPostUpdate:Add(move_object);

end


move_object = function()
    --load basic data
    data = (LIP.load)("animation_input.ini");

    

    currentAgent_name_check = (data.info).agent_name;
    if currentAgent_name ~= currentAgent_name_check then
        ResetAnimation();
        animation_menu = 0;

        --check if agent exists
        for i = 1, n_n do 
            if currentAgent_name_check == agents_data.agents_names[i] then 
               agent_exists_check = 1
            end
        end
        if agent_exists_check == 0 then
            do return end
        end
        agent_exists_check = 0;
        --sets name, pos and rot to new agent
        currentAgent_name = (data.info).agent_name;
        NewAgentPos = AgentGetPos(currentAgent_name);
        NewAgentRot = AgentGetRot(currentAgent_name);
        x_x = NewAgentPos.x;
        y_y = NewAgentPos.y;
        z_z = NewAgentPos.z;
        r_x = NewAgentRot.x;
        r_y = NewAgentRot.y;
        r_z = NewAgentRot.z;
        Cutscene_Load_Agent();

    end



    VoiceLength = AnimationGetLength(voice_line);

    AnimationLength = AnimationGetLength(AnmTextTitle);

    if animation_menu == 0 then

        DummyPosNew = AgentGetPos("Dummy"); --important for mode 2, do not remove
        DummyRotNew = AgentGetRot("Dummy"); --important for mode 2, do not remove
        Custom_SetAgentWorldPosition(currentAgent_name, Vector(x_x, y_y, z_z), Custom_CutsceneDev_SceneObject);
        Custom_SetAgentRotation(currentAgent_name, Vector(r_x, r_y, r_z), Custom_CutsceneDev_SceneObject);
    
    elseif animation_menu == 1 then
        if mode == 0 then
            if speed == 0 then
                move_to_pos_finish = 1;
                
                Custom_SetAgentWorldPosition(currentAgent_name, Vector(x_x, y_y, z_z), Custom_CutsceneDev_SceneObject);
            else --Move_To control
                local Position1 = Vector(x_x, y_y, z_z);
                local Position2 = Vector(move_to_x,move_to_y,move_to_z);
                

                local length_x = Position2.x - Position1.x;
                local length_y = Position2.y - Position1.y;
                local length_z = Position2.z - Position1.z;


                if GetTotalTime() > (move_start_time_pos + speed) then
                    move_to_pos_finish = 1;
                    if move_to_rot_finish == 1 then
                        --move_to_pos_finish = 0;
                        move_start_time_pos = GetTotalTime();
                        Custom_SetAgentWorldPosition(currentAgent_name, Vector(x_x,y_y,z_z), Custom_CutsceneDev_SceneObject);
                    end
                else
                    move_to_pos_finish = 0;
                    local time_passed_pos = GetTotalTime()-move_start_time_pos;
                    local Position3 = Vector(Position1.x+length_x*time_passed_pos/speed,Position1.y+length_y*time_passed_pos/speed,Position1.z+length_z*time_passed_pos/speed);
                    Custom_SetAgentWorldPosition(currentAgent_name, Position3, Custom_CutsceneDev_SceneObject);    
                end

            end
            if r_speed == 0 then
                move_to_rot_finish = 1;
                Custom_SetAgentRotation(currentAgent_name, Vector(r_x, r_y, r_z), Custom_CutsceneDev_SceneObject);
            else

                local Rotation1 = Vector(r_x, r_y, r_z);
                local Rotation2 = Vector(rot_to_x,rot_to_y,rot_to_z);
            
                local r_length_x = Rotation2.x - Rotation1.x;
                local r_length_y = Rotation2.y - Rotation1.y;
                local r_length_z = Rotation2.z - Rotation1.z;


                if GetTotalTime() > (move_start_time_rot + r_speed) then
                    move_to_rot_finish = 1;
                    if move_to_pos_finish == 1 then
                        --move_to_rot_finish = 0;
                        move_start_time_rot = GetTotalTime();
                        Custom_SetAgentRotation(currentAgent_name, Vector(r_x,r_y,r_z), Custom_CutsceneDev_SceneObject);
                    end
                else
                    move_to_rot_finish = 0;
                    local time_passed_rot = GetTotalTime()-move_start_time_rot;
                    local Rotation3 = Vector(Rotation1.x+r_length_x*time_passed_rot/r_speed,Rotation1.y+r_length_y*time_passed_rot/r_speed,Rotation1.z+r_length_z*time_passed_rot/r_speed);
                    Custom_SetAgentRotation(currentAgent_name, Rotation3, Custom_CutsceneDev_SceneObject);
                end
            end

        elseif mode == 1 then
            local ControllerPos = Vector(x_x, y_y, z_z);
            local ControllerRot = Vector(r_x, r_y, r_z);
            local DummyPos = AgentGetPos("Dummy");
            local DummyRot = AgentGetRot("Dummy");


            OffSet_y = r_y*3.142/180

            ControllerPos.x = ControllerPos.x + DummyPos.x*math.cos(OffSet_y) + DummyPos.z*math.sin(OffSet_y);
            ControllerPos.y = ControllerPos.y + DummyPos.y;
            ControllerPos.z = ControllerPos.z + DummyPos.z*math.cos(OffSet_y) - DummyPos.x*math.sin(OffSet_y);
            
            

            ControllerRot.x = ControllerRot.x + DummyRot.x;
            ControllerRot.y = ControllerRot.y + DummyRot.y;
            ControllerRot.z = ControllerRot.z + DummyRot.z;


           


            Custom_SetAgentWorldPosition(currentAgent_name, ControllerPos, Custom_CutsceneDev_SceneObject);
            Custom_SetAgentRotation(currentAgent_name, ControllerRot, Custom_CutsceneDev_SceneObject);
        elseif mode == 2 then
            --root reset resets positions and sets up non-looping animation to the Dummy
            if root_reset == 0 then
                
                ResetAnimation();
                AnimationPrewierPlay();

                root_iteration = 0;
                root_reset = 1;
            end
           
            local ControllerPos = Vector(x_x, y_y, z_z);
            local ControllerRot = Vector(r_x, r_y, r_z);
            local DummyPos = AgentGetPos("Dummy");
            local DummyRot = AgentGetRot("Dummy");

            DummyPos.x = DummyPos.x + DummyPosNew.x*root_iteration;
            DummyPos.y = DummyPos.y + DummyPosNew.y*root_iteration;
            DummyPos.z = DummyPos.z + DummyPosNew.z*root_iteration;


            DummyRot.x = DummyRot.x + DummyRotNew.x*root_iteration;
            DummyRot.y = DummyRot.y + DummyRotNew.y*root_iteration;
            DummyRot.z = DummyRot.z + DummyRotNew.z*root_iteration;

            OffSet_y = r_y*3.142/180

            ControllerPos.x = ControllerPos.x + DummyPos.x*math.cos(OffSet_y) + DummyPos.z*math.sin(OffSet_y);
            ControllerPos.y = ControllerPos.y + DummyPos.y;
            ControllerPos.z = ControllerPos.z + DummyPos.z*math.cos(OffSet_y) - DummyPos.x*math.sin(OffSet_y);

            ControllerRot.x = ControllerRot.x + DummyRot.x;
            ControllerRot.y = ControllerRot.y + DummyRot.y;
            ControllerRot.z = ControllerRot.z + DummyRot.z;


            Custom_SetAgentWorldPosition(currentAgent_name, ControllerPos, Custom_CutsceneDev_SceneObject);
            Custom_SetAgentRotation(currentAgent_name, ControllerRot, Custom_CutsceneDev_SceneObject);

            --controlls continuous root motion
            if ControllerIsPlaying(animationPreviewDummy) == false then
                DummyPosNew = AgentGetPos("Dummy");
                DummyRotNew = AgentGetRot("Dummy");

                animationPreviewDummy = PlayAnimation(Dummy, AnmTextTitle);
                ControllerSetContribution(animationPreviewDummy, 1);
                ControllerSetPriority(animationPreviewDummy, 200);
                ControllerSetLooping(animationPreviewDummy , false);
                root_iteration = root_iteration + 1;

            end 

        end

    end

    --for highlighted text

    --press middle mouse to switch to camera mode
    if GetTotalTime() > modeSwitchTime and Custom_InputKeyPress(4) then
        if input_Swith == 0 then
            input_Swith = 2;
            inputText = "";
        else

            input_Swith = 0;
            inputText = "";
        end
        modeSwitchTime = GetTotalTime() + 0.3;
    --press Z to switch to input save/load mode
    elseif GetTotalTime() > modeSwitchTime and Custom_InputKeyPress(90) then
        if input_Swith == 0 then
            input_Swith = 1;
            inputText = "";
        else

            input_Swith = 0;
            inputText = "";
        end
        modeSwitchTime = GetTotalTime() + 0.3;
    --press R to switch to set move_to coords mode
    elseif GetTotalTime() > modeSwitchTime and Custom_InputKeyPress(82) then
        if input_Swith == 0 then
            input_Swith = 3;
            x_x_x = x_x;
            y_y_y = y_y;
            z_z_z = z_z;
            r_x_x = r_x;
            r_y_y = r_y;
            r_z_z = r_z;
            inputText = "";
        else

            
            input_Swith = 0;
            inputText = "";
        end
        modeSwitchTime = GetTotalTime() + 0.3;
    end
    
    if input_Swith == 1 then --save input
        ResetAnimation();
        animation_menu = 0;
        root_reset = 0;
        if GetTotalTime() > modeSwitchTime then 
            if Custom_InputKeyPress(48) then
                inputText = inputText .. "0";
                modeSwitchTime = GetTotalTime() + 0.3;
            elseif Custom_InputKeyPress(49) then
                inputText = inputText .. "1";
                modeSwitchTime = GetTotalTime() + 0.3;
            elseif Custom_InputKeyPress(50) then
                inputText = inputText .. "2";
                modeSwitchTime = GetTotalTime() + 0.3;
            elseif Custom_InputKeyPress(51) then
                inputText = inputText .. "3";
                modeSwitchTime = GetTotalTime() + 0.3;
            elseif Custom_InputKeyPress(52) then
                inputText = inputText .. "4";
                modeSwitchTime = GetTotalTime() + 0.3;
            elseif Custom_InputKeyPress(53) then
                inputText = inputText .. "5";
                modeSwitchTime = GetTotalTime() + 0.3;
            elseif Custom_InputKeyPress(54) then
                inputText = inputText .. "6";
                modeSwitchTime = GetTotalTime() + 0.3;
            elseif Custom_InputKeyPress(55) then
                inputText = inputText .. "7";
                modeSwitchTime = GetTotalTime() + 0.3;
            elseif Custom_InputKeyPress(56) then
                inputText = inputText .. "8";
                modeSwitchTime = GetTotalTime() + 0.3;
            elseif Custom_InputKeyPress(57) then
                inputText = inputText .. "9";
                modeSwitchTime = GetTotalTime() + 0.3;
            elseif Custom_InputKeyPress(45) then --press Insert (for saving)
                
                input_Swith = 0;
                --Cutscene_Save(inputText);

                local save_file_name = "Custom_Cutscenes/" .. cutscene_name .. "/" .. inputText .. ".ini";
                LIP.save(save_file_name, save_data);

                return
            elseif Custom_InputKeyPress(46) then --press Delete (for loading)
                
                input_Swith = 0;
                Cutscene_Load_Clip(inputText);
                return
            end
        end
        local highlightedText = inputText;
        TextSet(Custom_CutsceneDev_CutsceneToolsHighlightText, highlightedText);
        AgentSetWorldPos(Custom_CutsceneDev_CutsceneToolsHighlightText, Vector(x_x, y_y, z_z));
        return
    elseif input_Swith == 2 then --camera input
        ResetAnimation();
        animation_menu = 0;
        root_reset = 0;
        agent_free_camera = AgentFindInScene("myNewFreecamera", kScene);
        local SaveCameraPosition = AgentGetPos("myNewFreecamera");
        local SaveCameraRotation = AgentGetRot("myNewFreecamera");
        inputText = "CAMERA MODE\nPOS: " .. VectorToString(SaveCameraPosition) .. "\nROT: " .. VectorToString(SaveCameraRotation);
        if GetTotalTime() > modeSwitchTime then 
            if Custom_InputKeyPress(1) then --left mouse button

                save_data.camera.pos_x = SaveCameraPosition.x;
                save_data.camera.pos_y = SaveCameraPosition.y;
                save_data.camera.pos_z = SaveCameraPosition.z;
                save_data.camera.rot_x = SaveCameraRotation.x;
                save_data.camera.rot_y = Custom_CutsceneDev_Freecam_InputMouseAmountX;
                save_data.camera.rot_z = SaveCameraRotation.z;
                modeSwitchTime = GetTotalTime() + 0.3;
            elseif Custom_InputKeyPress(2) then --right mouse button

                save_data.camera.move_to_x = SaveCameraPosition.x;
                save_data.camera.move_to_y = SaveCameraPosition.y;
                save_data.camera.move_to_z = SaveCameraPosition.z;
                save_data.camera.rot_to_x = SaveCameraRotation.x;
                save_data.camera.rot_to_y = Custom_CutsceneDev_Freecam_InputMouseAmountX;
                save_data.camera.rot_to_z = SaveCameraRotation.z;
                save_data.camera.r_speed = data.info.cam_r_speed;
                save_data.camera.speed = data.info.cam_speed;
                modeSwitchTime = GetTotalTime() + 0.3;
            end
        end
        local highlightedText = inputText;
        TextSet(Custom_CutsceneDev_CutsceneToolsHighlightText, highlightedText);
        AgentSetWorldPos(Custom_CutsceneDev_CutsceneToolsHighlightText, Vector(x_x, y_y, z_z));
        return
    elseif input_Swith == 3 then --move_to input
        ResetAnimation();
        animation_menu = 0;
        root_reset = 0;
        

        if Custom_InputKeyPress(38) then
            if Custom_InputKeyPress(16) then
            x_x_x = x_x_x + change_position_fast;
            elseif Custom_InputKeyPress(18) then
            r_x_x = r_x_x - change_angle;
            else
            x_x_x = x_x_x + change_position;
            end
        end
        --arrow_down
        if Custom_InputKeyPress(40) then
            if Custom_InputKeyPress(16) then
            x_x_x = x_x_x - change_position_fast;
            elseif Custom_InputKeyPress(18) then
            r_x_x = r_x_x + change_angle;
            else
            x_x_x = x_x_x - change_position;
            end
        end
        --arrow_right
        if Custom_InputKeyPress(39) then
            if Custom_InputKeyPress(16) then
            z_z_z = z_z_z + change_position_fast;
            elseif Custom_InputKeyPress(18) then
            r_y_y = r_y_y + change_angle;
            else
            z_z_z = z_z_z + change_position;
            end
        end
        --arrow_left
        if Custom_InputKeyPress(37) then
            if Custom_InputKeyPress(16) then
            z_z_z = z_z_z - change_position_fast;
            elseif Custom_InputKeyPress(18) then
            r_y_y = r_y_y - change_angle;
            else
            z_z_z = z_z_z - change_position;
            end
        end

        --plus
        if Custom_InputKeyPress(107) or Custom_InputKeyPress(187) then
            if Custom_InputKeyPress(16) then
            y_y_y = y_y_y + change_position_fast;
            elseif Custom_InputKeyPress(18) then
            r_z_z = r_z_z - change_angle;
            else
            y_y_y = y_y_y + change_position;
            end
        end
        --minus
        if Custom_InputKeyPress(109) or Custom_InputKeyPress(189) then
            if Custom_InputKeyPress(16) then
            y_y_y = y_y_y - change_position_fast;
            elseif Custom_InputKeyPress(18) then
            r_z_z = r_z_z + change_angle;
            else
            y_y_y = y_y_y - change_position;
            end
        end 
        local Dummy2Pos = Vector(x_x_x, y_y_y, z_z_z);
        local Dummy2Rot = Vector(r_x_x, r_y_y, r_z_z);

        inputText = "Move_To_Pos: " .. VectorToString(Dummy2Pos) .. "\nMove_To_Rot: " .. VectorToString(Dummy2Rot);
        local highlightedText = inputText;
        TextSet(Custom_CutsceneDev_CutsceneToolsHighlightText, highlightedText);
        AgentSetWorldPos(Custom_CutsceneDev_CutsceneToolsHighlightText, Vector(x_x_x, y_y_y, z_z_z));
        
        Custom_SetAgentWorldPosition("Dummy_2", Dummy2Pos, Custom_CutsceneDev_SceneObject);
        Custom_SetAgentRotation("Dummy_2", Dummy2Rot, Custom_CutsceneDev_SceneObject);


        if GetTotalTime() > modeSwitchTime then 
            if Custom_InputKeyPress(1) then --left mouse button
                move_to_x = x_x_x;
                move_to_y = y_y_y;
                move_to_z = z_z_z;
                rot_to_x = r_x_x;
                rot_to_y = r_y_y;
                rot_to_z = r_z_z;
                modeSwitchTime = GetTotalTime() + 0.3;
                input_Swith = 0;
                return
            end
        end
        return
    else --normal text for agent info
        Custom_SetAgentWorldPosition("Dummy_2", Vector(-1000, -1000, -1000), Custom_CutsceneDev_SceneObject);
        
        local highlightedText = currentAgent_name;
        highlightedText = highlightedText .. "\n"; --new line
        highlightedText = highlightedText .. "World Pos: " .. VectorToString(Vector(x_x, y_y, z_z))  .. "\n"; --VectorToString(currentAgent_position_vector);
        highlightedText = highlightedText .. "World Rot: " .. VectorToString(Vector(r_x, r_y, r_z)) .. "\n"; --VectorToString(currentAgent_rotation_vector); 
        highlightedText = highlightedText .. "Current anm: " .. tostring(AnmTextTitle) .. "\n";
        highlightedText = highlightedText .. "Playing: " .. tostring(animation_menu) .. "\n";
        highlightedText = highlightedText .. "Mode: " .. tostring(modeText) .. "\n" .. "Animation Length: " .. tostring(AnimationLength) .. "\n";
        highlightedText = highlightedText .. "Voice line: " .. tostring(voice_line) .. "\n";
        highlightedText = highlightedText .. "Voiceline lipsync Length: " .. tostring(VoiceLength) .. "\n"
        TextSet(Custom_CutsceneDev_CutsceneToolsHighlightText, highlightedText);
        AgentSetWorldPos(Custom_CutsceneDev_CutsceneToolsHighlightText, Vector(x_x, y_y, z_z));
    end
    --arrow_up
    if Custom_InputKeyPress(38) then
        if Custom_InputKeyPress(16) then
        x_x = x_x + change_position_fast;
        elseif Custom_InputKeyPress(18) then
        r_x = r_x - change_angle;
        else
        x_x = x_x + change_position;
        end
    end
    --arrow_down
    if Custom_InputKeyPress(40) then
        if Custom_InputKeyPress(16) then
        x_x = x_x - change_position_fast;
        elseif Custom_InputKeyPress(18) then
        r_x = r_x + change_angle;
        else
        x_x = x_x - change_position;
        end
    end
    --arrow_right
    if Custom_InputKeyPress(39) then
        if Custom_InputKeyPress(16) then
        z_z = z_z + change_position_fast;
        elseif Custom_InputKeyPress(18) then
        r_y = r_y + change_angle;
        else
        z_z = z_z + change_position;
        end
    end
    --arrow_left
    if Custom_InputKeyPress(37) then
        if Custom_InputKeyPress(16) then
        z_z = z_z - change_position_fast;
        elseif Custom_InputKeyPress(18) then
        r_y = r_y - change_angle;
        else
        z_z = z_z - change_position;
        end
    end

    --plus
    if Custom_InputKeyPress(107) or Custom_InputKeyPress(187) then
        if Custom_InputKeyPress(16) then
        y_y = y_y + change_position_fast;
        elseif Custom_InputKeyPress(18) then
        r_z = r_z - change_angle;
        else
        y_y = y_y + change_position;
        end
    end
    --minus
    if Custom_InputKeyPress(109) or Custom_InputKeyPress(189) then
        if Custom_InputKeyPress(16) then
        y_y = y_y - change_position_fast;
        elseif Custom_InputKeyPress(18) then
        r_z = r_z + change_angle;
        else
        y_y = y_y - change_position;
        end
    end
    --end

    
    AnmTextTitle = (data.info).animationinput;
    speed = data.info.speed;
    r_speed = data.info.r_speed;
    voice_line = data.info.voice_line;
    
    --animation_input
    --SPACE
    if Custom_InputKeyPress(32) and animation_menu == 0 then
        if mode ~= 2 then
            AnimationPrewierPlay();
        end
        animation_menu = 1;
        move_start_time_pos = GetTotalTime();
        move_start_time_rot = GetTotalTime();
    end
    --ENTER
    if Custom_InputKeyPress(13) and animation_menu == 1 then
        ResetAnimation();
        animation_menu = 0;
        root_reset = 0;
    end

    

    --mode
    --TAB
    if Custom_InputKeyPress(9) then
        if GetTotalTime() > modeSwitchTime then
            mode = mode + 1;
            if mode > 2 then
                mode = 0;
            end
            if mode == 0 then
                ResetAnimation();
                    if animation_menu == 1 then
                        AnimationPrewierPlay();
                    end
                modeText = "IN PLACE";
            elseif mode == 1 then
                ResetAnimation();
                    if animation_menu == 1 then
                        AnimationPrewierPlay();
                    end
                modeText = "BAKED";
            elseif mode == 2 then 
               -- reset+play in the main mode 2 script
               modeText = "ROOT MOTION";
               root_reset = 0;
            end
            modeSwitchTime = GetTotalTime() + 0.6;
        end
        
    end

    

    if Custom_InputKeyPress(70) and GetTotalTime() > modeSwitchTime then --press F to play voice line
        
        ResetAnimation();
  
        
        local voice_line_anm = tostring(voice_line);-- .. ".anm";
        local voice_line_snd = tostring(voice_line);-- .. ".wav";
        local controller_sound = SoundPlay(voice_line_snd);
        local voiceController = PlayAnimation(currentAgent_name, voice_line_anm);--tostring(voice_line_anm));
        ControllerSetContribution(voiceController, 1);
        ControllerSetPriority(voiceController, 300);
        ControllerSetLooping(voiceController , false);
        
        modeSwitchTime = GetTotalTime() + 0.6;
    end



    Cutscene_Save();



    

end

--sk54_leeBodyHurt_toWalkLimp.anm
--359047430