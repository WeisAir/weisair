-------------------------------------------
-- Sim Innovations - All rights reserved --
--        Robinson R22 Altimeter         --
-------------------------------------------

prop_bezel = user_prop_add_boolean("Bezel", true, "Show the bezel and screws")

img_add_fullscreen("bezel_background.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )
img_baro_scale = img_add("baro_scale.png", 25, 25, 500, 500)
img_add("background.png", 25, 25, 500, 500)
img_10000ft = img_add("10000ftpointer.png", 115, 115, 320, 320)
img_1000ft = img_add("1000ftneedle.png", 225, 0, 100, 500)
img_100ft = img_add("100ftneedle.png", 225, 0, 100, 500)
img_add_fullscreen("bezel.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )
img_dial = img_add("dial.png", 0, 428, 122, 122)
visible(img_dial, user_prop_get(prop_bezel) )

-- Functions --
function new_data(altitude, press_set)

    -- Rotate the barometric pressure setting scale
    press_set = var_cap(press_set, 28.5, 30.7)
    rotate(img_baro_scale, 0.1 + (-160 / 2.2 * (press_set - 28.5)) )
    
    -- Rotate the 100 ft needle
    rotate(img_100ft, 360 / 1000 * altitude)
    
    -- Rotate the 1000 ft needle
    rotate(img_1000ft, 360 / 10000 * altitude)
    
    -- Rotate the 10.000 ft indicator
    rotate(img_10000ft, 360 / 100000 * altitude)
    
end

-- Subscribe to data --
xpl_dataref_subscribe("sim/flightmodel/misc/h_ind", "FLOAT",
                      "sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", "FLOAT", new_data)
fsx_variable_subscribe("INDICATED ALTITUDE", "Feet",
                       "KOHLSMAN SETTING HG", "inHg", new_data)
fs2020_variable_subscribe("INDICATED ALTITUDE", "Feet",
                          "KOHLSMAN SETTING HG", "inHg", new_data)

function new_baro(alt)

    if alt == 1 then
        xpl_command("sim/instruments/barometer_down")
        fsx_event("KOHLSMAN_DEC")
        fs2020_event("KOHLSMAN_DEC")
    elseif alt == -1 then
        xpl_command("sim/instruments/barometer_up")
        fsx_event("KOHLSMAN_INC")
        fs2020_event("KOHLSMAN_INC")
    end

end

-- Dial
-- Detent settings
detent_settings = {}
detent_settings["1 detent/pulse"]  = "TYPE_1_DETENT_PER_PULSE"
detent_settings["2 detents/pulse"] = "TYPE_2_DETENT_PER_PULSE"
detent_settings["4 detents/pulse"] = "TYPE_4_DETENT_PER_PULSE"

baro_rotary_setting = user_prop_add_enum("Baro setting", "1 detent/pulse,2 detents/pulse, 4 detents/pulse", "2 detents/pulse", "Select your rotary encoder type")

hw_dial_add("Baro dial", detent_settings[user_prop_get(baro_rotary_setting)], 2, new_baro)
dial_baro = dial_add(nil, 0, 428, 122, 122, new_baro)
visible(dial_baro, user_prop_get(prop_bezel) )