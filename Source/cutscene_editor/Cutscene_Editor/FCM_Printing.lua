--|||||||||||||||||||||||||||||||||||||||||||||| TYPES TO STRING ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| TYPES TO STRING ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| TYPES TO STRING ||||||||||||||||||||||||||||||||||||||||||||||

Custom_TablePrint = function(tbl, indent)
    if not indent then 
        indent = 0;
    end
  
    local toprint = string.rep(" ", indent) .. "{\r\n";
    
    indent = indent + 2;
    
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent);
        
        --print key
        if (type(k) == "number") then
            toprint = toprint .. "[" .. k .. "] = ";
        elseif (type(k) == "string") then
            toprint = toprint  .. k ..  " = "   ;
        end
        
        --print value
        if (type(v) == "number") then
            toprint = toprint .. v .. ",\r\n";
        elseif (type(v) == "string") then
            toprint = toprint .. "\"" .. v .. "\",\r\n";
        elseif (type(v) == "table") then
            toprint = toprint .. Custom_TablePrint(v, indent + 2) .. ",\r\n";
        else
            toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n";
        end
    end
    
    toprint = toprint .. string.rep(" ", indent - 2) .. "}";
    
    return toprint;
end

Custom_VectorToString = function(vectorValue)
    local stringValue = "";
    
    local xValue = string.format("%.6f", vectorValue.x);
    local yValue = string.format("%.6f", vectorValue.y);
    local zValue = string.format("%.6f", vectorValue.z);

    stringValue = stringValue .. "x: " .. xValue;
    stringValue = stringValue .. " y: " .. yValue;
    stringValue = stringValue .. " z: " .. zValue;
    
    return stringValue;
end

Custom_ColorToString = function(colorValue)
    local stringValue = "";
    
    local rValue = string.format("%.6f", colorValue.r);
    local gValue = string.format("%.6f", colorValue.g);
    local bValue = string.format("%.6f", colorValue.b);
    local aValue = string.format("%.6f", colorValue.a);
    
    stringValue = stringValue .. "r: " .. rValue;
    stringValue = stringValue .. " g: " .. gValue;
    stringValue = stringValue .. " b: " .. bValue;
    stringValue = stringValue .. " a: " .. aValue;
    
    return stringValue;
end

Custom_ColorToRGBColorToString = function(colorValue)
    local stringValue = "";
    
    local scalar = 255
    local rValue = string.format("%.0f", colorValue.r * scalar);
    local gValue = string.format("%.0f", colorValue.g * scalar);
    local bValue = string.format("%.0f", colorValue.b * scalar);
    local aValue = string.format("%.0f", colorValue.a * scalar);
    
    stringValue = stringValue .. "r: " .. rValue;
    stringValue = stringValue .. " g: " .. gValue;
    stringValue = stringValue .. " b: " .. bValue;
    stringValue = stringValue .. " a: " .. aValue;
    
    return stringValue;
end

Custom_Enum_TonemapType_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 1) then
        stringValue = stringValue .. "eTonemapType_Default";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eTonemapType_Filmic";
	end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

Custom_Enum_T3LightEnvType_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvType_Point";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvType_Spot";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvType_DirectionalKey";
    elseif (valueType == 3) then
        stringValue = stringValue .. "eLightEnvType_Ambient";
    elseif (valueType == 4) then
        stringValue = stringValue .. "eLightEnvType_DirectionalAmbient";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

Custom_Enum_T3LightEnvShadowType_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvShadowType_None";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvShadowType_Static_Depreceated";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvShadowType_PerLight";
    elseif (valueType == 3) then
        stringValue = stringValue .. "eLightEnvShadowType_Modulated";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

Custom_Enum_T3LightEnvShadowQuality_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvShadowQuality_Low";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvShadowQuality_Medium";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvShadowQuality_High";
    elseif (valueType == 3) then
        stringValue = stringValue .. "eLightEnvShadowQuality_MAX";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

Custom_Enum_T3LightEnvLODBehavior_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvLOD_Disable";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvLOD_BakeOnly";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

Custom_Enum_HBAOParticipationType_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eHBAOParticipationTypeAuto";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eHBAOParticipationTypeForceOn";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eHBAOParticipationTypeForceOff";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

Custom_Enum_T3LightEnvEnlightenBakeBehavior_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvEnlightenBake_Auto";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvEnlightenBake_Enable";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvEnlightenBake_Disable";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

Custom_Enum_T3LightEnvMobility_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvMobility_Static";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvMobility_Stationary";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvMobility_Moveable";
    elseif (valueType == 3) then
        stringValue = stringValue .. "eLightEnvMobility_Count";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

Custom_Enum_T3LightEnvGroup_ToString = function(valueType)
    local stringValue = "";

    if (valueType == 0) then
        stringValue = stringValue .. "eLightEnvGroup_Group0";
    elseif (valueType == 1) then
        stringValue = stringValue .. "eLightEnvGroup_Group1";
    elseif (valueType == 2) then
        stringValue = stringValue .. "eLightEnvGroup_Group2";
    elseif (valueType == 3) then
        stringValue = stringValue .. "eLightEnvGroup_Group3";
    elseif (valueType == 4) then
        stringValue = stringValue .. "eLightEnvGroup_Group4";
    elseif (valueType == 5) then
        stringValue = stringValue .. "eLightEnvGroup_Group5";
    elseif (valueType == 6) then
        stringValue = stringValue .. "eLightEnvGroup_Group6";
    elseif (valueType == 7) then
        stringValue = stringValue .. "eLightEnvGroup_Group7";
    elseif (valueType == 8) then
        stringValue = stringValue .. "eLightEnvGroup_CountWithNoAmbient";
    elseif (valueType == 8) then
        stringValue = stringValue .. "eLightEnvGroup_Group8_Unused";
    elseif (valueType == 9) then
        stringValue = stringValue .. "eLightEnvGroup_Group9_Unused";
    elseif (valueType == 10) then
        stringValue = stringValue .. "eLightEnvGroup_Group10_Unused";
    elseif (valueType == 11) then
        stringValue = stringValue .. "eLightEnvGroup_Group11_Unused";
    elseif (valueType == 12) then
        stringValue = stringValue .. "eLightEnvGroup_Group12_Unused";
    elseif (valueType == 13) then
        stringValue = stringValue .. "eLightEnvGroup_Group13_Unused";
    elseif (valueType == 14) then
        stringValue = stringValue .. "eLightEnvGroup_Group14_Unused";
    elseif (valueType == 15) then
        stringValue = stringValue .. "eLightEnvGroup_Group15_Unused";
    elseif (valueType == 16) then
        stringValue = stringValue .. "eLightEnvGroup_AmbientGroup0";
    elseif (valueType == 17) then
        stringValue = stringValue .. "eLightEnvGroup_AmbientGroup1";
    elseif (valueType == 18) then
        stringValue = stringValue .. "eLightEnvGroup_AmbientGroup2";
    elseif (valueType == 19) then
        stringValue = stringValue .. "eLightEnvGroup_AmbientGroup3";
    elseif (valueType == 20) then
        stringValue = stringValue .. "eLightEnvGroup_Count";
    elseif (valueType == 4294967294) then
        stringValue = stringValue .. "eLightEnvGroup_None";
    elseif (valueType == 4294967295) then
        stringValue = stringValue .. "eLightEnvGroup_Default";
    end

    stringValue = stringValue .. " ( " .. tostring(valueType) .. " )";
    
    return stringValue;
end

--prints a number to a string
--now with the way this telltale lua is...
--some of these numbers also obviously represent enums, this function encapsulates those different enums
--if and only if the property name matches, if not then its just a regular number value
Custom_Number_ToString = function(propertyName, propertyValue)
    local stringValue = "";

    if (propertyName == "EnvLight - Type") then
        stringValue = stringValue .. Custom_Enum_T3LightEnvType_ToString(propertyValue);
    elseif (propertyName == "EnvLight - HBAO Participation Type") then
        stringValue = stringValue .. Custom_Enum_HBAOParticipationType_ToString(propertyValue);
    elseif (propertyName == "EnvLight - Mobility") then
        stringValue = stringValue .. Custom_Enum_T3LightEnvMobility_ToString(propertyValue);
    elseif (propertyName == "EnvLight - Shadow Type") then
        stringValue = stringValue .. Custom_Enum_T3LightEnvShadowType_ToString(propertyValue);
    elseif (propertyName == "EnvLight - Shadow Quality") then
        stringValue = stringValue .. Custom_Enum_T3LightEnvShadowQuality_ToString(propertyValue);
    else
        stringValue = stringValue .. tostring(propertyValue);
    end

    return stringValue;
end

Custom_PropertiesListToStringList = function(agentName, givenPropertyNamesList)
    local stringValueList = {};
    
    --iterate through the list of given property names
    for i, givenPropertyName in ipairs(givenPropertyNamesList) do
		--print out the property name
        local stringValue = givenPropertyName .. ": ";
    
		--get the property value and its type
        local sceneAgentPropertyValue = Custom_AgentGetProperty(agentName, givenPropertyName, Custom_RelightDev_SceneObject);
        local sceneAgentPropertyValueType = tostring(TypeName(sceneAgentPropertyValue));

		--print out the value
        if (sceneAgentPropertyValueType == "number") then
            stringValue = stringValue .. Custom_Number_ToString(givenPropertyName, sceneAgentPropertyValue);
        elseif (sceneAgentPropertyValueType == "table") then
			local tableType = Custom_GetTableType(sceneAgentPropertyValue);
		
			if (tableType == "color") then
				 stringValue = stringValue .. Custom_ColorToRGBColorToString(sceneAgentPropertyValue);
			else
				 stringValue = stringValue .. tableType;
			end
        elseif (sceneAgentPropertyValueType == "boolean") then
            stringValue = stringValue .. tostring(sceneAgentPropertyValue);
        else
            stringValue = stringValue .. tostring(sceneAgentPropertyValue);
        end

		--add it to the string value list
        table.insert(stringValueList, stringValue);
    end
    
    return stringValueList;
end

--gets the key and if it's a symbol it removes the symbol: tag and quotations
local Custom_KeyToString = function(key)
    --convert the key to a string
    local keyAsString = tostring(key)
    
    --if the string contains symbol: then remove it, otherwise keep the string as is
    if (string.match)(keyAsString, "symbol: ") then
        keyAsString = (string.sub)(keyAsString, 9)
    else
        keyAsString = keyAsString
    end
    
    --remove any leftover quotations from the string
    keyAsString = keyAsString:gsub('"','')

    --return the final result
    return keyAsString
end

--|||||||||||||||||||||||||||||||||||||||||||||| PRINTING FUNCTIONS ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| PRINTING FUNCTIONS ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| PRINTING FUNCTIONS ||||||||||||||||||||||||||||||||||||||||||||||
--printing functions used to turn types into strings
--there is also a main function at the end of this script that prints an entire scene

--prints an entire scene and its contents to a text file (and this file is saved in the game directory)
Custom_PrintSceneListToTXT = function(SceneObject, txtName)
    --create (or open) a text file
    local main_txt_file = io.open(txtName, "a")
    
    --get all scene objects
    local scene_agents = SceneGetAgents(SceneObject)
    
    --printing options
    local print_agent_transformation    = false
    local print_agent_properties        = false
    local print_agent_properties_keyset = false --not that useful
    local print_scene_camera            = false
    local printOnlyName                 = true
    
    local print_option_showValue = true;
    local print_option_showValueType = true;
    local print_option_showKey = true;
    local print_option_showKeyType = true;
    
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
                local cam_propety_key_string       = Custom_KeyToString(cam_property_key)
                local cam_property_key_type_string = Custom_KeyToString(cam_property_value_type)
                
                --convert these to a string using a special function to format it nicely
                local cam_property_value_string      = Custom_KeyToString(cam_property_value)
                local cam_property_value_type_string = Custom_KeyToString(cam_property_key_type)
                
                --begin writing these values to file
                main_txt_file:write("Camera" .. " " .. b .. " [Camera Property]", "\n")
                main_txt_file:write("Camera" .. " " .. b .. " Key: " .. cam_propety_key_string, "\n")
                main_txt_file:write("Camera" .. " " .. b .. " Value: " .. cam_property_value_string, "\n")
                main_txt_file:write("Camera" .. " " .. b .. " Key Type: " .. cam_property_key_type_string, "\n")
                main_txt_file:write("Camera" .. " " .. b .. " Value Type: " .. cam_property_value_type_string, "\n")

                --if the key type is of a table type, then print out the values of the table
                if cam_property_key_type_string == "table" then
                    main_txt_file:write("Camera" .. " " .. b .. " Value Table", "\n")
                    main_txt_file:write(Custom_TablePrint(cam_property_value), "\n")
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
        if printOnlyName == false then
            main_txt_file:write(i, "\n")
        end
        main_txt_file:write(i .. " Agent Name: " .. agent_name, "\n")
        
        if printOnlyName == false then
            main_txt_file:write(i .. " Agent Type: " .. agent_type, "\n")
        end

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
                local agent_propety_key_string       = Custom_KeyToString(agent_property_key)
                local agent_property_key_type_string = Custom_KeyToString(agent_property_value_type)
                
                --convert these to a string using a special function to format it nicely
                local agent_property_value_string      = Custom_KeyToString(agent_property_value)
                local agent_property_value_type_string = Custom_KeyToString(agent_property_key_type)
                
                --begin writing these values to file
                main_txt_file:write(i .. " " .. x .. " [Agent Property]", "\n")
                main_txt_file:write(i .. " " .. x .. " Key: " .. agent_propety_key_string, "\n")
                main_txt_file:write(i .. " " .. x .. " Value: " .. agent_property_value_string, "\n")
                main_txt_file:write(i .. " " .. x .. " Key Type: " .. agent_property_key_type_string, "\n")
                main_txt_file:write(i .. " " .. x .. " Value Type: " .. agent_property_value_type_string, "\n")

                --if the key type is of a table type, then print out the values of the table
                if agent_property_key_type_string == "table" then
                    main_txt_file:write(i .. " " .. x .. " Value Table", "\n")
                    main_txt_file:write(Custom_TablePrint(agent_property_value), "\n")
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

Custom_PrintProperties = function(agent)
    local theAgentName = AgentGetName(agent)

    --clear the lists
    local agentName_propertyName_validOnesFromFile = {}
    local agentName_propertyName_validOnesFromFile_values = {}
    local agentName_propertyName_validOnesFromFile_valueTypes = {}

    local txtFile = io.open("strings.txt", "r")

    local agent_properties = AgentGetRuntimeProperties(agent)
    local agent_property_keys = PropertyGetKeys(agent_properties)

    local printValues = true
    local printValueTypes = true
    
	for i, item in ipairs(agent_property_keys) do
		local agentPropertyName = tostring(item) .. " (" .. SymbolToString(item) .. ")";
		table.insert(agentName_propertyName_validOnesFromFile, agentPropertyName)
            
        if printValues then
			local propertyValue = PropertyGet(agent_properties, item)
            propertyValue = tostring(propertyValue)
            table.insert(agentName_propertyName_validOnesFromFile_values, propertyValue)
        end
            
        if printValueTypes then
            local propertyValueType = TypeName(PropertyGet(agent_properties, item))
            propertyValueType = tostring(propertyValueType)
            table.insert(agentName_propertyName_validOnesFromFile_valueTypes, propertyValueType)
        end
	end
    
    txtFile:close()
    
    local agentValidPropertiesTxtFile = AgentGetName(agent) .. "_foundpropnames.txt"
    local txt_file_agentValidPropertiesTxtFile = io.open(agentValidPropertiesTxtFile, "a")

    txt_file_agentValidPropertiesTxtFile:write(" ", "\n")
    txt_file_agentValidPropertiesTxtFile:write("-------------All Properties In Agent-------------", "\n")
    
	local firstLine = "[AGENT NAME]: " .. theAgentName
    txt_file_agentValidPropertiesTxtFile:write(firstLine, "\n")
	
    local index = 0
    for _, line in pairs(agentName_propertyName_validOnesFromFile) do
		--local testing = SymbolToString(tostring(tonumber(Custom_KeyToString(line))));
		--local testing = SymbolToString(tonumber(Custom_KeyToString(line)));
		--local testing = SymbolToString(tostring(line));
		
		--local totalNameLine = "[NAME ]: " .. line .. " (" .. testing .. ")";
		local totalNameLine = "[NAME ]: " .. line;
        txt_file_agentValidPropertiesTxtFile:write(totalNameLine, "\n")
        
        if printValues then
		    if printValueTypes then
				--local totalLine = "[VALUE]: " .. agentName_propertyName_validOnesFromFile_values[_] .. " (" .. agentName_propertyName_validOnesFromFile_valueTypes[_] .. ")";
				local totalLine = "[VALUE]: (" .. agentName_propertyName_validOnesFromFile_valueTypes[_] .. ") " .. agentName_propertyName_validOnesFromFile_values[_];
				txt_file_agentValidPropertiesTxtFile:write(totalLine, "\n")
			else
				txt_file_agentValidPropertiesTxtFile:write("Value: " .. agentName_propertyName_validOnesFromFile_values[_], "\n")
			end
        end
       
        index = index + 1
    end

    txt_file_agentValidPropertiesTxtFile:close()
end

--loads the lines from agentName_propertyName_txtFile into an array
--probably a bad idea to load all the lines of a file into memory... but fuck it!
Custom_PrintValidPropertyNames = function(agent)
    local theAgentName = AgentGetName(agent)

    --clear the lists
    local agentName_propertyName_validOnesFromFile = {}
    local agentName_propertyName_validOnesFromFile_values = {}
    local agentName_propertyName_validOnesFromFile_valueTypes = {}

    local txtFile = io.open("strings.txt", "r")
    local txtFile2 = io.open("strings.txt", "r")
    local txtFile3 = io.open("strings.txt", "r")

    --local agent_properties = AgentGetRuntimeProperties(agent)
    local agent_properties = AgentGetProperties(agent)
    local agent_property_keys = PropertyGetKeys(agent_properties)

    local printValues = true
    local printValueTypes = true
    
    for line in txtFile:lines() do

        ---------------------------------------------------
        --print classic properties from file
        if PropertyExists(agent_properties, line) then
			local agentPropertyName = line .. " (" .. tostring(StringToSymbol(line)) .. ")";
            table.insert(agentName_propertyName_validOnesFromFile, agentPropertyName)
            
            if printValues then
                local propertyValue = PropertyGet(agent_properties, line)
                propertyValue = tostring(propertyValue)
                table.insert(agentName_propertyName_validOnesFromFile_values, propertyValue)
            end
            
            if printValueTypes then
                local propertyValueType = TypeName(PropertyGet(agent_properties, line))
                propertyValueType = tostring(propertyValueType)
                table.insert(agentName_propertyName_validOnesFromFile_valueTypes, propertyValueType)
            end
        end

        ---------------------------------------------------
        --print mesh properties from file
        local meshPropLineStart = line .. " ";
		
        for line2 in txtFile2:lines() do
            local finalMeshPropLine1 = meshPropLineStart .. line2;

            for line3 in txtFile3:lines() do
                local finalMeshPropLine2 = finalMeshPropLine1 .. " - " .. line3;

                if PropertyExists(agent_properties, finalMeshPropLine2) then
			        local agentPropertyName = finalMeshPropLine2 .. " (" .. tostring(StringToSymbol(finalMeshPropLine2)) .. ")";
                    table.insert(agentName_propertyName_validOnesFromFile, agentPropertyName)
            
                    if printValues then
                        local propertyValue = PropertyGet(agent_properties, finalMeshPropLine2)
                        propertyValue = tostring(propertyValue)
                        table.insert(agentName_propertyName_validOnesFromFile_values, propertyValue)
                    end
            
                    if printValueTypes then
                        local propertyValueType = TypeName(PropertyGet(agent_properties, finalMeshPropLine2))
                        propertyValueType = tostring(propertyValueType)
                        table.insert(agentName_propertyName_validOnesFromFile_valueTypes, propertyValueType)
                    end
                end
            end
        end

        --[[
        --extra print stuff
        local line2 = "Mesh " .. theAgentName .. " - " .. line
        
        if PropertyExists(agent_properties, line2) then
            table.insert(agentName_propertyName_validOnesFromFile, line2)
            
            if printValues then
                local propertyValue = PropertyGet(agent_properties, line2)
                propertyValue = tostring(propertyValue)
                table.insert(agentName_propertyName_validOnesFromFile_values, propertyValue)
            end
            
            if printValueTypes then
                local propertyValueType = TypeName(PropertyGet(agent_properties, line2))
                propertyValueType = tostring(propertyValueType)
                table.insert(agentName_propertyName_validOnesFromFile_valueTypes, propertyValueType)
            end
        end
        
        local line3 = theAgentName .. " - " .. line
        
        if PropertyExists(agent_properties, line2) then
            table.insert(agentName_propertyName_validOnesFromFile, line2)
            
            if printValues then
                local propertyValue = PropertyGet(agent_properties, line2)
                propertyValue = tostring(propertyValue)
                table.insert(agentName_propertyName_validOnesFromFile_values, propertyValue)
            end
            
            if printValueTypes then
                local propertyValueType = TypeName(PropertyGet(agent_properties, line2))
                propertyValueType = tostring(propertyValueType)
                table.insert(agentName_propertyName_validOnesFromFile_valueTypes, propertyValueType)
            end
        end

        for x, materialType in ipairs(myproject_materials_list) do
            local finalString = tostring(materialType .. " - " .. materialProp)
            
            if PropertyExists(agent_properties, finalString) then
                table.insert(agentName_propertyName_validOnesFromFile, finalString)
            
                if printValues then
                    local propertyValue = PropertyGet(agent_properties, finalString)
                    propertyValue = tostring(propertyValue)
                    table.insert(agentName_propertyName_validOnesFromFile_values, propertyValue)
                end
            
                if printValueTypes then
                    local propertyValueType = TypeName(PropertyGet(agent_properties, finalString))
                    propertyValueType = tostring(propertyValueType)
                    table.insert(agentName_propertyName_validOnesFromFile_valueTypes, propertyValueType)
                end
            end
        
            for y, materialProp in ipairs(myproject_materialsProps_list) do
                local finalString2 = tostring(materialType .. " - " .. materialProp)

                if PropertyExists(agent_properties, finalString2) then
                    table.insert(agentName_propertyName_validOnesFromFile, finalString2)
            
                    if printValues then
                        local propertyValue = PropertyGet(agent_properties, finalString2)
                        propertyValue = tostring(propertyValue)
                        table.insert(agentName_propertyName_validOnesFromFile_values, propertyValue)
                    end
            
                    if printValueTypes then
                        local propertyValueType = TypeName(PropertyGet(agent_properties, finalString2))
                        propertyValueType = tostring(propertyValueType)
                        table.insert(agentName_propertyName_validOnesFromFile_valueTypes, propertyValueType)
                    end
                end
            end
        end
		]]--
    end
    
    txtFile:close()
    
    local agentValidPropertiesTxtFile = AgentGetName(agent) .. "_foundpropnames.txt"
    local txt_file_agentValidPropertiesTxtFile = io.open(agentValidPropertiesTxtFile, "a")

    txt_file_agentValidPropertiesTxtFile:write(" ", "\n")
    txt_file_agentValidPropertiesTxtFile:write("-------------Found Valid Properties By Name-------------", "\n")
    
	local firstLine = "[AGENT NAME]: " .. theAgentName
    txt_file_agentValidPropertiesTxtFile:write(firstLine, "\n")
	
    local index = 0
    for _, line in pairs(agentName_propertyName_validOnesFromFile) do
		local totalNameLine = "[NAME ]: " .. line;
	
        txt_file_agentValidPropertiesTxtFile:write(totalNameLine, "\n")
        
        if printValues then
		    if printValueTypes then
				--local totalLine = "[VALUE]: " .. agentName_propertyName_validOnesFromFile_values[_] .. " (" .. agentName_propertyName_validOnesFromFile_valueTypes[_] .. ")";
				local totalLine = "[VALUE]: (" .. agentName_propertyName_validOnesFromFile_valueTypes[_] .. ") " .. agentName_propertyName_validOnesFromFile_values[_];
				txt_file_agentValidPropertiesTxtFile:write(totalLine, "\n")
			else
				txt_file_agentValidPropertiesTxtFile:write("Value: " .. agentName_propertyName_validOnesFromFile_values[_], "\n")
			end
        end
       
        index = index + 1
    end

    txt_file_agentValidPropertiesTxtFile:close()
end















 local nodeName = "Head";
    if AgentHasNode(agent_winston, "Head") then
        agent_winston_pos = AgentGetWorldPos(agent_winston, nodeName);
        agent_winston_rot = AgentGetWorldRot(agent_winston, nodeName);
        agent_winston_forward_vector = AgentGetForwardVec(agent_winston, nodeName);
    end

--loads the lines from agentName_propertyName_txtFile into an array
--probably a bad idea to load all the lines of a file into memory... but fuck it!
Custom_PrintValidNodeNames = function(agent)
    local theAgentName = AgentGetName(agent)

    --clear the lists
    local agentName_propertyName_validOnesFromFile = {}

    local txtFile = io.open("strings.txt", "r")

	--find the ones valid in the file
    for line in txtFile:lines() do
        --print classic properties from file
        if AgentHasNode(agent, line) then
			local agentNodeName = line;
            table.insert(agentName_propertyName_validOnesFromFile, agentNodeName)
        end
    end
    
    txtFile:close()
    
    local agentValidPropertiesTxtFile = AgentGetName(agent) .. "_foundnodenames.txt"
    local txt_file_agentValidPropertiesTxtFile = io.open(agentValidPropertiesTxtFile, "a")

    txt_file_agentValidPropertiesTxtFile:write(" ", "\n")
    txt_file_agentValidPropertiesTxtFile:write("-------------Found Valid Nodes By Name-------------", "\n")
    
	local firstLine = "[AGENT NAME]: " .. theAgentName
    txt_file_agentValidPropertiesTxtFile:write(firstLine, "\n")
	
    local index = 0
    for _, line in pairs(agentName_propertyName_validOnesFromFile) do
		local totalNameLine = "[NAME]: " .. line;
	
        txt_file_agentValidPropertiesTxtFile:write(totalNameLine, "\n")
       
        index = index + 1
    end

    txt_file_agentValidPropertiesTxtFile:close()
end