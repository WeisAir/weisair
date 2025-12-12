prop_prop_num = user_prop_add_integer("prop number", 1, 2, 1, "Choose the prop number")

-- Load images in Z-order
img_add_fullscreen("bg_prop_oil.png")
img_press = img_add_fullscreen("needle.png")
img_temp = img_add_fullscreen("needle.png")
img_add_fullscreen("midbar.png")
rotate(img_temp, 20)
rotate(img_press, -229)

-- Functions
function new_oiltemp(oiltemp_1, oiltemp_2)

    if user_prop_get(prop_prop_num) == 1 then temp = var_cap(oiltemp_1, -50, 150) end
    if user_prop_get(prop_prop_num) == 2 then temp = var_cap(oiltemp_2, -50, 150) end
    
    rotate(img_temp, 20 - (63 / 150 * temp) )

end

function new_oilpress(oilpress_1, oilpress_2)

    if user_prop_get(prop_prop_num) == 1 then press = var_cap(oilpress_1, 0, 200) end
    if user_prop_get(prop_prop_num) == 2 then press = var_cap(oilpress_2, 0, 200) end
    
    rotate(img_press, -229 + (98 / 200 * press) )

end

xpl_dataref_subscribe(
"LES/saab/PGB/oil_temp_L", "FLOAT",
"LES/saab/PGB/oil_temp_R", "FLOAT",
new_oiltemp)

xpl_dataref_subscribe(
"LES/saab/PGB/oil_press_L", "FLOAT",
"LES/saab/PGB/oil_press_R", "FLOAT",
new_oilpress)



                    
                       