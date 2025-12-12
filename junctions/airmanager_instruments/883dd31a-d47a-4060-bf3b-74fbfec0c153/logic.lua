---------------------------------------------
--  Sim Innovations - All rights reserved  --
--     Robinson R22 Airspeed indicator     --
---------------------------------------------

prop_bezel = user_prop_add_boolean("Bezel", true, "Show the bezel and screws")

-- Add images --
img_add_fullscreen("bezel_background.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )
img_add("background.png", 25, 25, 500, 500)
img_needle = img_add("needle.png", 250, 25, 50, 500)
img_add_fullscreen("bezel.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )

local settings = { { 0 , 0 },
                   { 15, 4 },
                   { 20, 11 },
                   { 25, 22 },
                   { 30, 35 },
                   { 35, 49 },
                   { 40, 68 },
                   { 45, 86 },
                   { 50, 107 },
                   { 55, 127 },
                   { 60, 145 },
                   { 65, 169 },
                   { 70, 190 },
                   { 75, 209 },
                   { 80, 230 },
                   { 85, 251 },
                   { 90, 271 },
                   { 95, 290 },
                   { 100, 308 },
                   { 105, 327 } }

-- Functions --
function new_data(airspeed)
    airspeed = var_cap(airspeed, 0, 105)
    rotate(img_needle, interpolate_linear(settings, airspeed) )
end

-- Subscribe to data --
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT", new_data)
fsx_variable_subscribe("AIRSPEED INDICATED", "knots", new_data)
fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", new_data)