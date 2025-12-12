---------------------------------------------
--  Sim Innovations - All rights reserved  --
--     Robinson R22 Rotor & Engine RPM     --
---------------------------------------------

prop_bezel = user_prop_add_boolean("Bezel", true, "Show the bezel and screws")

-- Add images --
img_add_fullscreen("bezel_background.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )
img_add("background.png", 25, 25, 500, 500)
img_needle_e = img_add("needle_left.png", -178, 268, 524, 14)
img_needle_r = img_add("needle_right.png", 204, 268, 524, 14)
img_add("caps.png", 25, 25, 500, 500)
img_add_fullscreen("bezel.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )

rotate(img_needle_e, 51.92)
rotate(img_needle_r, -51.92)

-- Functions --
function new_data_xpl(bat_v, bus_v, e_rpm, r_rpm)
    local power = bat_v[1] >= 8 or bus_v[1] >= 8
    if power then
        e_rpm = var_cap(104 / 2652 * e_rpm[1], 44, 119)
    else
        e_rpm = 44
    end
    rotate(img_needle_e, 44 - (66 / 50 * (e_rpm - 50)), "LOG", 0.07)
    
    if power then
        r_rpm = var_cap(104 / 530 * r_rpm[1], 44, 119)
    else
        r_rpm = 44
    end
    rotate(img_needle_r, -44 + (66 / 50 * (r_rpm - 50)), "LOG", 0.07)
end

function new_data_fs(bat_v, bus_v, e_rpm, r_rpm)
    local power = bat_v >= 8 or bus_v >= 8
    if power then
        e_rpm = var_cap(104 / 2652 * e_rpm, 44, 119)
    else
        e_rpm = 44
    end
    rotate(img_needle_e, 44 - (66 / 50 * (e_rpm - 50)), "LOG", 0.07)
    
    if power then
        r_rpm = var_cap(r_rpm, 44, 119)
    else
        r_rpm = 44
    end
    rotate(img_needle_r, -44 + (66 / 50 * (r_rpm - 50)), "LOG", 0.07)
end

-- Subscribe to data --
xpl_dataref_subscribe("sim/flightmodel/engine/ENGN_bat_volt", "FLOAT[8]",
                      "sim/cockpit2/electrical/bus_volts", "FLOAT[6]",
                      "sim/cockpit2/engine/indicators/engine_speed_rpm", "FLOAT[8]",
                      "sim/cockpit2/engine/indicators/prop_speed_rpm", "FLOAT[8]", new_data_xpl)
fsx_variable_subscribe("ELECTRICAL BATTERY VOLTAGE", "Volts",
                       "ELECTRICAL MAIN BUS VOLTAGE", "Volts",
                       "GENERAL ENG RPM:1", "RPM",
                       "ROTOR RPM PCT", "Percent", new_data_fs)
fs2020_variable_subscribe("ELECTRICAL BATTERY VOLTAGE:1", "Volts",
                          "ELECTRICAL MAIN BUS VOLTAGE:1", "Volts",
                          "GENERAL ENG RPM:1", "RPM", 
                          "ROTOR RPM PCT", "Percent", new_data_fs)