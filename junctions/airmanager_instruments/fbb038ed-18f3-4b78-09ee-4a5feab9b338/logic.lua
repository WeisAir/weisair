fuel_tank_sel = user_prop_add_enum("Fuel Tank", "L,R", "L","Choose the fuel tank")

img_background = img_add_fullscreen("bg_fuel_flow.png")
img_needle = img_add_fullscreen("fuel_needle.png")
img_midpoint = img_add_fullscreen("midpoint.png")

--variables

rotation_factor = 2125
needle_offset = -115
min_fuel_flow = 0.0
max_fuel_flow = 0.11

fuel_tank_sel = user_prop_get(fuel_tank_sel)

function cb_fuel_flow(fuel_flow_left,fuel_flow_right)
   
   fuel_flow_left = var_cap(fuel_flow_left, min_fuel_flow, max_fuel_flow)
   fuel_flow_right = var_cap(fuel_flow_right, min_fuel_flow, max_fuel_flow)

   if fuel_tank_sel == "L" then rotate(img_needle,fuel_flow_left*rotation_factor+needle_offset) end
   if fuel_tank_sel == "R" then rotate(img_needle,fuel_flow_right*rotation_factor+needle_offset) end 
    
end

xpl_dataref_subscribe(
"LES/saab/fuel_flow_L", "FLOAT",
"LES/saab/fuel_flow_R","FLOAT",
cb_fuel_flow)


