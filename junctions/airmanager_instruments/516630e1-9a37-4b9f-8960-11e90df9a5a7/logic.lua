    -- Aerosoft F-14X VSI--
------------------------------
-- Load and display images  --
------------------------------
img_add_fullscreen("VSI_Outer.png")
img_add_fullscreen("VSI_Gauge_Face.png")
img_needle = img_add_fullscreen("VSI_Needle_FS.png")

function new_vs(fpm)
    
    fpm = var_cap(fpm, -6000, 6000)

    if fpm <= 1000 and fpm >= -1000 then
        rotate(img_needle, fpm * 70 / 1000)
    elseif fpm > 1000 and fpm <= 1500  then
        rotate(img_needle, (fpm * 40 / 1000) +30)
    elseif fpm < -1000 and fpm >= -1500 then 
        rotate(img_needle, (fpm * 40 / 1000) -30)
    elseif fpm > 1500 and fpm <= 2000 then
        rotate(img_needle, (fpm * 30 / 1000) +46)
    elseif fpm < -1500 and fpm >= -2000 then 
        rotate(img_needle, (fpm * 30 / 1000) -46)
    elseif fpm > 2000 then
        rotate(img_needle, (fpm * 16 / 1000) +74)
    else-- For fpm < -2000 
        rotate(img_needle, (fpm * 16 / 1000) -74)
    end

end

-- Variable subscribe
fsx_variable_subscribe("VERTICAL SPEED", "Feet per minute", new_vs)
fs2020_variable_subscribe("VERTICAL SPEED", "Feet per minute", new_vs)
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/vvi_fpm_pilot", "FLOAT", new_vs)

