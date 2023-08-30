--||||||||||||||||||||| CUSTOM COLOR FUNCTIONS |||||||||||||||||||||
--||||||||||||||||||||| CUSTOM COLOR FUNCTIONS |||||||||||||||||||||
--||||||||||||||||||||| CUSTOM COLOR FUNCTIONS |||||||||||||||||||||
--I use this to get a little more control in regards to creating/modifying colors.
--There is no visual color picker within the telltale tool that we have access to...
--so these are here to help in regards to geussing and getting the right color easily

--desaturates a regular color
--color = Color(r,g,b,a) object
--amount = number (desaturation amount)
Desaturate_RGBColor = function(color, amount)
    local lumanince = 0.3 * color.r + 0.6 * color.g + 0.1 * color.b;
    
    color.r = color.r + amount * (lumanince - color.r);
    color.g = color.g + amount * (lumanince - color.g);
    color.b = color.b + amount * (lumanince - color.b);
    
    return color;
end

--multiplies a regular color (can be used to brighten or darken)
--color = Color(r,g,b,a) object
--amount = number (multipler amount)
Multiplier_RGBColor = function(color, amount)
    local multiplier = 1.0 * amount;
    
    color.r = color.r * multiplier;
    color.g = color.g * multiplier;
    color.b = color.b * multiplier;
    
    return color;
end

--a regular telltale color wrapper, but these values take in numbers from (0 - 255) and scale it down to (0 - 1) 
--r = (RED) number (0 - 255)
--g = (GREEN) number (0 - 255)
--b = (BLUE) number (0 - 255)
--a = (ALPHA) number (0 - 255)
RGBColor = function(r, g, b, a)
    local scalar  = 1 / 255;
    
    local scaledR = r * scalar;
    local scaledG = g * scalar;
    local scaledB = b * scalar;
    local scaledA = a * scalar;
    
    return Color(scaledR, scaledG, scaledB, scaledA);
end