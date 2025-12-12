img_add_fullscreen("background.png")
img_off_flag = img_add_fullscreen("off_flag.png")
img_add_fullscreen("vsi_backdrop.png")
img_neddle = img_add_fullscreen("vsi_needle.png")

--6000 = 171
--4000 = 147
--2000 = 99.5
--1000 = 56.5
--500 = 34.5

function new_data_xpl(battery_on, vvi_fpm_pilot)
   
    verticalspeed = var_cap(vvi_fpm_pilot, -6000, 6000)
    
    if verticalspeed > 4000 then
        rotate(img_neddle, 24/2000 * (verticalspeed-4000)+147)
    elseif verticalspeed > 2000 then
        rotate(img_neddle, 47.5/2000 * (verticalspeed-2000)+99.5)
    elseif verticalspeed > 1000 then
        rotate(img_neddle, 43/1000 * (verticalspeed-1000)+56.5)
    elseif verticalspeed > 500 then
        rotate(img_neddle, 22/500 * (verticalspeed-500)+34.5)
    elseif verticalspeed >= 0 then
        rotate(img_neddle, 34.5/500 * (verticalspeed))
    elseif verticalspeed < -4000 then
        rotate(img_neddle, 24/2000 * (verticalspeed+4000)-147)
    elseif verticalspeed < -2000 then
        rotate(img_neddle, 47.5/2000 * (verticalspeed+2000)-99.5)
    elseif verticalspeed < -1000 then
        rotate(img_neddle, 43/1000 * (verticalspeed+1000)-56.5)
    elseif verticalspeed < -500 then
        rotate(img_neddle, 22/500 * (verticalspeed+500)-34.5)
    elseif verticalspeed < 0 then
        rotate(img_neddle, 34.5/500 * (verticalspeed))
    end
        
    if battery_on > 0 then
        move(img_off_flag, -90,nil,nil,nil)
    else
        move(img_off_flag, -1,nil,nil,nil)
    end

end

function new_data_fsx(battery_on, vvi_fpm_pilot)

    battery_on = fif(battery_on, 1, 0)
    
    new_data_xpl(battery_on, vvi_fpm_pilot)
    
end

-- Variable subscribe
xpl_dataref_subscribe("sim/cockpit/electrical/battery_on", "INT", 
                      "sim/cockpit2/gauges/indicators/vvi_fpm_pilot", "FLOAT", new_data_xpl)
fsx_variable_subscribe("ELECTRICAL MASTER BATTERY", "Bool",
                       "VERTICAL SPEED", "Feet per minute", new_data_fsx)
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY", "Bool",
                          "VERTICAL SPEED", "Feet per minute", new_data_fsx)                       