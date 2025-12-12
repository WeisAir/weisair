-- Config
local show_bezel  = true
local show_screws = false

-- Add images
if show_bezel then
    img_add_fullscreen("bezel.png")
    img_add("myASI.png",25,25,nil,nil)
else 
    img_add_fullscreen("myASI.png")
end

ias_needle =  img_add_fullscreen("needle.png")

-- Callbacks
function callback_indicated_airspeed(ias)

    ias = var_cap(ias,0,305)
    
    if ias > 260 then
        degrees = 303 + (ias - 260) * ((330 - 303)/40) -- 260 is 303 degrees 300 is 330 degrees
    elseif ias > 60 then
        degrees = 27.5 + (ias - 60) * ((303-27.5)/200)
    else
        degrees = ias * (27.5/60)
    end
    
    rotate(ias_needle,degrees)
    
end

--Subscriptions
fsx_variable_subscribe("AIRSPEED INDICATED", "knots", callback_indicated_airspeed)
fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", callback_indicated_airspeed)
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT", callback_indicated_airspeed)