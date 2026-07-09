-- Add images
img_add_fullscreen("bus_backdrop.png")
img_hor1 = img_add("horizontal.png",45,118,60,60)
img_hor2 = img_add("horizontal.png",150,118,60,60)
img_vertical = img_add("vertical.png",38,179,60,60)

function PT_bus_xpl(busload, busvolts, baton, genon)

    if genon[1] == 1 then
        move(img_hor1, nil, 118 - busload[1] * 1.2, nil, nil, "LOG", 0.05)
    else
        move(img_hor1, nil, 118, nil, nil, "LOG", 0.05)
    end
    
    if genon[2] == 1 then
        move(img_hor2, nil, 118 - busload[2] * 1.2, nil, nil, "LOG", 0.05)
    else
        move(img_hor2, nil, 118, nil, nil, "LOG", 0.05)
    end
    
    if baton[1] == 1 then
        move(img_vertical, (120 / 30 * busvolts[1]) + 37, 179, nil, nil, "LOG", 0.05)
    else
        move(img_vertical, 37, 179, nil, nil, "LOG", 0.05)
    end

end

function PT_bus_fsx(busload1, busload2, busvolts, baton, genon1, genon2)

    if genon1 then
        move(img_hor1, nil, 118 - busload1 * 1.2, nil, nil, "LOG", 0.05)
    else
        move(img_hor1, nil, 118, nil, nil, "LOG", 0.05)
    end
    
    if genon2 then
        move(img_hor2, nil, 118 - busload2 * 1.2, nil, nil, "LOG", 0.05)
    else
        move(img_hor2, nil, 118, nil, nil, "LOG", 0.05)
    end
    
    if baton then
        move(img_vertical, (120 / 30 * busvolts) + 37, 179, nil, nil, "LOG", 0.05)
    else
        move(img_vertical, 37, 179, nil, nil, "LOG", 0.05)
    end

end

xpl_dataref_subscribe("sim/flightmodel/engine/ENGN_gen_amp", "FLOAT[8]",
                      "sim/cockpit2/electrical/battery_voltage_indicated_volts", "FLOAT[8]",
                      "sim/cockpit/electrical/battery_array_on", "INT[8]", 
                      "sim/cockpit2/electrical/generator_on", "INT[8]", PT_bus_xpl)
fsx_variable_subscribe("ELECTRICAL GENALT BUS AMPS:1", "Amperes",
                       "ELECTRICAL GENALT BUS AMPS:2", "Amperes", 
                       "ELECTRICAL MAIN BUS VOLTAGE", "Volts", 
                       "ELECTRICAL MASTER BATTERY", "BOOL", 
                       "GENERAL ENG MASTER ALTERNATOR:1", "BOOL", 
                       "GENERAL ENG MASTER ALTERNATOR:2", "BOOL", PT_bus_fsx)
fs2020_variable_subscribe("ELECTRICAL GENALT BUS AMPS:1", "Amperes",
                          "ELECTRICAL GENALT BUS AMPS:2", "Amperes", 
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", 
                          "ELECTRICAL MASTER BATTERY", "BOOL", 
                          "GENERAL ENG MASTER ALTERNATOR:1", "BOOL", 
                          "GENERAL ENG MASTER ALTERNATOR:2", "BOOL", PT_bus_fsx)
fs2024_variable_subscribe("ELECTRICAL BUS AMPS:1", "Amperes",
                          "ELECTRICAL BUS AMPS:2", "Amperes", 
                          "ELECTRICAL BUS VOLTAGE:1", "Volts", 
                          "ELECTRICAL MASTER BATTERY", "BOOL", 
                          "GENERAL ENG MASTER ALTERNATOR:1", "BOOL", 
                          "GENERAL ENG MASTER ALTERNATOR:2", "BOOL", PT_bus_fsx)
                    