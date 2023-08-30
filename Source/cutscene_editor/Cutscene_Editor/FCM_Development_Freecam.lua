--[[
Custom Relighting Development Tools/Functions script
This is a script that is basically full of custom systems and functions I created to make my life easier in regards to creating a relight.
One of the many challenges is that for relighting things I often just had just geuss constantly where lights where, and their placements and settings.
This aims to basically solve that and alleviate all of that.
THIS SCRIPT IS FOR HANDLING FREECAM
KEYCODE VALUES - https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
Keycode values are in hexcode, so use this to convert them to decimal - https://www.rapidtables.com/convert/number/hex-to-decimal.html
This script also uses functions from the following lua scripts...
- FCM_AgentExtensions.lua
- FCM_Printing.lua
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
--Custom_CutsceneDev_FreecamUseFOVScale

--(public) cutscene dev freecam variables (public because these values need to be persistent)
Custom_CutsceneDev_Freecam_InputHorizontalValue = 0;
Custom_CutsceneDev_Freecam_InputVerticalValue = 0;
Custom_CutsceneDev_Freecam_InputHeightValue = 0;
Custom_CutsceneDev_Freecam_PrevCamPos = Vector(0,0,0);
Custom_CutsceneDev_Freecam_PrevCamRot = Vector(0,0,0);
Custom_CutsceneDev_Freecam_PrevCursorPos = Vector(0,0,0);
Custom_CutsceneDev_Freecam_InputMouseAmountX = 0;
Custom_CutsceneDev_Freecam_InputMouseAmountY = 0;
Custom_CutsceneDev_Freecam_InputFieldOfViewAmount = 75;
Custom_CutsceneDev_Freecam_PrevTime = 0;
Custom_CutsceneDev_Freecam_Frozen = false;
Custom_CutsceneDev_Freecam_CameraName = "myNewFreecamera";

--user configruable
Custom_CutsceneDev_Freecam_SnappyMovement = true;
Custom_CutsceneDev_Freecam_SnappyRotation = true;
Custom_CutsceneDev_Freecam_PositionLerpFactor = 5.0;
Custom_CutsceneDev_Freecam_RotationLerpFactor = 7.5;
Custom_CutsceneDev_Freecam_PositionIncrementDefault = 0.13;
Custom_CutsceneDev_Freecam_PositionIncrementShift = 0.25;
Custom_CutsceneDev_Freecam_FovIncrement = 0.5;

--input workaround because S1 has different API
local Custom_InputKeyPress = function(keyCode)
    if (Custom_CutsceneDev_UseSeasonOneAPI == true) then
        return Input_IsPressed(keyCode);
    else
        return Input_IsVKeyPressed(keyCode);
    end
end

Custom_CutsceneDev_CreateFreeCamera = function()
    local cam_prop = "module_camera.prop"
    
    local newPosition = Vector(0,0,0)
    local newRotation = Vector(90,0,0)
    
    local cameraAgent = AgentCreate(Custom_CutsceneDev_Freecam_CameraName, cam_prop, newPosition, newRotation, Custom_CutsceneDev_SceneObject, false, false)
    
    Custom_AgentSetProperty(Custom_CutsceneDev_Freecam_CameraName, "Clip Plane - Far", 2500, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty(Custom_CutsceneDev_Freecam_CameraName, "Clip Plane - Near", 0.05, Custom_CutsceneDev_SceneObject)
    Custom_AgentSetProperty(Custom_CutsceneDev_Freecam_CameraName, "Lens - Current Lens", nil, Custom_CutsceneDev_SceneObject)

    Custom_RemovingAgentsWithPrefix(sceneObj, "cam_")

    CameraPush(Custom_CutsceneDev_Freecam_CameraName);
end

Custom_CutsceneDev_UpdateFreeCamera = function()
    local currFrameTime = GetFrameTime();
    local deltaTime = math.abs(Custom_CutsceneDev_Freecam_PrevTime - currFrameTime);

    --freecamera freezing
    --disabled for cutscene editor for now
    
    --if Custom_InputKeyPress(82) then
        --R key
        --Custom_CutsceneDev_Freecam_Frozen = false;
    --elseif Custom_InputKeyPress(70) then
        --F key
        --Custom_CutsceneDev_Freecam_Frozen = true;
    --end

    --hide/show the cursor
    if (Custom_CutsceneDev_Freecam_Frozen == true) then
        CursorHide(false);
        CursorEnable(true);
        do return end --don't conitnue with the rest of the function
    else
        CursorHide(true);
        CursorEnable(true);
    end

    ------------------------------MOVEMENT------------------------------
    local positionIncrement = Custom_CutsceneDev_Freecam_PositionIncrementDefault;
    
    if Custom_InputKeyPress(16) then
        --key shift
        positionIncrement = Custom_CutsceneDev_Freecam_PositionIncrementShift;
    end
    
    if Custom_InputKeyPress(81) then
        --key q (decrease)
        Custom_CutsceneDev_Freecam_InputHeightValue = -positionIncrement;
    elseif Custom_InputKeyPress(69) then
        --key e (increase)
        Custom_CutsceneDev_Freecam_InputHeightValue = positionIncrement;
    else
        Custom_CutsceneDev_Freecam_InputHeightValue = 0;
    end
    
    if Custom_InputKeyPress(87) then
        --key w (increase)
        Custom_CutsceneDev_Freecam_InputVerticalValue = positionIncrement;
    elseif Custom_InputKeyPress(83) then
        --key s (decrease)
        Custom_CutsceneDev_Freecam_InputVerticalValue = -positionIncrement;
    else
        Custom_CutsceneDev_Freecam_InputVerticalValue = 0;
    end
    
    if Custom_InputKeyPress(65) then
        --key a (decrease)
        Custom_CutsceneDev_Freecam_InputHorizontalValue = positionIncrement;
    elseif Custom_InputKeyPress(68) then
        --key d (increase)
        Custom_CutsceneDev_Freecam_InputHorizontalValue = -positionIncrement;
    else
        Custom_CutsceneDev_Freecam_InputHorizontalValue = 0;
    end
    
    ------------------------------ZOOMING------------------------------
    local fovIncrement = Custom_CutsceneDev_Freecam_FovIncrement
    
    --if Custom_InputKeyPress(1) then
        --left mouse (decrease)
        --Custom_CutsceneDev_Freecam_InputFieldOfViewAmount = Custom_CutsceneDev_Freecam_InputFieldOfViewAmount - fovIncrement;
    --elseif Custom_InputKeyPress(2) then
        --right mouse (increase)
        --Custom_CutsceneDev_Freecam_InputFieldOfViewAmount = Custom_CutsceneDev_Freecam_InputFieldOfViewAmount + fovIncrement;
    --end
    
    ------------------------------MOUSELOOK------------------------------
    local currCursorPos = CursorGetPos()
    
    local minThreshold = 0.01
    local maxThreshold = 0.99
    
    --reset the cursor pos to the center of the screen when they get near the edges of the screen
    if (currCursorPos.x > maxThreshold) or (currCursorPos.x < minThreshold) or (currCursorPos.y > maxThreshold) or (currCursorPos.y < minThreshold) then
        CursorSetPos(Vector(0.5, 0.5, 0));
    end
    
    local xCursorDifference = currCursorPos.x - Custom_CutsceneDev_Freecam_PrevCursorPos.x
    local yCursorDifference = currCursorPos.y - Custom_CutsceneDev_Freecam_PrevCursorPos.y
    
    local sensitivity = 230.0
    Custom_CutsceneDev_Freecam_InputMouseAmountX = Custom_CutsceneDev_Freecam_InputMouseAmountX - (xCursorDifference * sensitivity)
    Custom_CutsceneDev_Freecam_InputMouseAmountY = Custom_CutsceneDev_Freecam_InputMouseAmountY + (yCursorDifference * sensitivity)

    local newRotation = Vector(Custom_CutsceneDev_Freecam_InputMouseAmountY - 90, Custom_CutsceneDev_Freecam_InputMouseAmountX, 0);
    
    if newRotation.x > 90 then
        newRotation.x = 90;
    elseif newRotation.x < -90 then
        newRotation.x = -90;
    end
    
    ------------------------------BUILD FINAL MOVEMENT/ROTATION------------------------------
    local newPosition = Vector(Custom_CutsceneDev_Freecam_InputHorizontalValue, Custom_CutsceneDev_Freecam_InputHeightValue, Custom_CutsceneDev_Freecam_InputVerticalValue);

    if (Custom_CutsceneDev_Freecam_SnappyMovement == true) then
        Custom_CutsceneDev_Freecam_PrevCamPos = newPosition;
    else
        Custom_CutsceneDev_Freecam_PrevCamPos = Custom_VectorLerp(Custom_CutsceneDev_Freecam_PrevCamPos, newPosition, currFrameTime * Custom_CutsceneDev_Freecam_PositionLerpFactor);
    end
    
    if (Custom_CutsceneDev_Freecam_SnappyRotation == true) then
        Custom_CutsceneDev_Freecam_PrevCamRot = newRotation;
    else
        Custom_CutsceneDev_Freecam_PrevCamRot = Custom_VectorLerp(Custom_CutsceneDev_Freecam_PrevCamRot, newRotation, currFrameTime * Custom_CutsceneDev_Freecam_RotationLerpFactor);
    end
    
    ------------------------------ASSIGNMENT------------------------------
    local myCameraAgent = AgentFindInScene(Custom_CutsceneDev_Freecam_CameraName, Custom_CutsceneDev_SceneObject); --Agent type
    local result = AgentLocalToWorld(myCameraAgent, Custom_CutsceneDev_Freecam_PrevCamPos);
    
    Custom_SetAgentPosition(Custom_CutsceneDev_Freecam_CameraName, result, Custom_CutsceneDev_SceneObject)
    Custom_SetAgentRotation(Custom_CutsceneDev_Freecam_CameraName, Custom_CutsceneDev_Freecam_PrevCamRot, Custom_CutsceneDev_SceneObject)

    if (Custom_CutsceneDev_FreecamUseFOVScale == true) then
        local fovScale = Custom_CutsceneDev_Freecam_InputFieldOfViewAmount / 50.0;

        Custom_AgentSetProperty(Custom_CutsceneDev_Freecam_CameraName, "Field of View Scale", fovScale, Custom_CutsceneDev_SceneObject);
    else
        Custom_AgentSetProperty(Custom_CutsceneDev_Freecam_CameraName, "Field of View", Custom_CutsceneDev_Freecam_InputFieldOfViewAmount, Custom_CutsceneDev_SceneObject);
    end

    Custom_CutsceneDev_Freecam_PrevCursorPos = CursorGetPos();
    Custom_CutsceneDev_Freecam_PrevTime = GetFrameTime();
end