-- Add full screen images for background, stby off flag and sound
background_image_id = img_add_fullscreen("background.png")
stby_off_flag_image_id = img_add("stby_off_flag.png", 148, 149, 66, 26)
click_sound = sound_add("switch.wav")

-- Standby flag and knob images, dial (transparent), and function show correct images for the state
function stby_click_callback(direction)

    if direction == 1 then
        visible(stby_off_flag_image_id,false)
        visible(standby_on_image_id,true)
        visible(standby_off_image_id,false)
        sound_play(click_sound)
    elseif direction == -1 then
        visible(stby_off_flag_image_id,true)
        visible(standby_on_image_id,false)
        visible(standby_off_image_id,true)
        sound_play(click_sound)
    end    
end

-- Show correct knob for startup
standby_on_image_id = img_add("knob_off.png",400,400,100,100)
standby_off_image_id = img_add("knob_stby.png",400,400,100,100)
-- Hide one image 
visible(standby_off_image_id,false)
-- Empty_click is a transparent graphic over the other images
stby_dial_id = dial_add("empty_click.png",410,410,90,68,stby_click_callback)

function item_value_callback_inner_right_major(i)
    return string.format("%d", (0 - i) )
end

-- Baro set knob image and command function and inputs

function dial_it(direction)
    if direction == 1 then
        xpl_command ("sim/instruments/barometer_up")
        fsx_event("KOHLSMAN_INC")
        fs2020_event("KOHLSMAN_INC")
    elseif direction == -1 then
        xpl_command ("sim/instruments/barometer_down")
        fsx_event("KOHLSMAN_DEC")
        fs2020_event("KOHLSMAN_DEC")
    end
end

baro_dial = dial_add("baro_knob.png",27,399,72,72,dial_it)

-- Set up running text field altitude drum hundreds place

function alt_100_value_callback(i)
  return "" .. (0 - i) % 10
end

alt_100_running_txt_id = running_txt_add_ver(166,134,5,38,48,alt_100_value_callback,"size:40px; font:arimo_bold.ttf; color:black; halign:right;")
viewport_rect(alt_100_running_txt_id, 180, 195, 33, 101)

-- Set up running text field altitude drum thousands place
 
function alt_1000_value_callback(i)
  return "" .. (0 - i) % 10
end

alt_1000_running_txt_id = running_txt_add_ver(127,169,3,38,56,alt_1000_value_callback,"size:50px; font:arimo_bold.ttf; color:#fbfcfa; halign:right;")
viewport_rect(alt_1000_running_txt_id, 130,223, 41, 53)
-- Set up running text field altitude drum ten-thousands place
 
function alt_10000_value_callback(i)
  return "" .. (0 - i) % 10
end

alt_10000_running_txt_id = running_txt_add_ver(81,169,3,38,56,alt_10000_value_callback,"size:50px; font:arimo_bold.ttf; color:#fbfcfa; halign:right;")
viewport_rect(alt_10000_running_txt_id, 85,223, 41, 53)

-- Set up running text field baro drum hundreths (.01) place
 
function baro_pt01_value_callback(i)
    return "" .. i % 10
end

baro_pt01_running_txt_id = running_txt_add_ver(343,279,3,20,32,baro_pt01_value_callback,"size:30px; font:arimo_bold.ttf; color:#fbfcfa; halign:right;")
viewport_rect(baro_pt01_running_txt_id, 270,310, 102, 32)

-- Set up running text field baro drum tents (.1) place
 
function baro_pt10_value_callback(i)
    return "" .. i % 10
end

baro_pt10_running_txt_id = running_txt_add_ver(318,279,3,20,32,baro_pt10_value_callback,"size:30px; font:arimo_bold.ttf; color:white; halign:right;")
viewport_rect(baro_pt10_running_txt_id, 269,310, 102, 32)

-- Set up running text field baro drum ones place
 
function baro_1_value_callback(i)
    return "" .. i % 10
end

baro_1_running_txt_id = running_txt_add_ver(296,279,3,20,32,baro_1_value_callback,"size:30px; font:arimo_bold.ttf; color:white; halign:right;")
viewport_rect(baro_1_running_txt_id, 270,310, 102, 32)

-- Set up running text field baro drum tens place
 
function baro_10_value_callback(i)
    return "" .. i % 10
end

baro_10_running_txt_id = running_txt_add_ver(276,279,3,20,32,baro_10_value_callback,"size:30px; font:arimo_bold.ttf; color:white; halign:right;")
viewport_rect(baro_10_running_txt_id, 270,310, 102, 32)

img_add("inhgshadow.png", 278, 308, 94, 34)

ten_thou_flag= img_add("alt_flag_single.png", 90, 221, 32, 56)
one_thou_flag= img_add("alt_flag_single.png", 136, 221, 32, 56)

img_add("alt_shadow.png", 90, 221, 32, 56)
img_add("alt_shadow.png", 136, 221, 32, 56)
img_add("h_shadow.png", 181, 195, 24, 101)

-- Needle
airspeed_needle_image_id = img_add("as_needle.png", 200, 0, 100, 500)

--Dataref callback for PT_altimeter

function PT_altimeter(altitude, baro)
    
    -- Set needle position
    t = (altitude - math.floor(altitude / 10000) * 10000) * 0.36
    rotate(airspeed_needle_image_id, t)

    -- Altimeter drums
    running_txt_move_carot(alt_100_running_txt_id, ((altitude / 100) % 10) * -1)
    
    if (altitude % 1000) > 900 then
        running_txt_move_carot(alt_1000_running_txt_id, (altitude/100 - 9 - (math.floor(altitude / 1000) * 9)) * -1)
    else 
        running_txt_move_carot(alt_1000_running_txt_id, math.floor( altitude / 1000 ) * -1)
    end
    
    if (altitude % 10000) > 9900 then
        running_txt_move_carot(alt_10000_running_txt_id, (altitude/1000 - 9.9 - (math.floor(altitude / 10000) * 9.9)) * -10)
    else 
        running_txt_move_carot(alt_10000_running_txt_id, math.floor(altitude / 10000) * -1)
    end
  
    if(altitude < 0) then 
        visible(one_thou_flag,true)
        visible(ten_thou_flag,false)
    elseif (altitude < 10000)  then
        visible(ten_thou_flag,true)
        visible(one_thou_flag,false)
    else
        visible(ten_thou_flag,false)
        visible(one_thou_flag,false)
    end
  
    -- Set global barometer setting
    calc_baro = baro * 10
    
    digit0 = math.floor(calc_baro * 10) % 10 
    digit1 = math.floor(calc_baro) % 10
    digit2 = math.floor(calc_baro / 10) % 10    
    digit3 = math.floor(calc_baro / 100) % 10
    
    whole = digit1 + (digit2 * 10) + (digit3 * 100)
    digit0 = (calc_baro - whole) * 10
    
    if digit0 > 9.0 then
        part = digit0 - math.floor(digit0)
        digit1 = digit1 + part
    end
    
    if digit1 > 9.0 and digit0 > 9.0 then
        digit2 = digit2 + part
    end
    
    if digit2 > 9.0 and digit0 > 9.0 then
        digit3 = digit3 + part
    end
    
    running_txt_move_carot(baro_pt01_running_txt_id, digit0)
    running_txt_move_carot(baro_pt10_running_txt_id, digit1)
    running_txt_move_carot(baro_1_running_txt_id, digit2)
    running_txt_move_carot(baro_10_running_txt_id, digit3) 
  
end    

--XP Data Subscriptions
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/altitude_ft_pilot", "FLOAT",
                      "sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", "FLOAT", PT_altimeter)
fsx_variable_subscribe("INDICATED ALTITUDE", "Feet",
                       "KOHLSMAN SETTING HG", "inHg", PT_altimeter)
fs2020_variable_subscribe("INDICATED ALTITUDE", "Feet",
                          "KOHLSMAN SETTING HG", "inHg", PT_altimeter)                       