-----------------------------------------------
-- GAUGE CREATED BY : ISURU ABEYKOON (SIMHOPER)
-- VER : JUNE/2020

-- Updated by WeisAir
-- VER: AUG/2025
    -- dark bezel
-----------------------------------------------

img_add_fullscreen("FLAP_back2.png")
img_needle = img_add_fullscreen("FLAP_needle.png")

prop_bezel = user_prop_add_boolean("show dark bezel", true, "add a dark bezel overlay to the instrument")

if(user_prop_get(prop_bezel) == true) then
my_image = img_add_fullscreen("bezel_round.png")
end

function callback_flap(pos)

   var_cap(pos, 0, 70)
   rotate(img_needle, pos * 90 )

end

xpl_dataref_subscribe("sim/flightmodel/controls/flaprat", "FLOAT", callback_flap)