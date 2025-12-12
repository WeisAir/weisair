---------------------------------------------
--  Sim Innovations - All rights reserved  --
--  Robinson R22 Vertical speed indicator  --
---------------------------------------------

prop_bezel = user_prop_add_boolean("Bezel", true, "Show the bezel and screws")

-- Add images --
img_add_fullscreen("bezel_background.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )
img_add("background.png", 25, 25, 500, 500)
img_needle = img_add("needle.png", 25, 250, 500, 50)
img_add_fullscreen("bezel.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )

-- Functions --
function new_data(vspeed)

    vspeed = var_cap(vspeed, -2000, 2000)

    if vspeed <= 500 and vspeed >= -500 then
        rotate(img_needle, 35 / 500 * vspeed)
    elseif vspeed > 500 and vspeed <= 1000 then
        rotate(img_needle, 35 + (45.5 / 500 * (vspeed - 500)) )
    elseif vspeed < -500 and vspeed >= -1000 then
        rotate(img_needle, -35 + (45.5 / 500 * (vspeed + 500)) )
    elseif vspeed > 1000 and vspeed <= 1500 then
        rotate(img_needle, 80.5 + (50 / 500 * (vspeed - 1000)) )
    elseif vspeed < -1000 and vspeed >= -1500 then
        rotate(img_needle, -80.5 + (50 / 500 * (vspeed + 1000)) )
    elseif vspeed > 1500 then
        rotate(img_needle, 130.5 + (43 / 500 * (vspeed - 1500)) )
    elseif vspeed < -1500 then
        rotate(img_needle, -130.5 + (43 / 500 * (vspeed + 1500)) )
    end

end

-- Subscribe to data --
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/vvi_fpm_pilot", "FLOAT", new_data)
fsx_variable_subscribe("VERTICAL SPEED", "Feet per minute", new_data)
fs2020_variable_subscribe("VERTICAL SPEED", "Feet per minute", new_data)