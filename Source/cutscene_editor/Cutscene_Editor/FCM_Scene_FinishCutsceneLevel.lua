--[[
-------------------------------------------------------------------------
This script is specific to this mod and how I set it up.
All it is, is basically a script that when the main cutscene level reaches the end of the sequence
it exectues this script which will close the level and return to the main menu.
]]--

do 
    --quickfix, but because I disable graphic black when during the cutscene (because the cutscene wasn't designed with graphic black on)
    --we need to turn it back on so the menu looks like it normally does.
    local prefs = GetPreferences();
    PropertySet(prefs, "Enable Graphic Black", true);
    PropertySet(prefs, "Render - Graphic Black Enabled", true);

    --remove the base cutscene scene
    SceneRemove("adv_truckStopBathroom");

    --switch the archive from the FCMData_Library back to the Main Menu.
    SubProject_Switch("Menu");
end