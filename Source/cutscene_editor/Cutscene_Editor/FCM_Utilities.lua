--||||||||||||||||||||| CUSTOM UTILITIES |||||||||||||||||||||
--||||||||||||||||||||| CUSTOM UTILITIES |||||||||||||||||||||
--||||||||||||||||||||| CUSTOM UTILITIES |||||||||||||||||||||

Custom_Clamp = function(a, minimum, maximum)
	if (a > maximum) then
		return maximum;
	elseif (a < minimum) then
		return minimum;
	else
		return a;
	end
end

Custom_NumberLerp = function(a, b, t)
    return a + (b - a) * t;
end

Custom_Smoothstep = function(a, b, t)
	return a + (b - a) * ( (-2 * math.pow(t, 3)) + (3 * math.pow(t, 2)) );
end

Custom_Repeat = function(t, length)
    return Custom_Clamp(t - math.floor(t / length) * length, 0.0, length);
end

Custom_PingPong = function(t, length)
    t = Custom_Repeat(t, length * 2);
    return length - math.abs(t - length);
end

Custom_VectorLerp = function(a, b, t)
    local newX = Custom_NumberLerp(a.x, b.x, t);
    local newY = Custom_NumberLerp(a.y, b.y, t);
    local newZ = Custom_NumberLerp(a.z, b.z, t);
    
    return Vector(newX, newY, newZ);
end

Custom_VectorSmoothstep = function(a, b, t)
    local newX = Custom_Smoothstep(a.x, b.x, t);
    local newY = Custom_Smoothstep(a.y, b.y, t);
    local newZ = Custom_Smoothstep(a.z, b.z, t);
    
    return Vector(newX, newY, newZ);
end

Custom_ColorLerp = function(colorA, colorB, t)
    local newColorR = Custom_NumberLerp(colorA.r, colorB.r, t);
    local newColorG = Custom_NumberLerp(colorA.g, colorB.g, t);
    local newColorB = Custom_NumberLerp(colorA.b, colorB.b, t);
    local newColorA = Custom_NumberLerp(colorA.a, colorB.a, t);

    return Color(newColorR, newColorG, newColorB, newColorA);
end

Custom_RandomFloatValue = function(min, max, decimals)
    local value = math.random(min * decimals, max * decimals);
    local valueAdjusted = value / decimals;

    return valueAdjusted;
end

Custom_GetTableType = function(tableValue)
	local stringType = "table";
	
	local colorMatch = 0;
	
	for key, value in pairs(tableValue) do
		--if the key is a string type
		if (type(key) == "string") then
			--check if the key name matches the variables of the color type
			if (key == "r") or (key == "g") or (key == "b") or (key == "a") then
				colorMatch = colorMatch + 1
			end
		end
    end
	
	--if the color is a full match then this table is infact a color
	if (colorMatch == 4) then
		stringType = "color";
	end
	
	return stringType;
end