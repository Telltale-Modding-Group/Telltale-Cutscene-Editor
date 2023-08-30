--||||||||||||||||||||| EXTENDED SCENE AGENT FUNCTIONS |||||||||||||||||||||
--||||||||||||||||||||| EXTENDED SCENE AGENT FUNCTIONS |||||||||||||||||||||
--||||||||||||||||||||| EXTENDED SCENE AGENT FUNCTIONS |||||||||||||||||||||
--these are extensions of the existing telltale scene agent functions
--they are here mostly to make it easier to work with agents, but also reduce code clutter and the chance of errors

--============ PROPERTIES - BOOL ============
--============ PROPERTIES - BOOL ============
--============ PROPERTIES - BOOL ============

--checks if an agent has a property by name
Custom_AgentHasProperty = function(agentName, propertyString, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    return AgentHasProperty(agent, propertyString)
end

--============ PROPERTIES - SET ============
--============ PROPERTIES - SET ============
--============ PROPERTIES - SET ============

--sets a property by an agent object
Custom_PropertySet = function(agent, propertyString, propertyValue)
    local agent_props = AgentGetRuntimeProperties(agent)
    PropertySet(agent_props, propertyString, propertyValue)
end

--sets a property on an agent by name
Custom_AgentSetProperty = function(agentName, propertyString, propertyValue, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    Custom_PropertySet(agent, propertyString, propertyValue)
end

--forcibly sets a property on an agent by name
Custom_AgentForceSetProperty = function(agentName, propertyString, propertyValueType, propertyValue, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    local agent_props = AgentGetProperties(agent)
	--local agent_props = AgentGetRuntimeProperties(agent)

	if not (AgentHasProperty(agent, propertyString)) then
        PropertyCreate(agent_props, propertyString, propertyValueType, propertyValue)
	end

    PropertySet(agent_props, propertyString, propertyValue)
end

--sets a property on all agents with the given prefix in a scene
Custom_SetPropertyOnAgentsWithPrefix = function(sceneObject, prefixString, propertyString, propertyValue)
    --get all agents in the scene
    local scene_agents = SceneGetAgents(sceneObject)
    
    --initalize an empty list that will contain all the agents we found by name
    local agents_names = {}
    
    --fill out rig agents list
    for i, agent_object in pairs(scene_agents) do
        --get the agent name
        local agent_name = tostring(AgentGetName(agent_object))
        
        --check if the agent name contains the prefix, if it does then add it to our agent_names table
        if (string.match)(agent_name, prefixString) then
            table.insert(agents_names, agent_name)
        end
    end
    
    --find each agent in the scene and set the desired property
    for x, list_agent_name in pairs(agents_names) do
        Custom_AgentSetProperty(list_agent_name, propertyString, propertyValue, sceneObject)
    end
end

--sets a property on all cameras in a scene
Custom_SetPropertyOnAllCameras = function(sceneObject, propertyString, propertyValue)
    --get all agents in the scene
    local scene_agents = SceneGetAgents(sceneObject)
    
    --initalize an empty list that will contain all the agents we found by name
    local agents_names = {}
    
    --fill out rig agents list
    for i, agent_object in pairs(scene_agents) do
        --get the agent name
        local agent_name = tostring(AgentGetName(agent_object))
        
        --check if the agent name contains the prefix, if it does then add it to our agent_names table
        if (string.match)(agent_name, "cam_") then
            table.insert(agents_names, agent_name)
        end
    end
    
    --find each agent in the scene and set the desired property
    for x, list_agent_name in pairs(agents_names) do
        Custom_AgentSetProperty(list_agent_name, propertyString, propertyValue, sceneObject)
    end
end

--============ PROPERTIES - GET ============
--============ PROPERTIES - GET ============
--============ PROPERTIES - GET ============

--gets a property by an agent object
Custom_PropertyGet = function(agent, propertyString)
    local agent_props = AgentGetRuntimeProperties(agent)
    return PropertyGet(agent_props, propertyString)
end

--gets a property on an agent by name
Custom_AgentGetProperty = function(agentName, propertyString, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    return Custom_PropertyGet(agent, propertyString)
end

--gets properties on an agent by name
Custom_AgentGetProperties = function(agentName, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    return AgentGetProperties(agent)
end

--gets runtime properties on an agent by name
Custom_AgentGetRuntimeProperties = function(agentName, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    return AgentGetRuntimeProperties(agent)
end

--============ TRANSFORMATION - SET ============
--============ TRANSFORMATION - SET ============
--============ TRANSFORMATION - SET ============
--for moving and rotating agents

--rotates an agent by name
Custom_SetAgentRotation = function(agentName, rotationValue, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    AgentSetRot(agent, rotationValue)
end

--positions an agent by name
Custom_SetAgentPosition = function(agentName, positionValue, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    AgentSetPos(agent, positionValue)
end

--rotates an agent in world space by name
Custom_SetAgentWorldRotation = function(agentName, rotationValue, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    AgentSetWorldRot(agent, rotationValue)
end

--positions an agent in world space by name
Custom_SetAgentWorldPosition = function(agentName, positionValue, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    AgentSetWorldPos(agent, positionValue)
end

--============ TRANSFORMATION - GET ============
--============ TRANSFORMATION - GET ============
--============ TRANSFORMATION - GET ============
--for getting rotation/position of agents

--gets an agents rotation by name
Custom_GetAgentRotation = function(agentName, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    return AgentGetRot(agent)
end

--gets an agents position by name
Custom_GetAgentPosition = function(agentName, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    return AgentGetPos(agent)
end

--gets an agents world rotation by name
Custom_GetAgentWorldRotation = function(agentName, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    return AgentGetWorldRot(agent)
end

--gets an agents world position by name
Custom_GetAgentWorldPosition = function(agentName, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    return AgentGetWorldPos(agent)
end

--============ UTILLITY ============
--============ UTILLITY ============
--============ UTILLITY ============

--hides an agent by name
Custom_HideAgent = function(agentName, sceneObject)
    local agent = AgentFindInScene(agentName, sceneObject)
    AgentHide(agent)
end

--sets an agents visibility by name
Custom_SetAgentVisibillity = function(agentName, visibilityValue, sceneObject)
    Custom_AgentSetProperty(agentName, "Runtime: Visible", visibilityValue, sceneObject)
end

--sets an agents culling mode
Custom_SetAgentCulling = function(agentName, cullValue, sceneObject)
    Custom_AgentSetProperty(agentName, "Render Cull", cullValue, sceneObject)
end

--sets an agent render scale
Custom_SetAgentScale = function(agentName, scaleValue, sceneObject)
    Custom_AgentSetProperty(agentName, "Render Global Scale", scaleValue, sceneObject)
end

--sets an agent shadow casting
Custom_SetAgentShadowCasting = function(agentName, castsShadows, sceneObject)
    Custom_AgentSetProperty(agentName, "Render EnvLight Shadow Cast Enable", castsShadows, sceneObject)
    Custom_AgentSetProperty(agentName, "Render Shadow Force Visible", castsShadows, sceneObject)
end

--checks if an agent exists, then removes an agent by name
Custom_RemoveAgent = function(agentName, sceneObj)
   if AgentExists(AgentGetName(agentName)) then
       local agent = AgentFindInScene(agentName, sceneObj)
       AgentDestroy(agent)
   end
end

--removes agents in a scene with a prefix
Custom_RemovingAgentsWithPrefix = function(sceneObject, prefixString)
    --get all agents in the scene
    local scene_agents = SceneGetAgents(sceneObject)
    
    --initalize an empty list that will contain all the agents we found by name
    local agents_names = {}
    
    --fill out rig agents list
    for i, agent_object in pairs(scene_agents) do
        --get the agent name
        local agent_name = tostring(AgentGetName(agent_object))
        
        --check if the agent name contains the prefix, if it does then add it to our agent_names table
        if (string.match)(agent_name, prefixString) then
            table.insert(agents_names, agent_name)
        end
    end
    
    --start removing agents in the list
    for x, list_agent_name in pairs(agents_names) do
        Custom_RemoveAgent(list_agent_name, sceneObject)
    end
end

--removes agents in a scene with a prefix
Custom_ReplaceAgentsWithPrefixWithDummy = function(sceneObject, prefixString)
    --get all agents in the scene
    local scene_agents = SceneGetAgents(sceneObject)
    
    --initalize an empty list that will contain all the agents we found by name
    local agents_names = {}
    
    --fill out rig agents list
    for i, agent_object in pairs(scene_agents) do
        --get the agent name
        local agent_name = tostring(AgentGetName(agent_object))
        
        --check if the agent name contains the prefix, if it does then add it to our agent_names table
        if (string.match)(agent_name, prefixString) then
            table.insert(agents_names, agent_name)
        end
    end
    
    --start removing agents in the list
    for x, list_agent_name in pairs(agents_names) do
        Custom_RemoveAgent(list_agent_name, sceneObject)
        
        local dummyAgent = AgentCreate(list_agent_name, "group.prop", Vector(0,0,0), Vector(0,0,0), sceneObject, false, false)
    end
end

--using a comparison agent, returns the nearest agent of the two given
Custom_GetNearestAgent = function(comparisonAgent, agentOne, agentTwo)
    local distance_agentOne = AgentDistanceToAgent(comparisonAgent, agentOne); --number type
    local distance_agentTwo = AgentDistanceToAgent(comparisonAgent, agentTwo); --number type
    
    if (distance_agentOne < distance_agentTwo) then
        return agentOne;
    else
        return agentTwo;
    end
end

--using a comparison agent, returns the farthest agent of the two given
Custom_GetFarthestAgent = function(comparisonAgent, agentOne, agentTwo)
    local distance_agentOne = AgentDistanceToAgent(comparisonAgent, agentOne); --number type
    local distance_agentTwo = AgentDistanceToAgent(comparisonAgent, agentTwo); --number type
    
    if (distance_agentOne > distance_agentTwo) then
        return agentOne;
    else
        return agentTwo;
    end
end

--performs a raycast from a given agent, to another agent
--returns true when raycast intersects with scene geometry
--returns false when raycast doesn't intersect with geometry
Custom_RaycastFromAgentToAgent = function(fromAgent, toAgent)
	--calculate ray origin
	local rayOrigin = AgentGetWorldPos(fromAgent);
	
	if AgentHasNode(fromAgent, "eye_L") and AgentHasNode(fromAgent, "eye_R") then
		rayOrigin = AgentGetWorldPosBetweenNodes(fromAgent, "eye_R", "eye_L");
	else
		if AgentHasNode(fromAgent, "Head") then
			rayOrigin = AgentGetWorldPos(fromAgent, "Head");
		end
	end
	
	--calculate ray direction
	local rayDirection = AgentGetWorldPos(toAgent) - rayOrigin;
	
	if AgentHasNode(toAgent, "Root") then
		rayDirection = AgentGetWorldPos(toAgent, "Root") - rayOrigin;
    else
		if AgentHasNode(toAgent, "Head") then
			rayDirection = AgentGetWorldPos(toAgent, "Head") - rayOrigin;
		end
    end
	
	--perform a raycast
	if MathRaySceneIntersect(rayOrigin, rayDirection, AgentGetScene(fromAgent)) then
		return true;
    else
		return false;
	end
end

--plays a .chore specifically on an agent
Custom_ChorePlayOnAgent = function(chore, agentName, priority, bWait)
    --if a priority value is not given (nil)
    if not priority then
        priority = 100;
    end

    if bWait then --if bWait value is given
        ChorePlayAndWait(chore, priority, "default", agentName);
    else --if there is no bWait value given (nil)
        return ChorePlay(chore, priority, "default", agentName);
    end
end