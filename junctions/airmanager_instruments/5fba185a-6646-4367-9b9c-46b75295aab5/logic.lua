img_gear_off = img_add("gear_backdrop.png",0,0,256,160)

img_gear_left = img_add("gear_lite.png",0,0,256,160, "visible:false")
viewport_rect(img_gear_left, 42,93,62,54)

img_gear_nose = img_add("gear_lite.png",0,0,256,160, "visible:false")
viewport_rect(img_gear_nose, 74,40,62,54)

img_gear_right = img_add("gear_lite.png",0,0,256,160, "visible:false")
viewport_rect(img_gear_right, 106,93,62,54)

img_gear_transit = img_add("gear_lite.png",0,0,256,160, "visible:false")
viewport_rect(img_gear_transit, 174,34,62,54)

function PT_liteup(geardata, bus_volts)

    local power = bus_volts[1] >= 8
    
    visible(img_gear_nose, geardata[1] > 0.99 and power)
    visible(img_gear_left, geardata[2] > 0.99 and power)
    visible(img_gear_right, geardata[3] > 0.99 and power)

    local total_gear = geardata[1] + geardata[2] + geardata[3]
    visible(img_gear_transit, (total_gear > 0 and total_gear < 3) and power) 

end

function PT_liteup_FSX(center, left, right, bus_volts)

    center = center / 100
    left = left / 100
    right = right / 100
    
    PT_liteup({center, left, right}, {bus_volts})

end

xpl_dataref_subscribe("sim/aircraft/parts/acf_gear_deploy", "FLOAT[10]", 
                      "sim/cockpit2/electrical/bus_volts", "FLOAT[6]", PT_liteup)
fsx_variable_subscribe("GEAR CENTER POSITION", "Percent", 
                       "GEAR LEFT POSITION", "Percent", 
                       "GEAR RIGHT POSITION", "Percent", 
                       "ELECTRICAL MAIN BUS VOLTAGE", "Volts", PT_liteup_FSX)
fs2020_variable_subscribe("GEAR CENTER POSITION", "Percent", 
                          "GEAR LEFT POSITION", "Percent", 
                          "GEAR RIGHT POSITION", "Percent", 
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", PT_liteup_FSX)
fs2024_variable_subscribe("GEAR CENTER POSITION", "Percent", 
                          "GEAR LEFT POSITION", "Percent", 
                          "GEAR RIGHT POSITION", "Percent", 
                          "ELECTRICAL BUS VOLTAGE:1", "Volts", PT_liteup_FSX)   