
--727 ASI--
-- Global variables --
local Vne = 395 
local Vmo = 0.82

img_add_fullscreen("machdrum.png")
img_add_fullscreen("asdrum.png")


-- Set up running text field airspeed drum hundreds
function AS_100_value_callback(i)

    return tostring((0 - i) % 10)

end

AS_100_running_txt_id = running_txt_add_ver(230,342,3,38,49,AS_100_value_callback,"size:45px; font:arimo_bold.ttf; color:#fbfcfa; halign:right;")
viewport_rect(AS_100_running_txt_id, 230, 388, 96, 53)

-- Set up running text field airspeed drum tens
function AS_10_value_callback(i)

    return tostring((0 - i) % 10)

end

AS_10_running_txt_id = running_txt_add_ver(278,342,3,38,49,AS_10_value_callback,"size:45px; font:arimo_bold.ttf; color:#fbfcfa; halign:right;") 
viewport_rect(AS_10_running_txt_id, 230, 388, 96, 53)

 -- Set up running text field airspeed drum ones
function AS_1_value_callback(i)

    return tostring((0 - i) % 10)

end

AS_1_running_txt_id = running_txt_add_ver(325,342,3,38,49,AS_1_value_callback,"size:45px; font:arimo_bold.ttf; color:#fbfcfa; halign:right;")
viewport_rect(AS_1_running_txt_id, 325, 364, 50, 100)

img_add_fullscreen("shadow2.png")
img_add_fullscreen("shadow3.png")

-- Dataref callback for new_airspeed
function new_airspeed(ASpeed)

    -- AS drum hundreds
    if ASpeed % 100 > 99 then
        running_txt_move_carot(AS_100_running_txt_id, ( ASpeed / 10 - 9.9 - (math.floor(ASpeed / 100) * 9.9) ) * -10 )
    else
        running_txt_move_carot(AS_100_running_txt_id, math.floor(ASpeed / 100)* -1)
    end
    
    -- AS drum tens
    if ASpeed % 10 > 9 then
        running_txt_move_carot(AS_10_running_txt_id, ( ASpeed - 9 - (math.floor(ASpeed / 10) * 9) )* -1)
    else
        running_txt_move_carot(AS_10_running_txt_id, math.floor(ASpeed / 10)* -1)
    end
    
    -- AS drum ones
    running_txt_move_carot(AS_1_running_txt_id, (ASpeed / 1)* -1)
    
end

-- Set up running text field machspeed drum 1st decimal
function MS_100_value_callback(i)

    return string.format("%.0f", (0 - i) % 10)

end

MS_100_running_txt_id = running_txt_add_ver(230,122,3,38,49,MS_100_value_callback,"size:45px; font:arimo_bold.ttf; color:#fbfcfa; halign:right;")
viewport_rect(MS_100_running_txt_id, 228, 156, 148, 68)

-- Set up running text field machspeed drum 2nd decimal
function MS_10_value_callback(i)

    return string.format("%.0f", (0 - i) % 10)

end

MS_10_running_txt_id = running_txt_add_ver(278,122,3,38,49,MS_10_value_callback,"size:45px; font:arimo_bold.ttf; color:#fbfcfa; halign:right;") 
viewport_rect(MS_10_running_txt_id, 228, 156, 148, 68)

 -- Set up running text field machspeed drum 3rd decimal
function MS_1_value_callback(i)

    return string.format("%.0f", (0 - i) % 10)

end

MS_1_running_txt_id = running_txt_add_ver(325,122,3,38,49,MS_1_value_callback,"size:45px; font:arimo_bold.ttf; color:#fbfcfa; halign:right;")
viewport_rect(MS_1_running_txt_id, 228, 156, 148, 68)

img_add_fullscreen("shadow1.png")

-- Dataref callback for new_airspeed
function new_machspeed(MSpeed)

    MSpeed1 = (MSpeed * 1000)

    -- MS drum 1st decimal
    if (MSpeed1 % 100) > 99 then
        running_txt_move_carot(MS_100_running_txt_id, ( MSpeed1 / 10 - 9.9 - (math.floor(MSpeed1 / 100) * 9.9) ) * -10 )
    else
        running_txt_move_carot(MS_100_running_txt_id, math.floor(MSpeed1 / 100)* -1)
    end
    
    -- MS drum 2nd decimal
    if MSpeed1 % 10 > 9 then
        running_txt_move_carot(MS_10_running_txt_id, ( MSpeed1 - 9 - (math.floor(MSpeed1 / 10) * 9) )* -1)
    else
        running_txt_move_carot(MS_10_running_txt_id, math.floor(MSpeed1 / 10)* -1)
    end
    
    -- MS drum 3rd decimal
    running_txt_move_carot(MS_1_running_txt_id, (MSpeed1 / 1)* -1)
    
end


-- Add images --
img_add_fullscreen("airspeed_backdrop.png")
img_barberneedle = img_add_fullscreen("barberneedle.png")
img_needle = img_add_fullscreen("needle.png")
rotate(img_needle, 0)

-- 0 = -4 
-- 60 = 3.5
-- 250 = 243
-- 450 = 332

-- Functions --
function PT_airspeed(airspeed, T0, T, PA)
    
    airspeed = var_cap(airspeed, 0, 450)
    
    if airspeed > 300 then
        rotate (img_needle, 61.5 / 150 * (airspeed-300) + 270.5)
    elseif airspeed > 250 then
        rotate (img_needle, 27.5 / 50 * (airspeed-250) + 243)
    elseif airspeed > 60 then
        rotate (img_needle, 239.5 / 190 * (airspeed-60) + 3.5)
    elseif airspeed >= 0 then
        rotate (img_needle, -4 + (7.5/60 * airspeed))
    
    
 end
    
    --Barbers pole
    CS0 = 38.967854 * (T0 + 470)^0.5 -- speed of sound at sea level
    CS = 38.967854 * (T + 470)^0.5 -- speed of sound at current level

    x = (1 - 6.8755856 * 10^-6 * PA)^5.2558797
    a = (1 + Vmo^(2/5))^3.5 - 1
    limitIas2 = CS0 * ((((1 + x * a)^(2/7)) - 1) / 5)^0.5  -- barber pole limit IAS computed with compressibility

    if limitIas2 < Vne then
        rotate(img_barberneedle, limitIas2 * 0.46 + 157.33)
    elseif limitIas2 >= Vne then
        rotate(img_barberneedle, Vne * 0.46 + 157.33)
    end
    
end

-- Data subscribe --
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT", new_airspeed)
fsx_variable_subscribe("AIRSPEED INDICATED", "Knots", new_airspeed)
fs2020_variable_subscribe("AIRSPEED INDICATED", "Knots", new_airspeed)
xpl_dataref_subscribe("sim/flightmodel/misc/machno", "FLOAT", new_machspeed)
fsx_variable_subscribe("AIRSPEED MACH", "Mach", new_machspeed)
fs2020_variable_subscribe("AIRSPEED MACH", "Mach", new_machspeed)
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT", 
                      "sim/weather/temperature_sealevel_c", "FLOAT", 
                      "sim/cockpit2/temperature/outside_air_temp_degc", "FLOAT",
                      "sim/cockpit2/gauges/indicators/altitude_ft_pilot", "FLOAT", PT_airspeed)
fsx_variable_subscribe("AIRSPEED INDICATED", "Knots",
                       "AMBIENT TEMPERATURE", "Celsius",
                       "TOTAL AIR TEMPERATURE", "Celsius",
                       "Indicated Altitude", "Feet", PT_airspeed)
fs2020_variable_subscribe("AIRSPEED INDICATED", "Knots",
                          "AMBIENT TEMPERATURE", "Celsius",
                          "TOTAL AIR TEMPERATURE", "Celsius",
                          "Indicated Altitude", "Feet", PT_airspeed)                       