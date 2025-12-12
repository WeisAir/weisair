--        AS350 B3 Altimeter       --
-------------------------------------
-- Load and display map and images --
-------------------------------------
setdisk = img_add("setdisk.png", 57, 43, 430, 430)
img_add_fullscreen("altimeterback.png")
img_add_fullscreen("altimetercap.png")
needle_10000 = img_add_fullscreen("needle10000.png")
needle_1000 = img_add_fullscreen("needle1000.png")
needle_100 = img_add_fullscreen("needle100.png")

---------------
-- Functions --
---------------

function new_altitude(altitude, pressure)
    
    k = (altitude/10000)*36
    h = ( (altitude - math.floor(altitude/10000)*10000)/1000 )*36
    t = ( altitude - math.floor(altitude/10000)*10000 )*0.36
    
    rotate(needle_10000, k)
    rotate(needle_1000, h)    
    rotate(needle_100, t) 
    
    kk = k/3.6
    hh = h/36
    tt = t/0.36-hh*1000
    
    barset = var_cap(pressure, 29.1, 30.7)
    
    rotate(setdisk, (((barset - 29.1) * 160 / 1.6) * -1)+0.6)

end

-------------------
-- Bus subscribe --
-------------------

xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/altitude_ft_pilot", "FLOAT",
                      "sim/cockpit/misc/barometer_setting", "FLOAT", new_altitude)
fsx_variable_subscribe("INDICATED ALTITUDE", "Feet",
                       "KOHLSMAN SETTING HG", "inHg", new_altitude)
fs2020_variable_subscribe("INDICATED ALTITUDE", "Feet",
                          "KOHLSMAN SETTING HG", "inHg", new_altitude)                       