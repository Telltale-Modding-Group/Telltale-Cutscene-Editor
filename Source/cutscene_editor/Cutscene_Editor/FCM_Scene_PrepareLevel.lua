--completely strips the original scene of almost all of its original objects
--however we will only keep a few things that we will need later on
Scene_CleanUpOriginalScene = function(kScene)
    --bulk remove all of the following assets
    Custom_RemovingAgentsWithPrefix(kScene, "light_CHAR_CC"); --character light objects
    Custom_RemovingAgentsWithPrefix(kScene, "lightrig"); --character light rigs
    Custom_RemovingAgentsWithPrefix(kScene, "fx_"); --particle effects
    Custom_RemovingAgentsWithPrefix(kScene, "fxg_"); --particle effects
    Custom_RemovingAgentsWithPrefix(kScene, "fxGroup_"); --particle effects groups
    Custom_RemovingAgentsWithPrefix(kScene, "light_bathroom_"); --bathroom lights
    Custom_RemovingAgentsWithPrefix(kScene, "light_point"); --scene point lights
    Custom_RemovingAgentsWithPrefix(kScene, "Crow"); --crow objects
    Custom_RemovingAgentsWithPrefix(kScene, "templateRig"); --template light rigs
    Custom_RemovingAgentsWithPrefix(kScene, "charLightComposer"); --light composers
    
    --get all agents within the scene
    local scene_agents = SceneGetAgents(kScene);

    --loop through all agents inside the scene
    for i, agent_object in pairs(scene_agents) do
        --get the name of the current agent item that we are on in the loop
        local agent_name = tostring(AgentGetName(agent_object));

        --if the name of the agent has an adv_ prefix then its a level mesh, so remove it
        --if the name of the agent has an obj_ prefix then it is an object (ocassionaly a mesh but sometimes its something else like look at targets), so remove it.
        if string.match(agent_name, "adv_") or string.match(agent_name, "obj_") then
            --make sure that the current agent that we are deleting is not a skybox, we will need it
            if not (agent_name == "obj_skydomeTruckStopExterior") then
                Custom_RemoveAgent(agent_name, kScene);
            end
        end
    end
    
    --remove other specific lights in the scene (there are a couple that we are keeping however because we need them for when relightng later);
    Custom_RemoveAgent("light_Amb_int", kScene);
    Custom_RemoveAgent("light_ambEnlighten", kScene);
    Custom_RemoveAgent("light_wall_highlight", kScene);
    Custom_RemoveAgent("light_ENV_P_stallLight01", kScene);
    Custom_RemoveAgent("light_ENV_P_stallLight02", kScene);
end

--creates the enviorment that the cutscene will take place in
Scene_CreateEnviorment = function(kScene)
    --create a group object that the enviorment meshes/objects will be parented to (so we can scroll the enviorment later to make it look like characters are walking through the scene).
    local tile_group = AgentCreate("env_tile", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    
    --instantiate our enviorment meshes/objects into the scene
    local tile1 = AgentCreate("env_tile1", "obj_riverShoreTrailTileLower_foliageBrushMeshesA.prop", Vector(0.000000,0.000000,24.000000), Vector(0,0,0), kScene, false, false);
    local tile2 = AgentCreate("env_tile2", "obj_riverShoreTrailTileLower_foliageBrushMeshesB.prop", Vector(0.119385,0.302429,0.314697), Vector(0,0,0), kScene, false, false);
    local tile3 = AgentCreate("env_tile3", "obj_riverShoreTrailTileLower_foliageBrushMeshesC.prop", Vector(12.000000,0.000000,-14.000000), Vector(0,0,0), kScene, false, false);
    local tile4 = AgentCreate("env_tile4", "obj_riverShoreTrailTileLower_foliageBrushMeshesD.prop", Vector(-0.357460,0.000000,48.000000), Vector(0,0,0), kScene, false, false);
    local tile5 = AgentCreate("env_tile5", "obj_riverShoreTrailTileLower_foliageBrushMeshesE.prop", Vector(-0.443689,0.000000,71.967827), Vector(0,0,0), kScene, false, false);
    local tile6 = AgentCreate("env_tile6", "obj_riverShoreTrailTileLower_foliageTreeMeshesA.prop", Vector(0.000000,0.000000,24.000000), Vector(0,0,0), kScene, false, false);
    local tile7 = AgentCreate("env_tile7", "obj_riverShoreTrailTileLower_foliageTreeMeshesB.prop", Vector(0.000000,0.000000,0.000000), Vector(0,0,0), kScene, false, false);
    local tile8 = AgentCreate("env_tile8", "obj_riverShoreTrailTileLower_foliageTreeMeshesC.prop", Vector(12.000000,0.000000,-14.000000), Vector(0,-90,0), kScene, false, false);
    local tile9 = AgentCreate("env_tile9", "obj_riverShoreTrailTileLower_foliageTreeMeshesD.prop", Vector(-0.357460,0.000000,48.000000), Vector(0,180,0), kScene, false, false);
    local tile10 = AgentCreate("env_tile10", "obj_riverShoreTrailTileLower_foliageTreeMeshesE.prop", Vector(-0.443689,0.000000,71.967827), Vector(0,0,0), kScene, false, false);
    local tile11 = AgentCreate("env_tile11", "obj_riverShoreTrailTileLowerA.prop", Vector(0.000000,0.000000,24.000000), Vector(0,0,0), kScene, false, false);
    local tile12 = AgentCreate("env_tile12", "obj_riverShoreTrailTileLowerB.prop", Vector(0.000000,0.000000,0.000000), Vector(0,0,0), kScene, false, false);
    local tile13 = AgentCreate("env_tile13", "obj_riverShoreTrailTileLowerC.prop", Vector(12.000000,0.000000,-14.000000), Vector(0,-90,0), kScene, false, false);
    local tile14 = AgentCreate("env_tile14", "obj_riverShoreTrailTileLowerD.prop", Vector(-0.357460,0.000000,48.000000), Vector(0,-180,0), kScene, false, false);
    local tile15 = AgentCreate("env_tile15", "obj_riverShoreTrailTileLowerE.prop", Vector(-0.443689,0.000000,71.967827), Vector(0,0,0), kScene, false, false);
    local tile16 = AgentCreate("env_tile16", "obj_riverShoreTrailTileLowerF.prop", Vector(0.000000,0.000000,71.967827), Vector(0,0,0), kScene, false, false);
    
    --attach it to the enviormnet group we created earlier
    AgentAttach(tile1, tile_group);
    AgentAttach(tile2, tile_group);
    AgentAttach(tile3, tile_group);
    AgentAttach(tile4, tile_group);
    AgentAttach(tile5, tile_group);
    AgentAttach(tile6, tile_group);
    AgentAttach(tile7, tile_group);
    AgentAttach(tile8, tile_group);
    AgentAttach(tile9, tile_group);
    AgentAttach(tile10, tile_group);
    AgentAttach(tile11, tile_group);
    AgentAttach(tile12, tile_group);
    AgentAttach(tile13, tile_group);
    AgentAttach(tile14, tile_group);
    AgentAttach(tile15, tile_group);
    AgentAttach(tile16, tile_group);
    
    --move the whole enviorment to a good starting point
    Custom_SetAgentWorldPosition("env_tile", Vector(1.35, 0, -34), kScene);
end

--adds additional grass meshes to make the enviorment/ground look more pleasing and not so flat/barren/low quality
Scene_AddProcedualGrass = function(kScene)
    --the amount of grass objects placed on the x and z axis (left and right, forward and back)
    local grassCountX = 40;
    local grassCountZ = 40;
    --local grassCountX = 140; --STRESS TEST
    --local grassCountZ = 140; --STRESS TEST
    
    --the spacing between the grass objects
    local grassPlacementIncrement = 0.375;
    
    --the starting point for the grass placement
    local grassPositionStart = Vector(-(grassCountX / 2) * grassPlacementIncrement, 0.0, -(grassCountZ / 2) * grassPlacementIncrement);

    --the base name of a grass object
    local grassAgentName = "myObject_grass";

    --the prop (prefab) object file for the grass
    local grassPropFile = "obj_grassHIRiverCampWalk.prop"
    
    --and lets create a group object that we will attach all the spawned grass objects to, to make it easier to move the placement of the grass.
    local newGroup = AgentCreate("procedualGrassGroup", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    
    --loop x amount of times for the x axis
    for x = 1, grassCountX, 1 do 
        --calculate our x position right now
        local newXPos = grassPositionStart.x + (x * grassPlacementIncrement);
        
        --loop z amount of times for the z axis
        for z = 1, grassCountZ, 1 do 
            --build the agent name for the current new grass object
            local xIndexString = tostring(x);
            local zIndexString = tostring(z);
            local newAgentName = grassAgentName .. "_x_" .. xIndexString .. "_z_" .. zIndexString;

            --claculate the z position
            local newZPos = grassPositionStart.z + (z * grassPlacementIncrement);
            
            --randomize the Y rotation
            local newYRot = math.random(0, 180);
            
            --randomize the scale
            local scaleOffset = math.random(0, 0.6);
            
            --combine our calculated position/rotation/scale values
            local newPosition = Vector(newXPos, grassPositionStart.y, newZPos);
            local newRotation = Vector(0, newYRot, 0);
            local newScale = 0.75 + scaleOffset;

            --instantiate the new grass object using our position/rotation
            local newGrassAgent = AgentCreate(newAgentName, grassPropFile, newPosition, newRotation, kScene, false, false);
            
            --scale the grass
            Custom_AgentSetProperty(newAgentName, "Render Global Scale", newScale, kScene);
                
            --attach it to the main grass group
            AgentAttach(newGrassAgent, newGroup);
        end
    end
end

--adds additional particle effects to the scene to help make it more lively
Scene_AddAdditionalParticleEffects = function(kScene)
    --note: normally for modifying properties on an agent you would have the actual property name.
    --however after extracting all the strings we could get from the game exectuable, and also all of the lua scripts in the entire game
    --not every single property name was listed, and attempting to print all of the (keys) in the properties object throws out symbols instead.
    --so painfully, PAINFULLY through trial and error I found the right symbol keys I was looking for, and we basically set the given property like normal using the symbol.
    --note for telltale dev: yes I tried many times to use your dang SymbolToString on those property keys but it doesn't actually do anything!!!!!

    --create a dust particle effect that spawns dust particles where the camera looks (this effect is borrowed from S4)
    local fxDust1 = AgentCreate("myFX_dust1", "fx_camDustMotes.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local fxDust1_props = AgentGetRuntimeProperties(fxDust1); --get the properties of the particle system, since we want to modify it.
    Custom_SetPropertyBySymbol(fxDust1_props, "689599953923669477", true); --enable emitter
    Custom_SetPropertyBySymbol(fxDust1_props, "4180975590232535326", 0.011); --particle size
    Custom_SetPropertyBySymbol(fxDust1_props, "2137029241144994061", 0.5); --particle count
    Custom_SetPropertyBySymbol(fxDust1_props, "907461805036530086", 0.55); --particle speed
    Custom_SetPropertyBySymbol(fxDust1_props, "459837671211266514", 0.2); --rain random size
    Custom_SetPropertyBySymbol(fxDust1_props, "2293817456966484758", 2.0); --rain diffuse intensity
    
    --create a leaves particle effect that spawns leaves particles where the camera looks (this effect is borrowed from S4)
    local fxLeaves1 = AgentCreate("myFX_leaves1", "fx_camLeaves.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local fxLeaves1_props = AgentGetRuntimeProperties(fxLeaves1); --get the properties of the particle system, since we want to modify it.
    Custom_SetPropertyBySymbol(fxLeaves1_props, "689599953923669477", true); --enable emitter
    Custom_SetPropertyBySymbol(fxLeaves1_props, "4180975590232535326", 0.121); --particle size
    Custom_SetPropertyBySymbol(fxLeaves1_props, "2137029241144994061", 27.0); --particle count
    Custom_SetPropertyBySymbol(fxLeaves1_props, "907461805036530086", 1.35); --particle speed
    Custom_SetPropertyBySymbol(fxLeaves1_props, "459837671211266514", 0.5); --rain random size
    Custom_SetPropertyBySymbol(fxLeaves1_props, "2293817456966484758", 1.0); --rain diffuse intensity
end

--relights the new enviorment so that it actually looks nice and is presentable
Scene_RelightScene = function(kScene, agent_name_scene)
    --remeber that we didn't delete every single light in the scene?
    --well now we need them because when creating new lights, by default their lighting groups (which basically mean what objects in the scene the lights will actually affect)
    --are not assigned (or at the very least, are not set to a value that affects the main lighting group of all objects in the scene)
    --and unfortunately the actual value is some kind of userdata object, so to get around that, we use an existing light as our crutch
    --and grab the actual group values/data from that object so that we can actually properly create our own lights that actually affect the scene
    
    --find the original sunlight in the scene
    local envlight  = AgentFindInScene("light_DIR", kScene);
    local envlight_props = AgentGetRuntimeProperties(envlight);
    local envlight_groupEnabled = PropertyGet(envlight_props, "EnvLight - Enabled Group");
    local envlight_groups = PropertyGet(envlight_props, "EnvLight - Groups");
    
    --find the original sky light in the scene (note telltale dev, why do you use a light source for the skybox when you could've just had the sky be an (emmissive/unlit) shader?)
    local skyEnvlight  = AgentFindInScene("light_amb_sky", kScene);
    local skyEnvlight_props = AgentGetRuntimeProperties(skyEnvlight);
    local skyEnvlight_groupEnabled = PropertyGet(skyEnvlight_props, "EnvLight - Enabled Group");
    local skyEnvlight_groups = PropertyGet(skyEnvlight_props, "EnvLight - Groups");
    
    --the main prop (like a prefab) file for a generic light
    local envlight_prop = "module_env_light.prop";
    
    --calculate some new colors
    local sunColor     = RGBColor(255, 230, 198, 255);
    local ambientColor = RGBColor(108, 150, 225, 255);
    local skyColor     = RGBColor(0, 80, 255, 255);
    local fogColor     = Desaturate_RGBColor(skyColor, 0.7);
    
    --adjust the colors a bit (yes there is a lot of tweaks... would be easier if we had a level editor... but we dont yet)
    skyColor = Desaturate_RGBColor(skyColor, 0.2);
    fogColor = Multiplier_RGBColor(fogColor, 2.8);
    fogColor = Desaturate_RGBColor(fogColor, 0.45);
    sunColor = Desaturate_RGBColor(sunColor, 0.15);
    skyColor = Desaturate_RGBColor(skyColor, 0.2);
    sunColor = Desaturate_RGBColor(sunColor, 0.15);
    ambientColor = Desaturate_RGBColor(ambientColor, 0.35);
    ambientColor = Multiplier_RGBColor(ambientColor, 1.8);
    
    --set the alpha value of the fog color to be fully opaque
    local finalFogColor = Color(fogColor.r, fogColor.g, fogColor.b, 1.0);
    
    --change the properties of the fog
    Custom_AgentSetProperty("module_environment", "Env - Fog Color", finalFogColor, kScene);
    Custom_AgentSetProperty("module_environment", "Env - Fog Start Distance", 3.25, kScene);
    Custom_AgentSetProperty("module_environment", "Env - Fog Height", 2.85, kScene);
    Custom_AgentSetProperty("module_environment", "Env - Fog Density", 0.525, kScene);
    Custom_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 1, kScene);
    Custom_AgentSetProperty("module_environment", "Env - Fog Enabled", true, kScene);
    Custom_AgentSetProperty("module_environment", "Env - Enabled", true, kScene);
    Custom_AgentSetProperty("module_environment", "Env - Enabled on High", true, kScene);
    Custom_AgentSetProperty("module_environment", "Env - Enabled on Medium", true, kScene);
    Custom_AgentSetProperty("module_environment", "Env - Enabled on Low", true, kScene);
    Custom_AgentSetProperty("module_environment", "Env - Priority", 1000, kScene);
    
    --create our sunlight and set the properties accordingly
    local myLight_Sun = AgentCreate("myLight_Sun", envlight_prop, Vector(0,0,0), Vector(40, -175), kScene, false, false);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Type", 2, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Intensity", 12, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Enlighten Intensity", 0.0, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Radius", 1, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Distance Falloff", 1, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Spot Angle Inner", 5, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Spot Angle Outer", 45, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Color", sunColor, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Enabled Group", envlight_groupEnabled, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Groups", envlight_groups, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Type", 2, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Wrap", 0.0, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - Shadow Quality", 3, kScene);
    Custom_AgentSetProperty("myLight_Sun", "EnvLight - HBAO Participation Type", 1, kScene);

    --ambient light foliage
    Custom_AgentSetProperty("light_Amb_foliage", "EnvLight - Intensity", 1, kScene);
    Custom_AgentSetProperty("light_Amb_foliage", "EnvLight - Color", sunColor, kScene);
    
    --sky light/color
    Custom_AgentSetProperty("light_amb_sky", "EnvLight - Intensity", 4, kScene);
    Custom_AgentSetProperty("light_amb_sky", "EnvLight - Color", skyColor, kScene);
    
    --create a spotlight that emulates the sundisk in the sky
    local myLight_SkySun = AgentCreate("myLight_SkySun", envlight_prop, Vector(0,0,0), Vector(-54, 5, 0), kScene, false, false);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Type", 1, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Intensity", 55, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Enlighten Intensity", 0.0, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Radius", 2555, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Distance Falloff", 1, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Inner", 5, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Spot Angle Outer", 25, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Color", sunColor, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Enabled Group", skyEnvlight_groupEnabled, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Groups", skyEnvlight_groups, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Type", 0, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Wrap", 0.0, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - Shadow Quality", 0, kScene);
    Custom_AgentSetProperty("myLight_SkySun", "EnvLight - HBAO Participation Type", 1, kScene);

    --remove original sun since we created our own and only needed it for getting the correct lighting groups.
    Custom_RemoveAgent("light_DIR", kScene);

    --modify the scene post processing
    Custom_AgentSetProperty(agent_name_scene, "FX anti-aliasing", true, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Sharp Shadows Enabled", true, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Ambient Occlusion Enabled", true, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Tonemap Intensity", 1.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Tonemap White Point", 8.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Tonemap Black Point", 0.005, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Toe Intensity", 1.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Tonemap Type", 2, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Pivot", 0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene);
    Custom_AgentSetProperty(agent_name_scene, "HBAO Enabled", true, kScene);
    Custom_AgentSetProperty(agent_name_scene, "HBAO Intensity", 1.5, kScene);
    Custom_AgentSetProperty(agent_name_scene, "HBAO Radius", 0.75, kScene);
    Custom_AgentSetProperty(agent_name_scene, "HBAO Max Radius Percent", 0.5, kScene);
    Custom_AgentSetProperty(agent_name_scene, "HBAO Max Distance", 35.5, kScene);
    Custom_AgentSetProperty(agent_name_scene, "HBAO Distance Falloff", 0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "HBAO Hemisphere Bias", -0.2, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Bloom Threshold", -0.35, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Bloom Intensity", 0.10, kScene);
    Custom_AgentSetProperty(agent_name_scene, "Ambient Color", ambientColor, kScene);
    Custom_AgentSetProperty(agent_name_scene, "Shadow Color", RGBColor(0, 0, 0, 0), kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Vignette Tint Enabled", true, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Vignette Tint", RGBColor(0, 0, 0, 255), kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Vignette Falloff", 1.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Vignette Center", 0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Vignette Corners", 1.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "LightEnv Saturation", 1.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity Shadow", 1.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "LightEnv Reflection Intensity", 1.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "LightEnv Shadow Max Distance", 20.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "LightEnv Dynamic Shadow Max Distance", 25.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "LightEnv Shadow Position Offset Bias", 0.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "LightEnv Shadow Depth Bias", -1.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "LightEnv Shadow Auto Depth Bounds", false, kScene);
    Custom_AgentSetProperty(agent_name_scene, "LightEnv Shadow Light Bleed Reduction", 0.8, kScene);
    Custom_AgentSetProperty(agent_name_scene, "LightEnv Shadow Moment Bias", 0.0, kScene);
    Custom_AgentSetProperty(agent_name_scene, "Specular Multiplier Enabled", true, kScene);
    Custom_AgentSetProperty(agent_name_scene, "Specular Color Multiplier", 55, kScene);
    Custom_AgentSetProperty(agent_name_scene, "Specular Intensity Multiplier", 1, kScene);
    Custom_AgentSetProperty(agent_name_scene, "Specular Exponent Multiplier", 1, kScene);
    Custom_AgentSetProperty(agent_name_scene, "FX Noise Scale", 1, kScene);
end