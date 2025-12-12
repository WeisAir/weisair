prop_engine_num = user_prop_add_integer("Engine number", 1, 2, 1, "Choose the engine number")

-- Load images in Z-order
img_add_fullscreen("oilback.png")
img_press = img_add_fullscreen("needle.png")
img_temp = img_add_fullscreen("needle.png")
img_add_fullscreen("needlecap.png")
rotate(img_temp, 20)
rotate(img_press, -229)

-- Functions
function new_oiltemp(oiltemp)

    temp = var_cap(oiltemp[user_prop_get(prop_engine_num)], -50, 150)
    rotate(img_temp, 20 - (63 / 150 * temp) )

end

function new_oilpress(oilpress)

    press = var_cap(oilpress[user_prop_get(prop_engine_num)], 0, 200)
    rotate(img_press, -229 + (98 / 200 * press) )

end

function new_oiltemp_FSX(oiltemp1, oiltemp2)

    new_oiltemp({oiltemp1, oiltemp2})
    
end

function new_oilpress_FSX(oilpress1, oilpress2)

    new_oilpress({oilpress1, oilpress2})
    
end

-- Data bus subscribe
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/oil_temperature_deg_C", "FLOAT[8]", new_oiltemp)
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/oil_pressure_psi", "FLOAT[8]", new_oilpress)
fsx_variable_subscribe("GENERAL ENG OIL TEMPERATURE:1", "Celsius", 
                       "GENERAL ENG OIL TEMPERATURE:2", "Celsius", new_oiltemp_FSX)
fsx_variable_subscribe("ENG OIL PRESSURE:1", "PSI", 
                       "ENG OIL PRESSURE:2", "PSI", new_oilpress_FSX)
fs2020_variable_subscribe("GENERAL ENG OIL TEMPERATURE:1", "Celsius", 
                          "GENERAL ENG OIL TEMPERATURE:2", "Celsius", new_oiltemp_FSX)
fs2020_variable_subscribe("ENG OIL PRESSURE:1", "PSI", 
                          "ENG OIL PRESSURE:2", "PSI", new_oilpress_FSX)                       
                       