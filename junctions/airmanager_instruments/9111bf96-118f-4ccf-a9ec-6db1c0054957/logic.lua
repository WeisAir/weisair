img_add_fullscreen("man_press_backdrop.png")
img_neddle = img_add("engine_neddle.png",98,0,60,256)
img_add("engine_center.png",98,98,60,60)

function PT_mp_pressure(inhg)

    inhg = var_cap(inhg[2], 10, 40)
    rotate(img_neddle, 260 / 30 * (inhg - 10) -40)    
    
end

function PT_mp_pressure_FSX(inhg)

    PT_mp_pressure({0, inhg})
    
end

xpl_dataref_subscribe("sim/cockpit2/engine/indicators/MPR_in_hg", "FLOAT[8]", PT_mp_pressure)
fsx_variable_subscribe("RECIP ENG MANIFOLD PRESSURE:2", "inHg", PT_mp_pressure_FSX)
msfs_variable_subscribe("RECIP ENG MANIFOLD PRESSURE:2", "inHg", PT_mp_pressure_FSX)