-----------------------------------------------
-- GAUGE CREATED BY : ISURU ABEYKOON (SIMHOPER)
-- VER : JUNE/2020
-----------------------------------------------

img_add_fullscreen("FLAP_back2.png")
img_needle = img_add_fullscreen("FLAP_needle.png")

function callback_flap(pos)

   var_cap(pos, 0, 70)
   rotate(img_needle, pos * 90 )

end

xpl_dataref_subscribe("sim/flightmodel/controls/flaprat", "FLOAT", callback_flap)