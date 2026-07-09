img_add_fullscreen("oat_backdrop.png")
img_ice = img_add("oat_ice_warn.png",105,26,50,50)
visible(img_ice, false)

mytext1 = txt_add("", "size:56px; color: grey;  halign: center;", 65, 90, 120, 60)
mytext2 = txt_add("", "size:56px; color: black; halign: center;", 62, 88, 120, 60)

function PT_oat(temp)

    t = var_round(temp, 0)
    txt_set(mytext1,  string.format("%.0f",t) )  
    txt_set(mytext2,  string.format("%.0f",t) )  
    
    visible(img_ice, t >= -12 and t <= 10)

end

xpl_dataref_subscribe("sim/weather/temperature_ambient_c", "FLOAT", PT_oat)
fsx_variable_subscribe("AMBIENT TEMPERATURE", "Celsius", PT_oat)
msfs_variable_subscribe("AMBIENT TEMPERATURE", "Celsius", PT_oat)