-----------------------------------------------
-- GAUGE CREATED BY : ISURU ABEYKOON (SIMHOPER)
-- VER : JUNE/2020

-- Updated by WeisAir
-- VER: AUG/2025
    -- value factor correction
    -- dark bezel
-----------------------------------------------


img_add_fullscreen("TQ_back.png")
img_needle = img_add_fullscreen("TQ_needle2.png")
prop_eng = user_prop_add_enum("Engine", "Left,Right", "Left", "Choose the engine.")
prop_bezel = user_prop_add_boolean("show dark bezel", true, "add a dark bezel overlay to the instrument")

if(user_prop_get(prop_bezel) == true) then
my_image = img_add_fullscreen("bezel_round.png")
end

function callback_tq(tq_left, tq_right)
  
    local tq = fif(user_prop_get(prop_eng) == "Left", tq_left, tq_right)
    rotate(img_needle, 2*tq)

end

xpl_dataref_subscribe("LES/saab/engine_torque_L", "FLOAT", 
                      "LES/saab/engine_torque_R", "FLOAT", callback_tq)