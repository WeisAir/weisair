fuel_tank_sel = user_prop_add_enum("Fuel Tank", "L,R", "L","Choose the fuel tank")

img_background = img_add_fullscreen("bg_fuel.png")
img_needle = img_add_fullscreen("fuel_needle.png")
img_midpoint = img_add_fullscreen("midpoint.png")

--variables

rotation_factor = 0.215
needle_offset = -145
min_fuel = 0
max_fuel = 1265.815186

fuel_tank_sel = user_prop_get(fuel_tank_sel)

function cb_fuel_qty(fuel_qty_left,fuel_qty_right)
   
   fuel_qty_left = var_cap(fuel_qty_left, min_fuel, max_fuel)
   fuel_qty_right = var_cap(fuel_qty_right, min_fuel, max_fuel)

   if fuel_tank_sel == "L" then rotate(img_needle,fuel_qty_left*rotation_factor+needle_offset) end
   if fuel_tank_sel == "R" then rotate(img_needle,fuel_qty_right*rotation_factor+needle_offset) end 
    
end

xpl_dataref_subscribe(
"sim/cockpit2/fuel/fuel_level_indicated_left", "FLOAT",
"sim/cockpit2/fuel/fuel_level_indicated_right","FLOAT",
cb_fuel_qty)


