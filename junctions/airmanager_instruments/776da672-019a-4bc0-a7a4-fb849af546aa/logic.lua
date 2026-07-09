img_add_fullscreen("altimeter_backdrop.png")
txt_inhg = txt_add("", "size:32px; color: sienna; halign: right;", 253, 322, 120, 40)
txt_hpa = txt_add("", "size:32px; color: sienna; halign: right;", 96, 322, 120, 40)
txt_altk = txt_add("", "size:48px; color: white; halign: right;", 118, 153, 200, 55)

img_small_k_neddle = img_add_fullscreen("altimeter_thin_neddle.png")
img_small_neddle = img_add_fullscreen("altimeter_small_neddle.png")
img_big_neddle = img_add_fullscreen("altimeter_big_neddle.png")
img_add_fullscreen("altimeter_center.png")

function dial_callback(baroset)
    if baroset == 1 then
        xpl_command("sim/instruments/barometer_up")
        fsx_event("KOHLSMAN_INC")
        msfs_event("KOHLSMAN_INC")
    elseif baroset == -1 then
        xpl_command("sim/instruments/barometer_down")
        fsx_event("KOHLSMAN_DEC")
        msfs_event("KOHLSMAN_DEC")
    end
end

function PT_altimeter(altitude, pressure)

    k = (altitude/10000)*36
    h = ( (altitude - math.floor(altitude/10000)*10000)/1000 )*36
    t = ( altitude - math.floor(altitude/10000)*10000 )*0.36
    
    rotate(img_small_k_neddle, k)
    rotate(img_small_neddle, h)    
    rotate(img_big_neddle, t) 

    altitude = altitude - altitude % 10
    txt_set(txt_altk, string.format("%05.0f", altitude) )
    txt_set(txt_inhg, string.format("%05.02f", pressure) )
    txt_set(txt_hpa, string.format("%04.0f", pressure * 33.8639) )

end

xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/altitude_ft_pilot", "FLOAT",
                      "sim/cockpit/misc/barometer_setting", "FLOAT", PT_altimeter)
fsx_variable_subscribe("INDICATED ALTITUDE", "Feet",
                       "KOHLSMAN SETTING HG", "inHg", PT_altimeter)
msfs_variable_subscribe("INDICATED ALTITUDE", "Feet",
                          "KOHLSMAN SETTING HG", "inHg", PT_altimeter)
baro_dial = dial_add("dial_alt.png",10,398,104,104,dial_callback)