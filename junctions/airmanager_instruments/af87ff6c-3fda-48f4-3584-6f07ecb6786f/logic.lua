-----------------------------------------------
-- GAUGE CREATED BY : ISURU ABEYKOON (SIMHOPER)
-- VER : JUNE/2020
-----------------------------------------------


img_add_fullscreen("PRPM_back.png")
img_needle = img_add_fullscreen("TQ_needle.png")

prop_eng = user_prop_add_enum("Engine", "Left,Right", "Left", "Choose the engine.")
rotate(img_needle, -106)


function new_propspeed(propspeed)

    rpm = var_cap(fif(user_prop_get(prop_eng) == "Left", propspeed[1], propspeed[2]), 0, 1600)
    
    if rpm >= 1500 then
        rotate(img_needle, 68 / 200 * (rpm - 1500) + 101)
    elseif rpm >= 1300 then
        rotate(img_needle, 68 / 200 * (rpm - 1300) + 34)
    elseif rpm >= 1100 then
        rotate(img_needle, 68 / 200 * (rpm - 1100) + -32.5)
    elseif rpm < 1100 then
        rotate(img_needle, 80 / 1200 * rpm + -106)
    end

end

xpl_dataref_subscribe("sim/cockpit2/engine/indicators/prop_speed_rpm", "FLOAT[8]", new_propspeed)