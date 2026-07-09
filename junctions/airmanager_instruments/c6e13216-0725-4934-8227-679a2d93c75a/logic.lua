img_add_fullscreen("instrument_air_backdrop.png")
img_neddle = img_add("neddle.png",98,0,60,256)
img_add("center.png",98,98,60,60)
rotate(img_neddle,-135)

function PT_suction(suction)
    angle = suction*30-135
    angle = var_cap(angle, -135, 135)

    rotate(img_neddle, angle)
end

-- Bus subscribe
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/suction_1_ratio", "FLOAT", PT_suction)
fsx_variable_subscribe("SUCTION PRESSURE", "inHg", PT_suction)
msfs_variable_subscribe("SUCTION PRESSURE", "inHg", PT_suction)