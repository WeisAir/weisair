-------------------------------------------
-- Sim Innovations - All rights reserved --
--       Robinson R22 Gyrocompass        --
-------------------------------------------

prop_bezel = user_prop_add_boolean("Bezel", true, "Show the bezel and screws")

-- Add images --
img_add_fullscreen("bezel_background.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )
img_rose = img_add("background.png", 25, 25, 500, 500)
img_flag = img_add("gyro_flag.png", 7, -60, 226, 240)
img_add("foreground.png", 25, 25, 500, 500)
img_add_fullscreen("bezel.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )

-- Global variables
local gbl_flag_angle = -34
rotate(img_flag, gbl_flag_angle)

-- Functions --
function new_heading_xpl(heading, vacuum)

    rotate(img_rose, heading * -1)

    if vacuum < 1 then
        gbl_flag_angle = -34
    else
        gbl_flag_angle = -7
    end
    
    rotate(img_flag, gbl_flag_angle, "LINEAR", 0.008)

end

function new_heading_fs(heading, vacuum)

    rotate(img_rose, heading * -1)

    if vacuum < 1 then
        gbl_flag_angle = -34
    else
        gbl_flag_angle = -7
    end
    
    rotate(img_flag, gbl_flag_angle, "LINEAR", 0.008)

end

function dial_gyr(direction)

    if direction == -1 then
        xpl_command("sim/instruments/DG_sync_up")
        fsx_event("GYRO_DRIFT_INC")
        fs2020_event("GYRO_DRIFT_INC")
    elseif direction == 1 then
        xpl_command("sim/instruments/DG_sync_down")
        fsx_event("GYRO_DRIFT_DEC")
        fs2020_event("GYRO_DRIFT_DEC")
    end

end

-- DIALS ADD --
-- Detent settings
detent_settings = {}
detent_settings["1 detent/pulse"]  = "TYPE_1_DETENT_PER_PULSE"
detent_settings["2 detents/pulse"] = "TYPE_2_DETENT_PER_PULSE"
detent_settings["4 detents/pulse"] = "TYPE_4_DETENT_PER_PULSE"

gyro_rotary_setting = user_prop_add_enum("Gyro setting", "1 detent/pulse,2 detents/pulse, 4 detents/pulse", "2 detents/pulse", "Select your rotary encoder type")
hw_dial_add("Gyro dial", detent_settings[user_prop_get(gyro_rotary_setting)], 3, dial_gyr)
gyro_dial = dial_add("gyro_dial.png", 0, 432, 118, 118, dial_gyr)

-- Subscribe to data --
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/heading_vacuum_deg_mag_pilot", "FLOAT",
                      "sim/cockpit/misc/vacuum", "FLOAT", new_heading_xpl)
fsx_variable_subscribe("PLANE HEADING DEGREES GYRO", "Degrees",
                       "SUCTION PRESSURE", "inHg", new_heading_fs)
                       
fs2020_variable_subscribe("PLANE HEADING DEGREES GYRO", "Degrees",
                          "SUCTION PRESSURE", "inHg", new_heading_fs)