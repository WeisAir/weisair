---------------------------------------------
--  Sim Innovations - All rights reserved  --
--     Robinson R22 Manifold pressure      --
---------------------------------------------

prop_bezel = user_prop_add_boolean("Bezel", true, "Show the bezel and screws")

-- Add images --
img_add_fullscreen("bezel_background.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )
img_add("background.png", 25, 25, 500, 500)
img_needle = img_add("needle.png", 250, 25, 50, 500)
img_add_fullscreen("bezel.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )
rotate(img_needle, 71.424)

-- Functions --
function new_data_xpl(manf)
    manf = var_cap(manf[1], 5, 35)
    rotate(img_needle, -108 + 216 / 30 * (manf - 5), "LOG", 0.05)
end

function new_data_fs(manf)
    manf = var_cap(manf, 5, 35)
    rotate(img_needle, -108 + 216 / 30 * (manf - 5), "LOG", 0.05)
end

-- Subscribe to data --
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/MPR_in_hg", "FLOAT[8]", new_data_xpl)
fsx_variable_subscribe("RECIP ENG MANIFOLD PRESSURE:1", "inHg", new_data_fs)
fs2020_variable_subscribe("RECIP ENG MANIFOLD PRESSURE:1", "inHg", new_data_fs)