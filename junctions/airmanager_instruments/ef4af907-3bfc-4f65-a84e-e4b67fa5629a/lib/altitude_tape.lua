-- ALTITUDE TAPE LIBRARY --
-- TO DO TO DO TO DO TO DO TO DO --
-- The green arrow, this indicates the minimums set on the EFIS...?
-- Make the thousands on the tape bigger than the hundreds.
-- When is the ground marker visible?
-- TO DO TO DO TO DO TO DO TO DO --

-- Global variables
gbl_meters = false
gbl_stored_baro_alt = 0

function lib_altitude_tape_init()

-------------------------
-- BEGIN Altitude tape --
-------------------------
function item_value_callback_alt(i)
	return string.format("%d", i * 200 * -1 )
end

running_img_alt  = running_img_add_ver("alt_image.png",597,31,8,20,344)
viewport_rect(running_img_alt, 598, 95, 100, 590)

img_ground_ind = img_add("ground.png", 598, 685, 100, 45)
viewport_rect(img_ground_ind, 598, 95, 100, 590)

running_text_alt = running_txt_add_ver(566,-186,8,130,137,item_value_callback_alt,"size:24px; font:monofonto.ttf; color:white; halign:right;")
viewport_rect(running_text_alt, 598, 95, 100, 590)

-- These are the markers that mark every 1000 feet
running_img_1000marker  = running_img_add_ver("1000mark.png",614,-325,8,84,685)
viewport_rect(running_img_1000marker, 598, 95, 100, 590)

running_img_move_carot(running_img_alt, 0)
running_txt_move_carot(running_text_alt, 0)
running_img_move_carot(running_img_1000marker, 0)
-- END Running text and images for speed and altitude

-------------------------
-- END Altitude tape --
-------------------------

-------------------------
-- BEGIN Altitude box --
-------------------------

-- Add all speed box related images before the speed box
img_altbox_meters = img_add("altbox_ext.png", 613, 307, 121, 113)
img_ground_beam = img_add("ground_ind_beam.png", 596, 95, 2, 590)
viewport_rect(img_ground_beam, 596, 95, 2, 590)

img_green_arrow = img_add("green_arrow.png", 573, 349, 125, 56)
img_green_arrow_noline = img_add("green_arrow_noline.png", 573, 349, 26, 56)
viewport_rect(img_green_arrow, 573, 95, 125, 590)
viewport_rect(img_green_arrow_noline, 573, 95, 125, 590)

img_baro = img_add("baro.png", 494, 627, 47, 18)
img_radio = img_add("radio.png", 438, 74, nil, nil)
txt_dec_height = txt_add("", "size:34px; font:monofonto.ttf; color:#40fc21; halign:left;", 515, 58, 150, 40)

img_alt_bug = img_add("alt_bug.png", 573, 321, 50, 114)
viewport_rect(img_alt_bug, 573, 95, 50, 590)
img_altbox = img_add("altbox_norm.png", 611, 307, 125, 115)

function item_value_callback_inner_alt_minor(i)

	if i == 0 then
		return"00"
	elseif i > 0 then
		return""
	else
		return string.format("%02d", ((0 - i) %5) * 20 )
	end
	
end

running_text_inner_alt_minor_id = running_txt_add_ver(630,292,5,100,36, item_value_callback_inner_alt_minor, "size:32px; font:monofonto.ttf; color:white; halign:right")
running_txt_move_carot(running_text_inner_alt_minor_id, 0)
viewport_rect(running_text_inner_alt_minor_id,630,337,100,79)


function item_value_callback_inner_alt_major100(i)
    
	if i == 0 then
		return"0"
	else
		return string.format("%d", (0 - i) %10)
	end
	
end

running_text_inner_alt_major100_id = running_txt_add_ver(644,306,3,50,58, item_value_callback_inner_alt_major100, "size:32px; font:monofonto.ttf; color:white; halign:right")
running_txt_move_carot(running_text_inner_alt_major100_id, 0)
viewport_rect(running_text_inner_alt_major100_id,630,337,100,79)

function item_value_callback_inner_alt_major1000(i)

	if i == 0 then
		return"0"
	else
		return"" .. - i
	end
	
end

running_text_inner_alt_major1000_id = running_txt_add_ver(571,302,3,103,58, item_value_callback_inner_alt_major1000, "size:38px; font:monofonto.ttf; color:white; halign:right")
running_txt_move_carot(running_text_inner_alt_major1000_id, 0)
viewport_rect(running_text_inner_alt_major1000_id,630,337,100,79)
----------------------
-- END Altitude box --
----------------------

-- Various text (and image) elements
txt_alt_meters_m   = txt_add("M", "font:monofonto.ttf; size:22px; color: #24C0F0; halign: right;", 599, 19, 100, 60)
txt_alt_bug_meters = txt_add(" ", "font:monofonto.ttf; size:28px; color: magenta; halign: right;", 588, 15, 100, 60)
txt_alt_bug_th = txt_add(" ", "font:monofonto.ttf; size:37px; color: magenta; halign: right;", 553, 46, 100, 60)
txt_alt_bug_hu = txt_add(" ", "font:monofonto.ttf; size:30px; color: magenta; halign: right;", 599, 53, 100, 60)
txt_alt_meters = txt_add(" ", "font:monofonto.ttf; size:28px; color: white; halign: right;", 563, 308, 150, 60)

img_green_mkr = img_add("green_marker.png", 630, 359, 20, 38)
viewport_rect(img_green_mkr,630,339,100,79)

img_pull_up = img_add("pull_up_warning.png", 280, 635, 148, 33)
txt_std_on  = txt_add("STD", "font:monofonto.ttf; size:40px; color: #3fff1c;  halign: center;", 608, 687, 80, 42)
visible(txt_std_on, false)
txt_cur_qnh = txt_add(" ", "font:monofonto.ttf; size:28px; color: #3fff1c;  halign: right;", 570, 691, 100, 32)
txt_qnh_des = txt_add(" ", "font:monofonto.ttf; size:22px; color: #3fff1c;  halign: left;", 682, 697, 80, 30)
txt_cur_qnh_std = txt_add(" ", "font:monofonto.ttf; size:28px; color: white;  halign: right;", 570, 730, 100, 32)
txt_qnh_des_std = txt_add(" ", "font:monofonto.ttf; size:22px; color: white;  halign: left;", 682, 736, 80, 30)
img_ldg_alt = img_add("ldg_alt.png", 710, 648, nil, nil)

-- Radio altimeter
txt_radar_alt_white = txt_add(" ", "font:monofonto.ttf; size:48px; color:white;   halign:center;", 430, 100, 150, 60)
txt_radar_alt_amber = txt_add(" ", "font:monofonto.ttf; size:48px; color:#edbf38; halign:center;", 430, 100, 150, 60)

img_ralt_gauge_line_white_0180   = img_add("raalt_gauge_line_white_0180.png", 455, 73, 100, 100)
img_ralt_gauge_line_white_180360 = img_add("raalt_gauge_line_white_180360.png", 455, 73, 100, 100)
img_ralt_gauge_line_amber_0180   = img_add("raalt_gauge_line_amber_0180.png", 455, 73, 100, 100)
img_ralt_gauge_line_amber_180360 = img_add("raalt_gauge_line_amber_180360.png", 455, 73, 100, 100)
viewport_rect(img_ralt_gauge_line_white_0180, 505, 73, 50, 100)
viewport_rect(img_ralt_gauge_line_white_180360, 455, 73, 50, 100)
viewport_rect(img_ralt_gauge_line_amber_0180, 505, 73, 50, 100)
viewport_rect(img_ralt_gauge_line_amber_180360, 455, 73, 50, 100)

img_ralt_gauge_white = img_add("radio_altimeter_gauge_white.png", 455, 73, 100, 100)
img_ralt_gauge_amber = img_add("radio_altimeter_gauge_amber.png", 455, 73, 100, 100)
img_ralt_arrow_green = img_add("set_raalt_green.png", 455, 73, 100, 100)
img_ralt_arrow_amber = img_add("set_raalt_amber.png", 455, 73, 100, 100)
visible(img_ralt_arrow_amber, false)
visible(img_ralt_gauge_amber, false)

end

-- Now do something with the running text and images we've just added
function alt_tape_callback(altitude, APalt, MTR_button, MinsSelRADIOBARO, inHg, BAROPRESS_unit, STD_on, decision_height, LandingAltitude, GPWS)

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
    running_img_move_carot(running_img_alt, (altitude / 200) * -0.4)
	running_img_move_carot(running_img_1000marker, (altitude / 1000) * -1)
    
    -- Move the green marker for the ten thousand feet from 359px to 420px
    if altitude >= 9990 then
        move(img_green_mkr, nil, 61 / 10 * var_cap(altitude - 9990, 0, 10) + 359, nil, nil)
    else
        move(img_green_mkr, nil, 359, nil, nil)
    end

	-- Altitude bug
	visible(img_alt_bug, APalt >= 1)
    move(img_alt_bug, nil, var_cap(321 - (344 / 500 * (APalt - altitude)), 18, 645), nil, nil)

    -- Altitude dialed into the autopilot
    visible(txt_alt_bug_th, APalt >= 1000)
    txt_set(txt_alt_bug_th, math.floor(APalt / 1000))
    
    visible(txt_alt_bug_hu, APalt >= 1)
    txt_set(txt_alt_bug_hu, string.format("%.0f", APalt % 1000))
    
    -- Altitude dialed into the autopilot in meters
    APaltmeters = var_round(APalt * 0.3048, 0)
    visible(txt_alt_meters_m, MTR_button == 1 and APaltmeters > 0)
    visible(txt_alt_bug_meters, MTR_button == 1 and APaltmeters > 0)
    
    txt_set(txt_alt_bug_meters, string.format("%.0f", APaltmeters) )
	
	-- Altitude in meters
	visible(img_altbox_meters, MTR_button == 1)
	visible(img_altbox, MTR_button == 0)
		
	altmeters = altitude * 0.3048, 0
	txt_set(txt_alt_meters, string.format("%.0f", altmeters) )
	visible(txt_alt_meters, MTR_button == 1)
	
	-- Ground indicator according to the FMS landing altitude
	visible(img_ground_ind, LandingAltitude ~= -32767)
	visible(img_ground_beam, LandingAltitude ~= -32767)
	visible(img_ldg_alt, LandingAltitude == -32767)
	move(img_ground_ind, nil, 377 + (344 / 500 * LandingAltitude), nil, nil)
	move(img_ground_beam, nil, var_cap(-210 + (344 / 500 * LandingAltitude), -495, 95), nil, nil)
	
	-- Everything minimums related
	visible(img_baro, false)
	-- visible(img_green_arrow, MinsSelRADIOBARO == 1 and gbl_stored_baro_alt > 0)
	visible(img_green_arrow, false)
	-- visible(img_green_arrow_noline, MinsSelRADIOBARO == 0 and gbl_stored_baro_alt > 0)
	visible(img_green_arrow_noline, false)

	-- Baro / Radio text and baro indicator
	decision_height = var_cap(decision_height, 0, 1000)
	visible(img_radio, decision_height > 0 and LandingAltitude > 1000)
	visible(txt_dec_height, decision_height > 0 and LandingAltitude > 1000)
	txt_set(txt_dec_height, string.format("%.0f", decision_height) )
	
	visible(txt_radar_alt_white, (LandingAltitude < 2500 and LandingAltitude > decision_height) or LandingAltitude == 0)
	visible(txt_radar_alt_amber, (LandingAltitude < decision_height) and LandingAltitude > 1)
	visible(img_ralt_gauge_white, (LandingAltitude < 1000 and LandingAltitude > decision_height) or LandingAltitude == 0)
	visible(img_ralt_gauge_amber, (LandingAltitude < decision_height) and LandingAltitude > 1)
	visible(img_ralt_gauge_line_white_0180, (LandingAltitude < 1000 and LandingAltitude > decision_height) or LandingAltitude == 0)
	visible(img_ralt_gauge_line_white_180360, (LandingAltitude < 1000 and LandingAltitude > decision_height) or LandingAltitude == 0)
	visible(img_ralt_gauge_line_amber_0180, (LandingAltitude < decision_height) and LandingAltitude > 1)
	visible(img_ralt_gauge_line_amber_180360, (LandingAltitude < decision_height) and LandingAltitude > 1)
	visible(img_ralt_arrow_green, ((LandingAltitude < 1000 and LandingAltitude > decision_height) or LandingAltitude == 0) and decision_height > 0)
	visible(img_ralt_arrow_amber, ((LandingAltitude < decision_height) and LandingAltitude > 1) and decision_height > 0)
	
	rotate(img_ralt_arrow_green, 360 / 1000 * decision_height)
	rotate(img_ralt_arrow_amber, 360 / 1000 * decision_height)
	
	if LandingAltitude < 100 then
		LandingAltitude_txt = LandingAltitude
	elseif LandingAltitude >= 100 then
		LandingAltitude_txt = string.format("%.0f", LandingAltitude - (LandingAltitude % 10))
	end
	
	txt_set(txt_radar_alt_white, string.format("%.0f", LandingAltitude_txt) )
    txt_set(txt_radar_alt_amber, string.format("%.0f", LandingAltitude_txt) )
	
	rotate(img_ralt_gauge_line_white_0180, (180 / 500 * var_cap(LandingAltitude, 0, 500)) - 180)
	rotate(img_ralt_gauge_line_white_180360, (180 / 500 * var_cap(LandingAltitude, 500, 1000)) )
	rotate(img_ralt_gauge_line_amber_0180, (180 / 500 * var_cap(LandingAltitude, 0, 500)) - 180)
	rotate(img_ralt_gauge_line_amber_180360, (180 / 500 * var_cap(LandingAltitude, 500, 1000)) )
	
	-- Store the Baro value
	if decision_height > 0 then
		gbl_stored_baro_alt = decision_height
	end
	
	-- Move the baro indicators
	move(img_green_arrow, nil, 349 - (344 / 500 * (gbl_stored_baro_alt - altitude)), nil, nil)
	move(img_green_arrow_noline, nil, 349 - (344 / 500 * (gbl_stored_baro_alt - altitude)), nil, nil)
	
	-- Ground proximity warning system: PULL UP! Piieeewiieeep!
	visible(img_pull_up, GPWS == 1)
	
	-- Set the text for the QNH
	visible(txt_cur_qnh, STD_on == 0)
	visible(txt_qnh_des, STD_on == 0)
	visible(txt_std_on, STD_on == 1)
	visible(txt_cur_qnh_std, STD_on == 1)
	visible(txt_qnh_des_std, STD_on == 1)
	-- Switch between inHg and HPA according to baro_select
	Millibars = inHg * 33.863753

	if BAROPRESS_unit == 0 then
		txt_set(txt_cur_qnh, string.format("%05.02f", inHg) )
		txt_set(txt_cur_qnh_std, string.format("%05.02f", inHg) )
		txt_set(txt_qnh_des, "IN.")
		txt_set(txt_qnh_des_std, "IN.")
	elseif BAROPRESS_unit == 1 then
		txt_set(txt_cur_qnh, string.format("%.0f", Millibars) )
		txt_set(txt_cur_qnh_std, string.format("%.0f", Millibars) )
		txt_set(txt_qnh_des, "HPA")
		txt_set(txt_qnh_des_std, "HPA")
	end
	
end

-- Variable subscribe
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/altitude_ft_pilot", "FLOAT",
					  "sim/cockpit/autopilot/altitude", "FLOAT", 
					  "x737/cockpit/EFISCTRL_0/MTR_on", "INT",
					  "sim/cockpit2/gauges/indicators/radio_altimeter_dh_lit_pilot", "INT", 
					  "sim/cockpit/misc/barometer_setting", "FLOAT",
					  "x737/cockpit/EFISCTRL_0/BAROPRESS_unit", "INT",
					  "x737/cockpit/EFISCTRL_0/STD_on", "INT",
					  "sim/cockpit/misc/radio_altimeter_minimum", "FLOAT", 
					  "sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot", "FLOAT", 
					  "sim/cockpit2/annunciators/GPWS", "INT", alt_tape_callback)