img_add_fullscreen("airspeed_backdrop.png")
img_neddle = img_add_fullscreen("neddle.png")

function PT_airspeed(airspeed)
    -- rotate the needle only if airspeed is above 25kts
    airspeed = var_cap(airspeed, 25, 260)

    rotate(img_neddle, airspeed*320/220 - 38)
end

xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT", PT_airspeed)
fsx_variable_subscribe("AIRSPEED INDICATED", "knots", PT_airspeed)
msfs_variable_subscribe("AIRSPEED INDICATED", "knots", PT_airspeed)