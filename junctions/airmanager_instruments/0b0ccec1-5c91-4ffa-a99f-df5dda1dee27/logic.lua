img_add_fullscreen("flaps_backdrop.png")

img_flaps_transit = img_add_fullscreen("flaps_lite.png", "visible:false")
viewport_rect(img_flaps_transit, 52,12,40,40)

img_flaps_apr = img_add_fullscreen("flaps_lite.png", "visible:false")
viewport_rect(img_flaps_apr, 52,60,40,40)

img_flaps_down = img_add_fullscreen("flaps_lite.png", "visible:false")
viewport_rect(img_flaps_down, 52,108,40,40)

function PT_liteup_XPL(flapsdeployment, bus_volts)

    local power = bus_volts[1] >= 8

    flapsdeployment = var_round(flapsdeployment, 1)

    visible(img_flaps_transit, ((flapsdeployment > 0 and flapsdeployment < 0.4) or (flapsdeployment > 0.4 and flapsdeployment < 1)) and power)
    
    visible(img_flaps_apr, flapsdeployment == 0.4 and power)
    
    visible(img_flaps_down, flapsdeployment >= 1 and power)
    
end

function PT_liteup_FSX(flapsdeployment, bus_volts)

    local power = bus_volts >= 8

    flapsdeployment = var_round(flapsdeployment / 100, 1)

    visible(img_flaps_transit, ((flapsdeployment > 0 and flapsdeployment < 0.5) or (flapsdeployment > 0.5 and flapsdeployment < 1)) and power)
    
    visible(img_flaps_apr, flapsdeployment == 0.5 and power)
    
    visible(img_flaps_down, flapsdeployment >= 1 and power)

end

function PT_liteup_FS2020(flapsdeployment, bus_volts)

    local power = bus_volts >= 8

    visible(img_flaps_transit, ((flapsdeployment > 0 and flapsdeployment <= 33) or (flapsdeployment >= 34 and flapsdeployment <= 99)) and power)
    
    visible(img_flaps_apr, (flapsdeployment > 33 and flapsdeployment < 34) and power)
    
    visible(img_flaps_down, flapsdeployment >= 100 and power)

end

xpl_dataref_subscribe("sim/flightmodel2/controls/flap1_deploy_ratio", "FLOAT", 
                      "sim/cockpit2/electrical/bus_volts", "FLOAT[6]", PT_liteup_XPL)
fsx_variable_subscribe("TRAILING EDGE FLAPS LEFT PERCENT", "Percent", 
                       "ELECTRICAL MAIN BUS VOLTAGE", "Volts", PT_liteup_FSX)
fs2020_variable_subscribe("TRAILING EDGE FLAPS LEFT PERCENT", "Percent",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", PT_liteup_FS2020)
fs2024_variable_subscribe("TRAILING EDGE FLAPS LEFT PERCENT", "Percent",
                          "ELECTRICAL BUS VOLTAGE:1", "Volts", PT_liteup_FS2020)