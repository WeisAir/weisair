-- ATR 72-500 altimeter by flyatr
-- remove the bezel by clicking in the top left corner of the instrument

-- config storage 
altimeter_config = persist_add("show_bezel","INT",1)

-- global variables
cfg_show_bezel = persist_get(altimeter_config)        -- load the bezel setting

-- Fonts
font_alt = "size:40px; font:arimo_bold.ttf; color: white; halign:center;"
font_baro = "size:16px; font:arimo_bold.ttf; color: white; halign:center;"

-- Images
img_no_bezel = img_add_fullscreen("black.png")
img_bezel = img_add_fullscreen("atr_alt_background.png")
if cfg_show_bezel == 0 then
    visible(img_bezel,false)
else
    visible(img_no_bezel,false)
end
img_add("markings.png",30,30,270,270)


-- Barometric pressure set knob
---------------------------------------------
function dial_it(direction)  
    if direction == 1 then
        fsx_event("KOHLSMAN_INC")
        fs2020_event("KOHLSMAN_INC")
        xpl_command("sim/instruments/barometer_up")
    elseif direction == -1 then
        fsx_event("KOHLSMAN_DEC")
        fs2020_event("KOHLSMAN_DEC")
        xpl_command("sim/instruments/barometer_down")
    end
end
baro_dial = dial_add("knob_mark.png",20,271,38,38,dial_it)
dial_click_rotate(baro_dial, 20)

-- Altimeter drum display
---------------------------------------------
function alt_10000_value_callback(i)
  return tostring(-i % 10)
end
alt_10000_running_txt_id = running_txt_add_ver(91,60,3,22,43,alt_10000_value_callback,font_alt)
viewport_rect(alt_10000_running_txt_id, 85,96, 30, 51)
 
function alt_1000_value_callback(i)
  return tostring(-i % 10)
end 
alt_1000_running_txt_id = running_txt_add_ver(122,60,3,22,43,alt_1000_value_callback,font_alt)
viewport_rect(alt_1000_running_txt_id, 116,96, 30, 51)

function alt_100_value_callback(i)
  return tostring(-i % 10)
end
alt_100_running_txt_id = running_txt_add_ver(174,60,3,22,43,alt_100_value_callback,font_alt)
viewport_rect(alt_100_running_txt_id, 168, 96, 30, 51)

function alt_10_value_callback(i)
    value = (4- (i%5)) * 20 + 20    -- interval of 20 feet
    if value == 100 then
        value = 0
    end
    return string.format("%02d", value) 
end
alt_10_running_txt_id = running_txt_add_ver(197,60,3,52,43,alt_10_value_callback,font_alt)
viewport_rect(alt_10_running_txt_id, 192,96, 60,51)

--flags
---------------------------------------------
drum_flags = running_img_add_ver("atr_alt_flags.png",85,43,2,62,159)  -- ground and negative flag on drum
viewport_rect(drum_flags,85,96,62,50)
img_off = img_add("atr_alt_off_flag.png",85,94,129,55)

-- pressure setting inch hg
-- baro drum display 
---------------------------------------------
function baro_1_value_callback(i)
  return "" .. i % 10
end
drum_baro_1 = running_txt_add_ver(221,196,3,20,20,baro_1_value_callback,font_baro)
viewport_rect(drum_baro_1, 180,214, 60, 17)

function baro_2_value_callback(i)
  return "" ..  i % 10
end
drum_baro_2 = running_txt_add_ver(208,196,3,20,20,baro_2_value_callback,font_baro)
viewport_rect(drum_baro_2,  180,214, 60, 17)

function baro_3_value_callback(i)
  return "" .. i % 10
end
drum_baro_3 = running_txt_add_ver(196,196,3,20,20,baro_3_value_callback,font_baro)
viewport_rect(drum_baro_3,  180,214,60, 17)

function baro_4_value_callback(i)
  return "" ..  i % 10
end
drum_baro_4 = running_txt_add_ver(184,196,3,20,20,baro_4_value_callback,font_baro)
viewport_rect(drum_baro_4, 180,214, 60, 17)

-- pressure setting mbar
-- mb drum display 
---------------------------------------------
function mb_1_value_callback(i)
  return "" .. i % 10
end
drum_mb_1 = running_txt_add_ver(126,196,3,20,20,mb_1_value_callback,font_baro)
viewport_rect(drum_mb_1, 86,214, 60, 17)

function mb_2_value_callback(i)
  return "" .. i % 10
end
drum_mb_2 = running_txt_add_ver(114,196,3,20,20,mb_2_value_callback,font_baro)
viewport_rect(drum_mb_2,  86,214, 60, 17)

function mb_3_value_callback(i)
  return "" .. i % 10
end
drum_mb_3 = running_txt_add_ver(102,196,3,20,20,mb_3_value_callback,font_baro)
viewport_rect(drum_mb_3,  86,214,60, 17)

function mb_4_value_callback(i)
  return "" .. i % 10
end
drum_mb_4 = running_txt_add_ver(90,196,3,20,20,mb_4_value_callback,font_baro)
viewport_rect(drum_mb_4, 86,214, 60, 17)

---------------------------------------------

img_needle = img_add("atr_alt_needle.png",155,0,20,330)
img_add("atr_alt_alert_dim.png",276,27,26,27)
img_alt_alert = img_add("atr_alt_alert.png",276,27,26,27)
---------------------------------------------

function new_fsx_data(fsx_altitude, fsx_baro, fsx_baro_metric, fsx_battery, fsx_ap_altitude)
    if fsx_battery then
        altitude = fsx_altitude
        visible(img_off,false)
        rotate(img_needle, (altitude - math.floor(altitude/10000)*10000)*0.36)
    else
        visible(img_off,true)
        rotate(img_needle,0)
        altitude = 0
    end
    
    -- determine altimeter drum values
    ----------------------------------
    drum_10_moving = (altitude / 20) + 20
    drum_100_stationary = math.floor(altitude / 100) 
    drum_100_moving = drum_100_stationary + drum_10_moving % 1
    drum_1000_stationary = math.floor(altitude / 1000)
    drum_1000_moving = drum_1000_stationary + drum_100_moving + 1
    drum_10000_stationary = math.floor(altitude / 10000)
    drum_10000_moving = drum_10000_stationary + drum_1000_moving + 1 
  
    -- move the drums
    ------------------------------
    running_txt_move_carot(alt_10_running_txt_id, drum_10_moving * -1)
    
    if (altitude % 100) > 80 then
        running_txt_move_carot(alt_100_running_txt_id, drum_100_moving * -1)
    else 
        running_txt_move_carot(alt_100_running_txt_id, drum_100_stationary * -1)
    end
    
    if (altitude % 1000) > 980 then
        running_txt_move_carot(alt_1000_running_txt_id, drum_1000_moving * -1)
    else 
        running_txt_move_carot(alt_1000_running_txt_id, drum_1000_stationary * -1)
    end
    
    value=0
    if (altitude % 10000) > 9980 then
        value=drum_10000_moving * -1 
    else 
        value= drum_10000_stationary * -1
    end
    running_txt_move_carot(alt_10000_running_txt_id,value)
    
    value = fif(value < -110, value + 110, value)            -- correction necessary vor "negative" flag
    running_img_move_carot(drum_flags, value * 0.33 )        -- turn the flag drum
    visible(drum_flags,altitude < 11000 )    
    
    --baro drums
    ------------------------------
    baro_integer = fsx_baro * 100
    baro1_moving = baro_integer % 10
    baro2_stationary = math.floor(baro_integer / 10)
    baro2_moving = baro2_stationary + baro1_moving + 1
    baro3_stationary = math.floor(baro_integer / 100)
    baro3_moving =  baro3_stationary + baro2_moving + 1
    baro4_stationary = math.floor(baro_integer / 1000)
    baro4_moving =  baro4_stationary + baro1_moving + 1
  
    running_txt_move_carot(drum_baro_1, baro1_moving)

    if (baro_integer % 10) > 9 then
        running_txt_move_carot(drum_baro_2, baro2_moving)
    else
        running_txt_move_carot(drum_baro_2, baro2_stationary)
    end
    
    if (baro_integer % 100) > 99 then
        running_txt_move_carot(drum_baro_3, baro3_moving)
    else
        running_txt_move_carot(drum_baro_3, baro3_stationary)
    end
    
    if (baro_integer % 1000)  > 999 then
        running_txt_move_carot(drum_baro_4, baro4_moving)
    else
        running_txt_move_carot(drum_baro_4, baro4_stationary)
    end
    
    -- metric drums
    -----------------------------------
    metric1_moving = fsx_baro_metric % 10
    metric2_stationary = math.floor(fsx_baro_metric / 10)
    metric2_moving = metric2_stationary + metric1_moving + 1  
    metric3_stationary = math.floor(fsx_baro_metric / 100)
    metric3_moving = metric3_stationary + metric2_moving + 1 
    metric4_stationary = math.floor(fsx_baro_metric / 1000)
    metric4_moving = metric4_stationary + metric3_moving + 1
  
    running_txt_move_carot(drum_mb_1, metric1_moving)
    if (fsx_baro_metric % 10) > 9 then
        running_txt_move_carot(drum_mb_2, metric2_moving)
    else
        running_txt_move_carot(drum_mb_2, metric2_stationary)
    end
    
    if (fsx_baro_metric % 100) > 99 then
        running_txt_move_carot(drum_mb_3, metric3_moving)
    else
        running_txt_move_carot(drum_mb_3, metric3_stationary)
    end
    
    if (fsx_baro_metric % 1000)  > 999 then
        running_txt_move_carot(drum_mb_4, metric4_moving)
    else
        running_txt_move_carot(drum_mb_4, metric4_stationary)
    end
  
    -- altitude alert indication
    --------------------------------
    alert_altitude = math.abs(fsx_ap_altitude - altitude)
    if (alert_altitude <= 1000) and (alert_altitude >= 250) then
        visible(img_alt_alert, true)
    else
        visible(img_alt_alert, false)
    end

 end

 
function bezel_config()                -- remove the bezel by clicking in the top left corner of the instrument
    if cfg_show_bezel == 1 then
        cfg_show_bezel = 0
        visible(img_bezel,false)
        visible(img_no_bezel, true)
        visible(baro_dial, false)
    else
        cfg_show_bezel = 1
        visible(img_bezel, true)
        visible(img_no_bezel, false)
        visible(baro_dial, true)
    end
    persist_put(altimeter_config, cfg_show_bezel)    -- save setting
end
switch_add(nil,nil,0,0,80,80,bezel_config)

 
function new_xpl_data(altitude, baro, battery, ap_altitude)

    -- Convert boolean to integer
    battery = fif(battery == 1, true, false)
    
    -- Convert barometric setting in inHg to MB
    baro_metric = baro * 33.8637526

    new_fsx_data(altitude, baro, baro_metric, battery, ap_altitude)
    
end

fsx_variable_subscribe("INDICATED ALTITUDE", "Feet",
                       "KOHLSMAN SETTING HG", "inHg", 
                       "KOHLSMAN SETTING MB", "Millibars",
                       "ELECTRICAL MASTER BATTERY", "BOOLEAN", 
                       "AUTOPILOT ALTITUDE LOCK VAR", "Feet", new_fsx_data)
                       
fs2020_variable_subscribe("INDICATED ALTITUDE", "Feet",
                          "KOHLSMAN SETTING HG", "inHg", 
                          "KOHLSMAN SETTING MB", "Millibars",
                          "ELECTRICAL MASTER BATTERY", "BOOLEAN", 
                          "AUTOPILOT ALTITUDE LOCK VAR", "Feet", new_fsx_data)
                       
xpl_dataref_subscribe("sim/flightmodel/misc/h_ind", "FLOAT",
                      "sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", "FLOAT",
                      "sim/cockpit/electrical/battery_on", "INT", 
                      "sim/cockpit/autopilot/altitude", "FLOAT", new_xpl_data)