-- ATTITUDE LIBRARY --
-- TO DO TO DO TO DO TO DO TO DO --
-- AOA seems to flutter when on ground, fix this somehow
-- TO DO TO DO TO DO TO DO TO DO --

function lib_aoa_init()

-- Images
img_aoa_gauge = img_add("cws_gauge.png", 458, 90, 74, 87)
img_aoa_needle = img_add("cws_needle.png", 448, 99, 76, 76)
-- Text
txt_aoa = txt_add("0.0", "size:14px; font:monofonto.ttf; color:white; halign:right;", 330, 132, 150, 60)

end

-- Functions
-- function aoa_callback(aoa, local_time)

    -- Angle of attack indicator -5 to 20 degrees
    -- The angle of attack comes in as with 90 (degrees) being zero

--    aoa_visual = var_cap(aoa, -5, 20)
--    rotate(img_aoa_needle, 45 - (180 / 20 * aoa_visual) )
--    txt_set(txt_aoa, string.format("%0.01f", aoa))

-- end

-- Variable subscribe
-- xpl_dataref_subscribe("sim/flightmodel2/misc/AoA_angle_degrees", "FLOAT",
--                       "sim/time/local_time_sec", "FLOAT", aoa_callback)