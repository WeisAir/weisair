-----------------------------------------------
-- GAUGE CREATED BY : ISURU ABEYKOON (SIMHOPER)
-- VER : JUNE/2020
-----------------------------------------------


img_add_fullscreen("TQ_back.png")
img_needle = img_add_fullscreen("TQ_needle2.png")
prop_eng = user_prop_add_enum("Engine", "Left,Right", "Left", "Choose the engine.")

-- X-Plane dataref raneg from 0 to 630
-- Gauge 0 to 120 rotation angle is 235 degrees


function callback_tq(tq_left, tq_right)
  
    local tq = fif(user_prop_get(prop_eng) == "Left", tq_left, tq_right)
    rotate(img_needle, (235 / 630) * tq_left)

end

xpl_dataref_subscribe("LES/saab/engine_torque_L", "FLOAT", 
                      "LES/saab/engine_torque_L", "FLOAT", callback_tq)