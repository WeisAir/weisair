--//////////////////////////////////--
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
-- Standby attitude indicator B 737 --
--     Build by Sim Innovations     --
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
--//////////////////////////////////--

-- HPA or INHG --
prop_pres = user_prop_add_enum("Barometric pressure", "HPA,INHG", "HPA", "Show HPA or or INHG")

-- Add images --
img_horizon_back = img_add("horizonbackground.png", -115, -273, 800, 1200)
img_horizon_numb = img_add("horizonnumbers.png", 149, -673, 272, 2000)
viewport_rect(img_horizon_numb, 105, 154, 360, 350)
img_bank_indicat = img_add("bankindicator.png", 75, 122, 420, 420)
viewport_rect(img_bank_indicat, 105, 90, 360, 182)

img_add_fullscreen("viewport.png")
img_compass = img_add("compass.png", -215, 534, 1000, 1000)
img_add_fullscreen("altspeedtape.png")

-- Barometric pressure
txt_pressure = txt_add(" ", "size:52px; font:arimo_bold.ttf; color: #80ef4b; halign:right;", 205, 6, 250, 100)

-- BEGIN Running text and images for speed and altitude
function item_value_callback_speed(i)
    return string.format("%d", 0 - (i * 20) )
end

running_text_speed = running_txt_add_ver(-13,-209,10,100,102,item_value_callback_speed,"size:52px; font:arimo_bold.ttf; color:white; halign:right;")
running_img_speed  = running_img_add_ver("speedimage.png",78,-30,10,22,102)

running_img_move_carot(running_img_speed, 0)
running_txt_move_carot(running_text_speed, 0)

function item_value_callback_alt(i)
    return string.format("%d", i * 200 * -1 )
end

running_text_alt = running_txt_add_ver(467,-188,8,130,124,item_value_callback_alt,"size:46px; font:arimo_bold.ttf; color:white; halign:right;")
running_img_alt  = running_img_add_ver("altimage.png",470,-107,8,26,124)

running_img_move_carot(running_img_alt, 0)
running_txt_move_carot(running_text_alt, 0)
viewport_rect(running_text_alt, 470, 16, 130, 568)
viewport_rect(running_img_alt, 470, 16, 130, 568)
-- END Running text and images for speed and altitude

img_add_fullscreen("altspeedbox.png")

-- BEGIN Running text airspeed --
function item_value_callback_inner_speed_minor(i)
    
    if i > 0 then
        return""
    else
        return string.format("%d", (0 - i) % 10 )
    end
    
end

running_text_inner_speed_minor_id = running_txt_add_ver(68,163,5,80,67, item_value_callback_inner_speed_minor, "size:60px; font:arimo_bold.ttf; color:white;")
running_txt_move_carot(running_text_inner_speed_minor_id, 0)

viewport_rect(running_text_inner_speed_minor_id,0,287,103,80)

function item_value_callback_inner_speed_major(i)
    
    if i == 0 then
        return ""
    else
        return string.format("%02d", (0 - i) )
    end
    
end

running_text_inner_speed_major_id = running_txt_add_ver(-11,230,3,80,67, item_value_callback_inner_speed_major, "size:60px; font:arimo_bold.ttf; color:white; halign:right")
running_txt_move_carot(running_text_inner_speed_major_id, 0)

viewport_rect(running_text_inner_speed_major_id,0,287,103,80)
-- END Running text airspeed --

-- BEGIN Running text altitude --
function item_value_callback_inner_alt_minor(i)
    
    if i == 0 then
        return"00"
    elseif i > 0 then
        return""
    else
        return string.format("%02d", ((0-i)%10) * 10)
    end
    
end

running_text_inner_alt_minor_id = running_txt_add_ver(494,182,5,100,60, item_value_callback_inner_alt_minor, "size:52px; font:arimo_bold.ttf; color:white; halign:right")
running_txt_move_carot(running_text_inner_alt_minor_id, 0)
viewport_rect(running_text_inner_alt_minor_id,435,288,166,80)


function item_value_callback_inner_alt_major100(i)
    
    if i == 0 then
        return"0"
    else
        return string.format("%d", (0 - i)%10 )
    end
    
end

running_text_inner_alt_major100_id = running_txt_add_ver(490,242,3,50,60, item_value_callback_inner_alt_major100, "size:52px; font:arimo_bold.ttf; color:white; halign:right")
running_txt_move_carot(running_text_inner_alt_major100_id, 0)
viewport_rect(running_text_inner_alt_major100_id,435,288,166,80)

function item_value_callback_inner_alt_major1000(i)

    if i == 0 then
        return"0"
    else
        return"" .. - i
    end
    
end

running_text_inner_alt_major1000_id = running_txt_add_ver(404,217,3,103,80, item_value_callback_inner_alt_major1000, "size:60px; font:arimo_bold.ttf; color:white; halign:right")
running_txt_move_carot(running_text_inner_alt_major1000_id, 0)
viewport_rect(running_text_inner_alt_major1000_id,435,288,166,80)
-- END Running text altitude --

img_alt_mkr = img_add("green_marker.png", 442, 304, 30, 46)
viewport_rect(img_alt_mkr,435,288,166,80)
-- Functions --
function new_data(heading, roll, pitch, airspeed, altitude, pressure)

    -- Rotate the compass heading (electric gyro)
    rotate(img_compass, heading * -1)
    
    -- Rotate the roll indicator (electric gyro)
    rotate(img_bank_indicat, roll)

    -- Roll the horizon (electric gyro)
    rotate(img_horizon_back, roll * -1)
    rotate(img_horizon_numb, roll * -1)
    
    -- Move the horizon pitch, background and numbers seperately (electric gyro)
    pitch_back = var_cap(pitch, -29, 29)
    pitch_numb = var_cap(pitch, -90, 90)
    radial = math.rad(roll * -1)
    
    x_b = -(math.sin(radial) * pitch_back * 10)
    y_b = (math.cos(radial) * pitch_back * 10)
    x_n = -(math.sin(radial) * pitch_numb * 10)
    y_n = (math.cos(radial) * pitch_numb * 10)
    
    move(img_horizon_back, x_b - 115, y_b - 273, nil, nil)
    move(img_horizon_numb, x_n + 149, y_n - 673, nil, nil)
    
    -- Speed box running text and images
    -- Cap the airspeed at 999 knots maximum displayed
    airspeed = var_cap(airspeed, 30, 999)
    
    running_txt_move_carot(running_text_inner_speed_minor_id, (airspeed / 1) * -1)

    if airspeed % 10 > 9 then
        running_txt_move_carot(running_text_inner_speed_major_id, ( airspeed - 9 - (math.floor(airspeed / 10) * 9) ) * -1 )
    else
        running_txt_move_carot(running_text_inner_speed_major_id, math.floor(airspeed / 10) * -1)
    end

    running_txt_move_carot(running_text_speed, (airspeed / 20) * -1)
    running_img_move_carot(running_img_speed, (airspeed / 20) * -1)    
    
    yspeed = 190 + (airspeed * 4.95)
    yspeed = var_cap(yspeed, 327, 568)
    
    viewport_rect(running_text_speed, 0, 16, 100, yspeed)
    viewport_rect(running_img_speed, 0, 16, 100, yspeed)    
    
    -- Altitude indicator running text and images
    -- Cap the altitude at 90.400 ft maximum displayed
    altitude = var_cap(altitude, 0, 90400)

    running_txt_move_carot(running_text_inner_alt_minor_id, (altitude / 20) * -1)
    
    if altitude % 100 > 90 then
        running_txt_move_carot(running_text_inner_alt_major100_id, ( altitude - 90 - (math.floor(altitude / 100) * 90) ) * -0.1 )
    else
        running_txt_move_carot(running_text_inner_alt_major100_id, math.floor(altitude / 100) * -1)
    end
    
    if (altitude % 1000) > 990 then
        running_txt_move_carot(running_text_inner_alt_major1000_id, (( altitude - 990 - (math.floor(altitude / 1000) * 990) ) * -0.1))
    else
        running_txt_move_carot(running_text_inner_alt_major1000_id, math.floor( altitude / 1000 ) * -1)
    end 

    running_txt_move_carot(running_text_alt, (altitude / 200) * -1)
    running_img_move_carot(running_img_alt, (altitude / 200) * -1)

    -- Move the ten thousand marker at the correct altitude
    if altitude >= 9990 then
        move(img_alt_mkr, nil, 80 / 10 * var_cap(altitude - 9990, 0, 10) + 304, nil, nil)
    else
        move(img_alt_mkr, nil, 304, nil, nil)
    end
    
    -- Convert pressure to HPa and set barometric pressure text
    if user_prop_get(prop_pres) == "HPA" then
        txt_set(txt_pressure, string.format("%04.0f", pressure * 33.8639) .. " HPA")
    else
        txt_set(txt_pressure, string.format("%05.02f", pressure) .. " INHG")
    end
    
end

function new_data_fsx(heading, roll, pitch, airspeed, altitude, pressure)

    new_data(heading, roll * -1, pitch * -1, airspeed, altitude, pressure)
    
end

-- Dataref and variable subscribe --
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/heading_electric_deg_mag_pilot", "FLOAT",
                      "sim/cockpit2/gauges/indicators/roll_electric_deg_pilot", "FLOAT",
                      "sim/cockpit2/gauges/indicators/pitch_electric_deg_pilot", "FLOAT",
                      "sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT",
                      "sim/flightmodel/misc/h_ind", "FLOAT",
                      "sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", "FLOAT", new_data)
fsx_variable_subscribe("PLANE HEADING DEGREES MAGNETIC", "Degrees",
                       "ATTITUDE INDICATOR BANK DEGREES", "Degrees", 
                       "ATTITUDE INDICATOR PITCH DEGREES", "Degrees", 
                       "AIRSPEED INDICATED", "Knots",
                       "PRESSURE ALTITUDE", "Feet",
                       "KOHLSMAN SETTING HG", "inHg", new_data_fsx)       
fs2020_variable_subscribe("PLANE HEADING DEGREES MAGNETIC", "Degrees",
                          "ATTITUDE INDICATOR BANK DEGREES", "Degrees", 
                          "ATTITUDE INDICATOR PITCH DEGREES", "Degrees", 
                          "AIRSPEED INDICATED", "Knots",
                          "PRESSURE ALTITUDE", "Feet",
                          "KOHLSMAN SETTING HG", "inHg", new_data_fsx)  