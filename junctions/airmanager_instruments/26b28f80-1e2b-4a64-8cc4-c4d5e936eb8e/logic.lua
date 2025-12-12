img_add_fullscreen("SaabTrim.png")
img_yawneedle = img_add_fullscreen("yawneedle.png")
img_mainpitchneedle = img_add_fullscreen("mainpitchneedle.png")
img_stbpitchneedle = img_add_fullscreen("stbpitchneedle.png")
img_saabrolltrim = img_add("saabrolltrim.png", 140, 70, 220, 220)
img_mainrollneedle = img_add("mainrollneedle.png", 140, 70, 220, 220)
img_stbrollneedle = img_add("stbrollneedle.png", 140, 70, 220, 220)

-- Functions
function new_trim(trim)
    -- -1 = full nose down trim
    -- 0 = take off setting
    -- 1 = full nose down trim
    
    -- pixel range is 250
    move(img_mainpitchneedle, nil, (-120 * var_cap(trim, -1, 1)), nil, nil)
    move(img_stbpitchneedle, nil, (-120 * var_cap(trim, -1, 1)), nil, nil)
end
function new_yawtrim(yawtrim)
    -- -1 = full nose down trim
    -- 0 = take off setting
    -- 1 = full nose down trim
    
    -- pixel range is 250
    move(img_yawneedle, (180 * var_cap(yawtrim, -1, 1)), nil, nil, nil)
end
function PT_roll(roll)
    rotate(img_mainrollneedle, (70 * var_cap(roll, -1, 1)))
    rotate(img_stbrollneedle, (-70 * var_cap(roll, -1, 1)))
end

xpl_dataref_subscribe("LES/saab/trim_indicator/elevator_L", "FLOAT", new_trim)
xpl_dataref_subscribe("LES/saab/trim_indicator/rudder", "FLOAT", new_yawtrim)
xpl_dataref_subscribe("LES/saab/trim_indicator/aileron_L", "FLOAT", PT_roll)