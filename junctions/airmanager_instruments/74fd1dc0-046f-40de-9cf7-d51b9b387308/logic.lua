-- ATR 72-500 variometer by flyatr
-- remove the bezel by clicking in the top left corner of the instrument

-- config storage 
vsi_config = persist_add("show_bezel","INT",1)

-- global variables
cfg_show_bezel = persist_get(vsi_config)        -- load the bezel setting

img_no_bezel = img_add_fullscreen("black.png")
img_bezel = img_add_fullscreen("atr_vsi_background.png")
if cfg_show_bezel == 0 then
    visible(img_bezel,false)
else
    visible(img_no_bezel,false)
end
img_display = img_add("atr_vsi_display.png",28,35,275,260)
img_neddle = img_add("atr_vsi_needle.png",0,155,330,20)

function new_data_fsx(verticalspeed, Battery)
   if Battery then
    visible(img_neddle, true)
    visible(img_display, true)
    verticalspeed = var_cap(verticalspeed, -6000, 6000)
    if verticalspeed <= 2000 and verticalspeed >= -2000 then
        rotate(img_neddle, verticalspeed * 60 / 1000)
    else
    d=(verticalspeed * 12 / 1000) + fif(verticalspeed > 0,96,-96)
        rotate(img_neddle, d)
    end
   else
   
    visible(img_neddle, false)
    visible(img_display, false)
   end
end

function new_data_xpl(battery_on, vvi_fpm_pilot)

    battery_on = battery_on == 1
    
    new_data_fsx(vvi_fpm_pilot, battery_on)
    
end

function bezel_config()                -- remove the bezel by clicking in the top left corner of the instrument
    if cfg_show_bezel == 1 then
        cfg_show_bezel = 0
        visible(img_bezel,false)
        visible(img_no_bezel, true)
    else
        cfg_show_bezel = 1
        visible(img_bezel, true)
        visible(img_no_bezel, false)
    end
    persist_put(vsi_config, cfg_show_bezel)    -- save setting
end
switch_add(nil,nil,0,0,80,80,bezel_config)

-- Variable subscribe
fsx_variable_subscribe("VERTICAL SPEED", "Feet per minute", 
                           "ELECTRICAL MASTER BATTERY", "BOOLEAN", new_data_fsx)
fs2020_variable_subscribe("VERTICAL SPEED", "Feet per minute", 
                             "ELECTRICAL MASTER BATTERY", "BOOLEAN", new_data_fsx)
xpl_dataref_subscribe("sim/cockpit/electrical/battery_on", "INT", 
                      "sim/cockpit2/gauges/indicators/vvi_fpm_pilot", "FLOAT", new_data_xpl)