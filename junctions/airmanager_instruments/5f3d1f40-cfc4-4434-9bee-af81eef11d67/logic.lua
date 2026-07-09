-- Global variables --
prp_max_fuel = user_prop_add_integer("Maximum", 10, 1000, 110, "Maximum fuel quantity")
prp_qua_fuel = user_prop_add_integer("Usable", 10, 1000, 95, "Usable fuel displayed on label")

-- Add images --
img_add_fullscreen("fuel_left_backdrop.png")
img_needle = img_add("neddle.png", 0, 90, 256, 256, "angle_z: -45; rotate_animation_type: LOG; rotate_animation_speed: 0.02")
img_add_fullscreen("fuel_cover.png")

txt_add(string.format("%0.0f GALLONS", user_prop_get(prp_qua_fuel) ), "font:roboto_bold.ttf; size:24; color: #FFFFFF; halign:center;", 0, 190, 256, 50)
txt_add("USABLE", "font:roboto_bold.ttf; size:24; color: #FFFFFF; halign:center;", 0, 210, 256, 50)

function new_fuel_xpl(weight, bus_volts)

    -- Convert weight in KG to gallons with 2.73KG / gallon
    local gallons = var_cap(weight[1] / 2.73, 0, user_prop_get(prp_max_fuel) )

    if bus_volts[1] < 10 then
        gallons = 0
    end
    
    rotate(img_needle, (90 / user_prop_get(prp_max_fuel) * gallons) -45)

end

function new_fuel_fsx(gallons_left, gallons_right, bus_volts)

    local gallons = gallons_left

    if bus_volts < 10 then
        gallons = 0
    end
    
    rotate(img_needle, (90 / user_prop_get(prp_max_fuel) * gallons) -45)

end

-- Subscribe to data --
xpl_dataref_subscribe("sim/flightmodel/weight/m_fuel", "FLOAT[2]", 
                      "sim/cockpit2/electrical/bus_volts", "FLOAT[2]", new_fuel_xpl)
fsx_variable_subscribe("FUEL LEFT QUANTITY", "Gallons", 
                       "FUEL RIGHT QUANTITY", "Gallons", 
                       "ELECTRICAL MAIN BUS VOLTAGE", "Volts", new_fuel_fsx)
fs2020_variable_subscribe("FUEL LEFT QUANTITY", "Gallons", 
                          "FUEL RIGHT QUANTITY", "Gallons", 
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", new_fuel_fsx)
fs2024_variable_subscribe("FUEL LEFT QUANTITY", "Gallons", 
                          "FUEL RIGHT QUANTITY", "Gallons", 
                          "ELECTRICAL BUS VOLTAGE:1", "Volts", new_fuel_fsx)