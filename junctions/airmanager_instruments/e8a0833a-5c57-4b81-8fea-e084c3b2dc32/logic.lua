img_add_fullscreen("vario_backdrop.png")
img_neddle = img_add_fullscreen("vario_neddle.png")

function PT_vario(verticalspeed)
    
    verticalspeed = var_cap(verticalspeed, -4000, 4000)
    rotate(img_neddle, 180 / 4000 * verticalspeed)
    
end

-- Bus subscribe
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/vvi_fpm_pilot", "FLOAT", PT_vario)
fsx_variable_subscribe("VERTICAL SPEED", "Feet per minute", PT_vario)
fs2020_variable_subscribe("VERTICAL SPEED", "Feet per minute", PT_vario)