img_add_fullscreen("fuel_flow_backdrop.png")
img_needle = img_add("engine_neddle.png",98,0,60,256)

img_add("engine_center.png",98,98,60,60)

function PT_fuel_flow(fuelflow)

    -- Kg / sec to Gallons per hour
    fuelflow = (fuelflow[2] * 3600) * 0.36
    fuelflow = var_cap(fuelflow, 3, 30)
    rotate(img_needle, 240 / 27 * (fuelflow - 3) )

end

function PT_fuel_flow_FSX(fuelflow)
    
    fuelflow = var_cap(fuelflow, 3, 30)
    rotate(img_needle, 240 / 27 * (fuelflow - 3) )

end

xpl_dataref_subscribe("sim/cockpit2/engine/indicators/fuel_flow_kg_sec", "FLOAT[8]", PT_fuel_flow)
fsx_variable_subscribe("ENG FUEL FLOW GPH:2", "Gallons per hour", PT_fuel_flow_FSX)
msfs_variable_subscribe("ENG FUEL FLOW GPH:2", "Gallons per hour", PT_fuel_flow_FSX)