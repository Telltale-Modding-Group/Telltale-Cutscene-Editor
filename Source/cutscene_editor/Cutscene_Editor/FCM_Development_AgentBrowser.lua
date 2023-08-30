--[[
Custom Relighting Development Tools/Functions script
This is a script that is basically full of custom systems and functions I created to make my life easier in regards to creating a relight.
One of the many challenges is that for relighting things I often just had just geuss constantly where lights where, and their placements and settings.
This aims to basically solve that and alleviate all of that.

THIS SCRIPT IS FOR HANDLING THE MAIN RELIGHT TOOL

KEYCODE VALUES - https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
Keycode values are in hexcode, so use this to convert them to decimal - https://www.rapidtables.com/convert/number/hex-to-decimal.html

This script also uses functions from the following lua scripts...
- FCM_AgentExtensions.lua
- FCM_Printing.lua
- FCM_Development_Freecam.lua

WHEN IMPLEMENTING THIS INTO A LEVEL, YOU MUST DO THE FOLLOWING...

1. At the top of the script, you must have a variable that is named
- Custom_CutsceneDev_SceneObject
This will just simply contain a reference to the kScene variable so the function can reference object from the scene.

2. At the top of the script, you must have a variable that is named
- Custom_CutsceneDev_SceneObjectAgentName
This will just simply contain a reference to the scene agent name.

3. In the main function of the level script you call this function before step 2
Custom_CutsceneDev_CreateFreeCamera(kScene)

4. Lastly, also in the main function of the level script you add the functionality like so...

Callback_OnPostUpdate:Add(Custom_CutsceneDev_UpdateFreeCamera)
]]--

--Custom_CutsceneDev_SceneObject
--Custom_CutsceneDev_SceneObjectAgentName
--Custom_CutsceneDev_UseSeasonOneAPI

--(public) relight dev variables (public because these values need to be persistent)
Custom_CutsceneDev_CutsceneToolsText = nil;
Custom_CutsceneDev_CutsceneToolsHighlightText = nil;
Custom_CutsceneDev_CutsceneToolsEditMode = false;
Custom_CutsceneDev_CutsceneToolsTextTitle = "Cutscene Tools v1.0";
Custom_CutsceneDev_SceneAgentNames = {};
Custom_CutsceneDev_SceneAgentOriginalVisibility = {};
Custom_CutsceneDev_AgentIndex = 1;
Custom_CutsceneDev_MaxDisplayedItemCount = 10;
Custom_CutsceneDev_MenuItem = 1;

local currentAgent_name = ""; --string type
local currentAgent_agent = nil; --Agent type
local currentAgent_position_vector = nil; --Vector type
local currentAgent_rotation_vector = nil; --Vector type

--(private) relight dev variables
local AgentOperations = 
{
    "Create New Light",
    "Delete Selected Light",
    "Modify Agent Position",
    "Modify Agent Rotation",
    "Move Agent To Camera"
}

local SceneModifiablePropertyNames = 
{
    "FX anti-aliasing",
    "FX TAA Weight",
    "FX Sharp Shadows Enabled",
    "FX Ambient Occlusion Enabled",
    "FX Tonemap Enabled",
    "FX Tonemap Intensity",
    "FX Tonemap Type",
    "FX Tonemap White Point",
    "FX Tonemap Black Point",
    "FX Tonemap Filmic Pivot",
    "FX Tonemap Filmic Shoulder Intensity",
    "FX Tonemap Filmic Toe Intensity",
    "FX Tonemap Filmic Sign",
    "FX Tonemap Far White Point",
    "FX Tonemap Far Black Point",
    "FX Tonemap Far Filmic Pivot",
    "FX Tonemap Far Filmic Shoulder Intensity",
    "FX Tonemap Far Filmic Toe Intensity",
    "FX Tonemap Far Filmic Sign",
    "FX Tonemap RGB Enabled",
    "FX Tonemap RGB DOF Enabled",
    "FX Tonemap RGB Black Points",
    "FX Tonemap RGB White Points",
    "FX Tonemap RGB Pivots",
    "FX Tonemap RGB Shoulder Intensities",
    "FX Tonemap RGB Toe Intensities",
    "FX Tonemap RGB Signs",
    "FX Tonemap RGB Far Black Points",
    "FX Tonemap RGB Far White Points",
    "FX Tonemap RGB Far Pivots",
    "FX Tonemap RGB Far Shoulder Intensities",
    "FX Tonemap RGB Far Toe Intensities",
    "FX Tonemap RGB Far Signs",
    "FX Bloom Threshold",
    "FX Bloom Intensity",
    "Glow Clear Color",
    "Glow Sigma Scale",
    "FX Vignette Tint Enabled",
    "FX Vignette Tint",
    "FX Vignette Falloff",
    "FX Vignette Center",
    "FX Vignette Corners",
    "FX Force Linear Depth Offset",
    "HBAO Enabled",
    "HBAO Intensity",
    "HBAO Radius",
    "HBAO Max Radius Percent",
    "HBAO Hemisphere Bias",
    "HBAO Max Distance",
    "HBAO Blur Sharpness",
    "HBAO Distance Falloff",
    "HBAO Occlusion Scale",
    "HBAO Luminance Scale",
    "Ambient Color",
    "Shadow Color",
    "LightEnv Enabled",
    "LightEnv Reflection Enabled",
    "LightEnv Bake Enabled",
    "LightEnv Intensity",
    "LightEnv Saturation",
    "LightEnv Reflection Intensity Shadow",
    "LightEnv Reflection Intensity",
    "LightEnv Reflection Tint",
    "LightEnv Tint",
    "LightEnv Background Color",
    "LightEnv Shadow Light Bleed Reduction",
    "LightEnv Shadow Moment Bias",
    "LightEnv Shadow Depth Bias",
    "LightEnv Shadow Auto Depth Bounds",
    "LightEnv Dynamic Shadow Max Distance",
    "LightEnv Shadow Max Distance",
    "Light Shadow Trace Max Distance",
    "Specular Multiplier Enabled",
    "Specular Color Multiplier",
    "Specular Intensity Multiplier",
    "Specular Exponent Multiplier",
    "Fog Color",
    "Fog Enabled",
    "Fog Far Plane",
    "Fog Near Plane",
    "Fog Alpha"
}

local LightModifiablePropertyNames = 
{
    "EnvLight - Type",
    "EnvLight - Color",
    "EnvLight - Intensity",
    "EnvLight - Intensity Specular",
    "EnvLight - Intensity Diffuse",
    "EnvLight - Intensity Dimmer",
    "EnvLight - Enlighten Intensity",
    "EnvLight - Opacity",
    "EnvLight - Radius",
    "EnvLight - Distance Falloff",
    "EnvLight - Spot Angle Inner",
    "EnvLight - Spot Angle Outer",
    "EnvLight - Enabled Group",
    "EnvLight - Groups",
    "EnvLight - Wrap",
    "EnvLight - HBAO Participation Type",
    "EnvLight - Mobility",
    "EnvLight - Shadow Type",
    "EnvLight - Shadow Quality",
    "EnvLight - Shadow Softness",
    "EnvLight - Shadow Modulated Intensity",
    "EnvLight - Shadow Near Clip",
    "EnvLight - Shadow Depth Bias",
    "EnvLight - Shadow Map Quality Distance Scale"
}

local FogModifiablePropertyNames = 
{
    "Env - Enabled",
    "Env - Enabled on High",
    "Env - Enabled on Medium",
    "Env - Enabled on Low",
    "Env - Fog Enabled",
    "Env - Fog Height Falloff",
    "Env - Fog Max Opacity",
    "Env - Fog Start Distance",
    "Env - Fog Height",
    "Env - Fog Density",
    "Env - Priority",
    "Env - Fog Color"
}

--input workaround because S1 has different API
Custom_InputKeyPress = function(keyCode)
    if (Custom_CutsceneDev_UseSeasonOneAPI == true) then
        return Input_IsPressed(keyCode);
    else
        return Input_IsVKeyPressed(keyCode);
    end
end

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

Custom_CutsceneDev_BuildSceneAgentList = function()
    local allSceneAgents = SceneGetAgents(Custom_CutsceneDev_SceneObject);
    local onlyDoLights = false;
    
    Custom_CutsceneDev_SceneAgentNames = {};
    
    for i, sceneAgent in ipairs(allSceneAgents) do
        local sceneAgentName = AgentGetName(sceneAgent);
        local originalVisibility = Custom_AgentGetProperty(sceneAgentName, "Runtime: Visible", Custom_CutsceneDev_SceneObject); --bool type
    
        if (onlyDoLights == true) then
            --scene lights and custom lights
            if (string.match)(sceneAgentName, "light_") or (string.match)(sceneAgentName, "myLight_") then
                table.insert(Custom_CutsceneDev_SceneAgentNames, sceneAgentName);
                table.insert(Custom_CutsceneDev_SceneAgentOriginalVisibility, originalVisibility);
            end
            
            --scene object
            if (string.match)(sceneAgentName, Custom_CutsceneDev_SceneObjectAgentName) then
                table.insert(Custom_CutsceneDev_SceneAgentNames, sceneAgentName);
                table.insert(Custom_CutsceneDev_SceneAgentOriginalVisibility, originalVisibility);
            end
            
            --scene fog
            if (string.match)(sceneAgentName, "module_environment") then
                table.insert(Custom_CutsceneDev_SceneAgentNames, sceneAgentName);
                table.insert(Custom_CutsceneDev_SceneAgentOriginalVisibility, originalVisibility);
            end
        else
            table.insert(Custom_CutsceneDev_SceneAgentNames, sceneAgentName);
            table.insert(Custom_CutsceneDev_SceneAgentOriginalVisibility, originalVisibility);
        end
    end
end

Custom_CutsceneDev_InitalizeCutsceneTools = function()
    -------------------------------------------------------------
    --initalize menu text
    --force scene vignette off because it makes it hard to read text
    Custom_AgentSetProperty(Custom_CutsceneDev_SceneObjectAgentName, "FX Vignette Tint Enabled", false, Custom_CutsceneDev_SceneObject);

    --create our menu text
    Custom_CutsceneDev_CutsceneToolsText = CreateTextAgent("CutsceneToolsText", "Relight Text Initalized", 0.0, 0.0, 0, 0, 0);
    
    --create our agent highlighted text
    Custom_CutsceneDev_CutsceneToolsHighlightText = CreateTextAgent("CutsceneToolsHighlightedText", "Relight Text Initalized", 0.0, 0.0, 0, 0, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(Custom_CutsceneDev_CutsceneToolsText, 0.75);
    TextSetScale(Custom_CutsceneDev_CutsceneToolsHighlightText, 0.75);

    --color note
    --text colors are additive on the scene
    TextSetColor(Custom_CutsceneDev_CutsceneToolsText, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(Custom_CutsceneDev_CutsceneToolsHighlightText, Color(1.0, 0.0, 1.0, 1.0));
    -------------------------------------------------------------
    --initalize other dev tool values
    Custom_CutsceneDev_BuildSceneAgentList();
end

--temp variables for input (for limiting the amount of times input runs because its sooo fast)
local inputRunRate = 0;
local maxInputRunRate = 5;

Custom_CutsceneDev_UpdateCutsceneTools_Input = function()
    -------------------------------------------------------------
    --limit amount of time this function executes because its so responsive
    inputRunRate = inputRunRate + 1;
    
    if not (inputRunRate == maxInputRunRate) then
        do return end
    else
        inputRunRate = 0;
    end
    
    -------------------------------------------------------------
    --edit mode toggle

    --disabled for cutscene editor for now
    --if Custom_InputKeyPress(82) then
        --R key
    --    Custom_CutsceneDev_CutsceneToolsEditMode = false;
    --    Custom_CutsceneDev_BuildSceneAgentList();
    --elseif Custom_InputKeyPress(70) then
        --F key
    --    Custom_CutsceneDev_CutsceneToolsEditMode = true;
    --    Custom_CutsceneDev_BuildSceneAgentList();
    --end
    
    -------------------------------------------------------------
    --if we are not in edit mode, don't continue
    if (Custom_CutsceneDev_CutsceneToolsEditMode == false) then
        do return end
    end

    -------------------------------------------------------------
    --agent list cycle
    if Custom_InputKeyPress(81) then
        --key q [81] (decrease)
        --key 1 [49] (decrease)
        Custom_CutsceneDev_AgentIndex = Custom_CutsceneDev_AgentIndex - 1;
    elseif Custom_InputKeyPress(69) then
        --key e [69] (increase)
        --key 2 [50] (increase)
        Custom_CutsceneDev_AgentIndex = Custom_CutsceneDev_AgentIndex + 1;
    end
    
    --clamp the index value
    if (Custom_CutsceneDev_AgentIndex > #Custom_CutsceneDev_SceneAgentNames) then
        Custom_CutsceneDev_AgentIndex = 1;
    elseif (Custom_CutsceneDev_AgentIndex < 1) then
        Custom_CutsceneDev_AgentIndex = #Custom_CutsceneDev_SceneAgentNames;
    end
    
    -------------------------------------------------------------
    --agent scene list refresh
    if Custom_InputKeyPress(9) then
        --tab
        Custom_CutsceneDev_BuildSceneAgentList();
    end
    
    -------------------------------------------------------------
    --menu cycle and operations
    if Custom_InputKeyPress(87) then
        --key w [87] (menu cycle up)
        Custom_CutsceneDev_MenuItem = Custom_CutsceneDev_MenuItem - 1;
    elseif Custom_InputKeyPress(83) then
        --key s [83] (menu cycle down)
        Custom_CutsceneDev_MenuItem = Custom_CutsceneDev_MenuItem + 1;
    end
    
    if (Custom_CutsceneDev_MenuItem < 1) then
        Custom_CutsceneDev_MenuItem = 1;
    end
end

Custom_CutsceneDev_UpdateCutsceneTools_Main = function()  
    -------------------------------------------------------------
    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local screenPos = Vector(0.0, 0.0, 0.0);
    AgentSetWorldPosFromLogicalScreenPos(Custom_CutsceneDev_CutsceneToolsText, screenPos);
    --AgentSetWorldPosFromScreenPos(Custom_CutsceneDev_CutsceneToolsText,  Vector(0.5, 0.5, 0.0));
    --AgentSetWorldPosFromCursorPos(Custom_CutsceneDev_CutsceneToolsText);

    -------------------------------------------------------------
    --get the current camera, normally we would just cache this but scene cameras change all the time
    local currentCamera_agent = SceneGetCamera(Custom_CutsceneDev_SceneObject); --Agent type
    local currentCamera_camera = AgentGetCamera(currentCamera_agent); --Camera type
    local currentCamera_name = tostring(AgentGetName(currentCamera_agent)); --String type
    local currentCamera_position_vector = AgentGetWorldPos(currentCamera_agent); --Vector type
    local currentCamera_forward_vector = AgentGetForwardVec(currentCamera_agent); --Vector type
    local currentCamera_rotation_vector = AgentGetWorldRot(currentCamera_agent); --Vector type


    currentCamera_rotation_vector.y = Custom_CutsceneDev_Freecam_InputMouseAmountX; --absolute Y coordinates



    local currentCamera_fov = Custom_AgentGetProperty(currentCamera_name, "Field of View", Custom_CutsceneDev_SceneObject); --number type
    
    currentAgent_name = Custom_CutsceneDev_SceneAgentNames[Custom_CutsceneDev_AgentIndex];
    currentAgent_agent = AgentFindInScene(currentAgent_name, Custom_CutsceneDev_SceneObject);
    currentAgent_position_vector = AgentGetWorldPos(currentAgent_agent); --Vector type
    currentAgent_rotation_vector = AgentGetWorldRot(currentAgent_agent); --Vector type
    
    -------------------------------------------------------------
    --for highlighted text
    local highlightedText = currentAgent_name;
    highlightedText = highlightedText .. "\n"; --new line
    highlightedText = highlightedText .. "World Pos: " .. VectorToString(currentAgent_position_vector);
    highlightedText = highlightedText .. "\n"; --new line
    highlightedText = highlightedText .. "World Rot: " .. VectorToString(currentAgent_rotation_vector); 
    
    TextSet(Custom_CutsceneDev_CutsceneToolsHighlightText, highlightedText);
    AgentSetWorldPos(Custom_CutsceneDev_CutsceneToolsHighlightText, currentAgent_position_vector);

    -------------------------------------------------------------
    --main menu text
    local relightMenuText = Custom_CutsceneDev_CutsceneToolsTextTitle;
    
    if (Custom_CutsceneDev_CutsceneToolsEditMode == true) then
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "[EDIT MODE]";
        relightMenuText = relightMenuText .. "\n"; --new line
        
        local text_sceneAgentIndex = tostring(Custom_CutsceneDev_AgentIndex);
        local text_totalSceneAgentAmount = tostring(#Custom_CutsceneDev_SceneAgentNames);
        local text_currSceneAgentName = tostring(Custom_CutsceneDev_SceneAgentNames[Custom_CutsceneDev_AgentIndex]);
        relightMenuText = relightMenuText .. "Selected Agent [" .. text_sceneAgentIndex .. " / " .. text_totalSceneAgentAmount .. "] ".. text_currSceneAgentName;
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "\n"; --new line
        
        local displayIndex = 0;
        local displayIndexOffset = 0;
        local modifiablePropertyNames = {};

        --scene lights and custom lights
        if (string.match)(currentAgent_name, "light_") or (string.match)(currentAgent_name, "myLight_") then
            relightMenuText = relightMenuText .. "[LIGHT PROPERTIES]";
            relightMenuText = relightMenuText .. "\n"; --new line
            modifiablePropertyNames = Custom_PropertiesListToStringList(currentAgent_name, LightModifiablePropertyNames);
        end
        
        --scene object
        if (string.match)(currentAgent_name, Custom_CutsceneDev_SceneObjectAgentName) then
            relightMenuText = relightMenuText .. "[SCENE PROPERTIES]";
            relightMenuText = relightMenuText .. "\n"; --new line
            modifiablePropertyNames = Custom_PropertiesListToStringList(currentAgent_name, SceneModifiablePropertyNames);
        end
        
        --scene fog
        if (string.match)(currentAgent_name, "module_environment") then
            relightMenuText = relightMenuText .. "[FOG PROPERTIES]";
            relightMenuText = relightMenuText .. "\n"; --new line
            modifiablePropertyNames = Custom_PropertiesListToStringList(currentAgent_name, FogModifiablePropertyNames);
        end
        
        local currentModifablePropertyName = modifiablePropertyNames[Custom_CutsceneDev_MenuItem];
        
        --start seperator
        relightMenuText = relightMenuText .. "----------------------------------------------------";
        relightMenuText = relightMenuText .. "\n"; --new line
        
        --clamp menu item index
        if(Custom_CutsceneDev_MenuItem > #modifiablePropertyNames) then
            Custom_CutsceneDev_MenuItem =  #modifiablePropertyNames;
        end
        
        --move the display window to display the rest of the items properly
        if(Custom_CutsceneDev_MenuItem > Custom_CutsceneDev_MaxDisplayedItemCount + displayIndexOffset) then 
            displayIndexOffset = displayIndexOffset + (Custom_CutsceneDev_MenuItem - Custom_CutsceneDev_MaxDisplayedItemCount) - 1; 
        end

        --iterate through the menu items
        for i, item in ipairs(modifiablePropertyNames) do
            local loopIndex = i + displayIndexOffset;
            local loopItem = modifiablePropertyNames[loopIndex];

            if (loopIndex == Custom_CutsceneDev_MenuItem) then
                relightMenuText = relightMenuText .. "*   ";
            end
                
            relightMenuText = relightMenuText .. "( " .. tostring(#modifiablePropertyNames) .. " / " .. tostring(loopIndex) .. " ) ";
            relightMenuText = relightMenuText .. loopItem;
            relightMenuText = relightMenuText .. "\n"; --new line
                
            displayIndex = displayIndex + 1;
                
            if (displayIndex > Custom_CutsceneDev_MaxDisplayedItemCount) then break end
        end
        
        --end seperator
        relightMenuText = relightMenuText .. "----------------------------------------------------";
        relightMenuText = relightMenuText .. "\n"; --new line
    else
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "----------------------------------------------------";
        relightMenuText = relightMenuText .. "\n"; --new line

        relightMenuText = relightMenuText .. "[Performance Stats]";
        relightMenuText = relightMenuText .. "\n"; --new line

        relightMenuText = relightMenuText .. "Frame Number: " .. tostring(GetFrameNumber());
        relightMenuText = relightMenuText .. "\n"; --new line

        relightMenuText = relightMenuText .. "Frame Time: " .. tostring(GetFrameTime());
        relightMenuText = relightMenuText .. "\n"; --new line

        relightMenuText = relightMenuText .. "Average Frame Time: " .. tostring(GetAverageFrameTime());
        relightMenuText = relightMenuText .. "\n"; --new line

        relightMenuText = relightMenuText .. "Total Time: " .. tostring(GetTotalTime());
        relightMenuText = relightMenuText .. "\n"; --new line

        relightMenuText = relightMenuText .. "----------------------------------------------------";
        relightMenuText = relightMenuText .. "\n"; --new line

        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "[FREECAMERA MODE]";
        relightMenuText = relightMenuText .. "\n"; --new line
        
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "Current Camera: " .. currentCamera_name;
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "Camera FOV: " .. currentCamera_fov;
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "Camera World Position: " .. VectorToString(currentCamera_position_vector);
        relightMenuText = relightMenuText .. "\n"; --new line
        relightMenuText = relightMenuText .. "Camera World Rotation: " .. VectorToString(currentCamera_rotation_vector); 
    end
    
    TextSet(Custom_CutsceneDev_CutsceneToolsText, relightMenuText)
end