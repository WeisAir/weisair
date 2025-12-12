-- SPEED TAPE LIBRARY --
-- TO DO TO DO TO DO TO DO TO DO --
-- TO DO TO DO TO DO TO DO TO DO --

-- Local global variables
local gbl_max_accel			= 10
local gbl_novspd_timeout	= 3

function lib_speed_tape_init()

----------------------
-- BEGIN Speed tape --
----------------------
function item_value_callback_speed(i)
    return string.format("%d", 0 - (i * 20) )
end

running_text_speed = running_txt_add_ver(-6,-77,10,100,88,item_value_callback_speed,"size:30px; font:monofonto.ttf; color:white; halign:right;")
running_img_speed  = running_img_add_ver("speed_image.png",104,113,18,15,44)

running_img_move_carot(running_img_speed, 0)
running_txt_move_carot(running_text_speed, 0)
--------------------
-- END Speed tape --
--------------------

---------------------
-- BEGIN Speed box --
---------------------

-- Add all speed tape related images before the speed box
img_accel_up = img_add("accel_up.png", 100, 200, 14, 181)
viewport_rect(img_accel_up, 18, 95, 100, 283)
img_accel_dn = img_add("accel_dn.png", 100, 223, 14, 181)
viewport_rect(img_accel_dn, 18, 378, 100, 283)
img_spd_bug = img_add("speed_bug.png", 104, 365, 47, 26)
viewport_rect(img_spd_bug, 104, 95, 47, 590)
img_v1_bug = img_add("v1.png", 111, 370, nil, nil)
viewport_rect(img_v1_bug, 111, 95, 50, 590)
img_v2_bug = img_add("v2.png", 111, 370, nil, nil)
viewport_rect(img_v2_bug, 111, 95, 50, 590)
img_vr_bug = img_add("vr.png", 111, 370, nil, nil)
viewport_rect(img_vr_bug, 111, 95, 50, 590)
img_ref_bug = img_add("ref.png", 111, 370, nil, nil)
viewport_rect(img_ref_bug, 111, 95, 50, 590)

-- img_spdbox_yellow = img_add("spd_box_yellow.png", 11, 333, 98, 90)
img_spdbox_white = img_add("spd_box_white.png", 9, 331, 102, 94)

function item_value_callback_inner_speed_one(i)
    
	if i > 0 then
		return""
	else
		return string.format("%d", (0 - i) % 10 )
	end
	
end

running_text_inner_speed_one_id = running_txt_add_ver(13,221,5,80,66, item_value_callback_inner_speed_one, "size:50px; font:monofonto.ttf; color:white; halign:right")
running_txt_move_carot(running_text_inner_speed_one_id, 0)

viewport_rect(running_text_inner_speed_one_id,13,337,77,82)

function item_value_callback_inner_speed_ten(i)
    
	if i == 0 then
		return ""
	else
		return string.format("%d", (0 - i) % 10)
	end
	
end

running_text_inner_speed_ten_id = running_txt_add_ver(-13,287,3,80,66, item_value_callback_inner_speed_ten, "size:50px; font:monofonto.ttf; color:white; halign:right")
running_txt_move_carot(running_text_inner_speed_ten_id, 0)

viewport_rect(running_text_inner_speed_ten_id,13,337,77,82)

function item_value_callback_inner_speed_hundred(i)
    
	if i == 0 then
		return ""
	else
		return string.format("%d", (0 - i) % 10)
	end
	
end

running_text_inner_speed_hundred_id = running_txt_add_ver(-39,287,3,80,66, item_value_callback_inner_speed_hundred, "size:50px; font:monofonto.ttf; color:white; halign:right")
running_txt_move_carot(running_text_inner_speed_hundred_id, 0)

viewport_rect(running_text_inner_speed_hundred_id,13,337,77,82)
---------------------
-- END Speed box --
---------------------

-- Add autopilot speed text
txt_spd_bug = txt_add(" ", "font:monofonto.ttf; size:37px; color: magenta; halign:center;", 33, 36, 100, 44)

-- Ground speed
-- img_gndspd_box = img_add("gs_box.png", 13, 699, 115, 46)
img_gndspd_nobox = img_add("gs_nobox.png", 13, 699, 115, 46)
img_no_vspd = img_add("no_vspd.png", 124, 226, 33, 123)
txt_gnd_spd = txt_add(" ", "font:monofonto.ttf; size:44px; color: white;  halign:right;", 27, 693, 100, 60)

-- VREF
img_vref = img_add("VREF.png", 180, 627, 45, 17)
img_v1ref = img_add("v1ref.png", 180, 627, 45, 17)
img_veref = img_add("veref.png", 180, 627, 45, 17)
img_vrref = img_add("vrref.png", 180, 627, 45, 17)
img_wtref = img_add("wtref.png", 180, 627, 45, 17)
img_verefbug = img_add("vemanualmarker.png", 111, 373, nil, nil)
viewport_rect(img_verefbug, 111, 95, 50, 590)
txt_vref = txt_add(" ", "font:monofonto.ttf; size:23px; color: #40fc21; halign:left;", 180, 642, 100, 60)

end

-- Now do something with the running text and images we've just added
function speed_tape_callback(airspeed, APairspeed, MCPSPD_ismach, acceleration, gnd_spd_kts, spd_mach, LandingVREF, on_ground, v1, manual_v1, v2, vr, manual_vr, vref, spdref_mode, spdref_value, vextra)

    -- Cap the airspeed at 999 knots maximum displayed
	airspeed = var_cap(airspeed, 45, 999)
	gbl_airspeed = airspeed
    
    running_txt_move_carot(running_text_inner_speed_one_id, (airspeed / 1) * -1)

    if airspeed % 10 > 9 then
    	running_txt_move_carot(running_text_inner_speed_ten_id, ( airspeed - 9 - (math.floor(airspeed / 10) * 9) ) * -1 )
    else
    	running_txt_move_carot(running_text_inner_speed_ten_id, math.floor(airspeed / 10) * -1)
    end

    if airspeed % 100 > 99 then
    	running_txt_move_carot(running_text_inner_speed_hundred_id, ( airspeed / 10 - 9.9 - (math.floor(airspeed / 100) * 9.9) ) * -10 )
    else
    	running_txt_move_carot(running_text_inner_speed_hundred_id, math.floor(airspeed / 100) * -1)
    end
	
    running_txt_move_carot(running_text_speed, (airspeed / 20) * -1)
    running_img_move_carot(running_img_speed, (airspeed / 20) * -2)
	
	-- Adjust the moving viewport for the speed tape
	tape_height = var_cap(284 / 65 * (airspeed - 30) + 306, 306, 590)
	viewport_rect(running_text_speed, 18, 95, 100, tape_height)
	viewport_rect(running_img_speed, 18, 95, 100, tape_height)
	
	-- Move the airspeed bug (in x737 no dataref found so far that hides the bug, like with PMDG)
	visible(img_spd_bug, APairspeed > 0)
    move(img_spd_bug, nil, var_cap(365 - (44 / 10 * (APairspeed - airspeed)), 82, 672), nil, nil)
	
	-- Airspeed acceleration indicators
    visible(img_accel_up, acceleration >= 0.3)
    visible(img_accel_dn, acceleration <= -0.3)
    
    move(img_accel_up, nil, var_cap(359 - 152 / gbl_max_accel * acceleration, 200, 359), nil, nil)
    move(img_accel_dn, nil, var_cap(223 + 152 / gbl_max_accel * (acceleration * -1), 223, 382), nil, nil)
	
	-- If autopilot is in airspeed mode, then set selected airspeed
	-- (in x737 no dataref found so far that hides the bug, like with PMDG)
	visible(txt_spd_bug, APairspeed > 0 or MCPSPD_ismach == 1)

	if MCPSPD_ismach == 1 then
		txt_set(txt_spd_bug, "." .. string.format("%02.0f", APairspeed * 100) )
	else
		txt_set(txt_spd_bug, string.format("%.0f", math.floor(APairspeed)))
	end

    -- Set groundspeed text. Speed in mach at and above 0.4 Mach
	spd_mach_text = string.format("%03.0f", spd_mach * 1000)
	
	if spd_mach < 0.4 then
		txt_set(txt_gnd_spd, string.format("%.0f", gnd_spd_kts) )
		visible(img_gndspd_nobox, true)
	else
		txt_set(txt_gnd_spd, "." .. spd_mach_text)
		visible(img_gndspd_nobox, false)
	end
	
	-- No vertical speed set warning
	visible(img_no_vspd, ((v1 < 100) and (vr < 100) and (manual_v1 < 100) and (manual_vr < 100)) and on_ground == 1)
	
	-- Move the V1 bug
	visible(img_v1_bug, v1 < 0 and on_ground == 1)
    move(img_v1_bug, nil, var_cap(371 - (44 / 10 * (v1 - airspeed)), 82, 672), nil, nil)
	
	-- Move the V2 bug
	visible(img_v2_bug, false)
    move(img_v2_bug, nil, var_cap(371 - (44 / 10 * (v2 - airspeed)), 82, 672), nil, nil)
	
	-- Move the VR bug
	visible(img_vr_bug, vr < 0 and on_ground == 1)
    move(img_vr_bug, nil, var_cap(371 - (44 / 10 * (vr - airspeed)), 82, 672), nil, nil)
	
	-- Move the landing VREF bug
	visible(img_ref_bug, vref < 0)
    move(img_ref_bug, nil, var_cap(371 - (44 / 10 * (vref - airspeed)), 82, 672), nil, nil)
	
	-- All the manual speed ref bug indicators and their text
	-- There is no possibility to set the gross weight (Mode 3)
	visible(img_v1ref, spdref_mode == 1)
	visible(img_vrref, spdref_mode == 2)
	visible(img_wtref, spdref_mode == 3)
	visible(img_vref, spdref_mode == 4)
	visible(img_veref, spdref_mode == 5)
	
	if spdref_value >= 100 and spdref_mode ~= 3 and spdref_mode <= 5 then
		txt_set(txt_vref, var_round(spdref_value, 0) )
	else
		txt_set(txt_vref, " ")
	end

	visible(img_verefbug, vextra > 100)
    move(img_verefbug, nil, 371 - (44 / 10 * (vextra - airspeed)), nil, nil)
end

-- Variable subscribe
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT", 
					  "sim/cockpit/autopilot/airspeed", "FLOAT", 
					  "sim/cockpit/autopilot/airspeed_is_mach", "INT",
					  "sim/cockpit2/gauges/indicators/airspeed_acceleration_kts_sec_pilot", "FLOAT", 
					  "sim/cockpit2/radios/indicators/gps_dme_speed_kts", "FLOAT", 
					  "sim/flightmodel/misc/machno", "FLOAT",
					  "x737/systems/FMC/SPDREF_vref", "FLOAT", 
					  "sim/flightmodel/failures/onground_all", "INT", 
					  "x737/systems/FMC/SPDREF_v1", "FLOAT", 
					  "x737/systems/SPDREF/manual_v1", "FLOAT",
					  "x737/systems/FMC/SPDREF_v2", "FLOAT",
					  "x737/systems/FMC/SPDREF_vr", "FLOAT", 
					  "x737/systems/SPDREF/manual_vR", "FLOAT",
					  "x737/systems/FMC/SPDREF_vref", "FLOAT", 
					  "x737/systems/SPDREF/mode", "INT", 
					  "x737/systems/SPDREF/value", "FLOAT",
					  "x737/systems/SPDREF/manual_vextra", "FLOAT", speed_tape_callback)