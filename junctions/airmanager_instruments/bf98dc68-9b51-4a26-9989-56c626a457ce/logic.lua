-- Based on the generic RMI by Siminnovations
-- Adapted for ATR 72-500 by flyatr
-- remove the bezel by clicking in the top left corner of the instrument

-- config storage 
rmi_config = persist_add("show_bezel","INT",1)
rmi_left_source = persist_add("source_left","INT",0)
rmi_right_source = persist_add("source_right","INT",0)

-- Global variables --
-- Initialize the needles at 90 degrees
local gbl_cur_s1_heading    = 90
local gbl_target_s1_heading = 0
local gbl_cur_s2_heading    = 90
local gbl_target_s2_heading = 0
local gbl_factor            = 0.26
local gbl_needle1_vor_mode  = persist_get(rmi_left_source)
local gbl_needle2_vor_mode 	= persist_get(rmi_right_source)
local cfg_show_bezel = persist_get(rmi_config)		-- load the bezel setting


-- Add images and text --
img_no_bezel = img_add_fullscreen("black.png")
img_bezel = img_add_fullscreen("atr_rmi_background.png")
if cfg_show_bezel == 0 then
	visible(img_bezel,false)
else
	visible(img_no_bezel,false)
end
img_compass = img_add("atr_rmi_compass.png",35,35,260,260)
img_add("atr_rmi_marking.png",30,28,270,270)
img_s2_needle = img_add("atr_rmi_needle_2.png",155,0,20,330)
img_s1_needle = img_add("atr_rmi_needle.png",155,0,20,330)
img_off_flag = img_add("atr_rmi_off.png",233,37,62,62)

-- Functions --
function new_data_fsx(heading, bearing_nav1, bearing_nav2, bearing_adf1, bearing_adf2, eng1_firing, eng2_firing)
	-- electrical bus supply
	electrical_bus = eng1_firing or eng2_firing
	
	-- off flag
	visible(img_off_flag,not electrical_bus)
	
	-- Rotate the compass rose
	rotate(img_compass, heading * -1)
	
	if electrical_bus then
	-- Rotate source 1 needle (yellow)
	  if gbl_needle1_vor_mode == 1 then
		gbl_target_s1_heading = bearing_nav1
	  else
		gbl_target_s1_heading = bearing_adf1
	  end

	-- Rotate source 2 needle (green)
	  if gbl_needle2_vor_mode == 1 then
		gbl_target_s2_heading = bearing_nav2
	  else
		gbl_target_s2_heading = bearing_adf2
	  end
	else
		gbl_target_s1_heading = 90
		gbl_target_s2_heading = 90
	end
end

-- Slowly move needle to current heading --
function timer_callback()	

    -- Rotate needle images
	rotate(img_s1_needle, gbl_cur_s1_heading)
    rotate(img_s2_needle, gbl_cur_s2_heading)

    -- Source 1 needle
    raw_diff = (360 + gbl_target_s1_heading - gbl_cur_s1_heading) %360
    diff = fif(raw_diff < 180, raw_diff, (360 - raw_diff) * -1)
    gbl_cur_s1_heading = fif(math.abs(diff) < 0.001, gbl_target_s1_heading, gbl_cur_s1_heading + (diff * gbl_factor) )

    -- Source 2 needle
    raw_diff = (360 + gbl_target_s2_heading - gbl_cur_s2_heading) %360
    diff = fif(raw_diff < 180, raw_diff, (360 - raw_diff) * -1)
    gbl_cur_s2_heading = fif(math.abs(diff) < 0.001, gbl_target_s2_heading, gbl_cur_s2_heading + (diff * gbl_factor) )

end

function new_data_xpl(heading, bearing_nav1, bearing_nav2, bearing_adf1, bearing_adf2, bus_volts)

	eng1_firing = bus_volts[1] >= 12
	eng2_firing = bus_volts[1] >= 12

	new_data_fsx(heading, bearing_nav1, bearing_nav2, bearing_adf1, bearing_adf2, eng1_firing, eng2_firing)
	
end

-- Add the buttons --
function callback_b1(position, direction)

    gbl_needle1_vor_mode = fif(gbl_needle1_vor_mode==1,0,1)
    switch_set_position(switch_1, gbl_needle1_vor_mode)
	persist_put(rmi_left_source, gbl_needle1_vor_mode)	

end
switch_1 = switch_add("atr_rmi_knob_left_vert.png", "atr_rmi_knob_left.png", 22,256, 46, 46, callback_b1)
switch_set_position(switch_1, gbl_needle1_vor_mode)

function callback_b2(position, direction)

    gbl_needle2_vor_mode = fif(gbl_needle2_vor_mode==1,0,1)
    switch_set_position(switch_2, gbl_needle2_vor_mode)
	persist_put(rmi_right_source, gbl_needle2_vor_mode)	
	
end
switch_2 = switch_add("atr_rmi_knob_right_vert.png", "atr_rmi_knob_right.png", 258,256,46,46, callback_b2)
switch_set_position(switch_2, gbl_needle2_vor_mode)
	
function bezel_config()				-- remove the bezel by clicking in the top left corner of the instrument
	if cfg_show_bezel == 1 then
		cfg_show_bezel = 0
		visible(img_bezel,false)
		visible(img_no_bezel, true)
	else
		cfg_show_bezel = 1
		visible(img_bezel, true)
		visible(img_no_bezel, false)
	end
	persist_put(rmi_config, cfg_show_bezel)	-- save setting
end
switch_add(nil,nil,0,0,80,80,bezel_config)


fsx_variable_subscribe("PLANE HEADING DEGREES GYRO", "DEGREES", 
					   "NAV RELATIVE BEARING TO STATION:1", "DEGREES", 
					   "NAV RELATIVE BEARING TO STATION:2", "DEGREES", 
					   "ADF RADIAL:1", "DEGREES", 
					   "ADF RADIAL:2", "DEGREES", 
					   "GENERAL ENG COMBUSTION:1", "BOOLEAN", 
					   "GENERAL ENG COMBUSTION:2", "BOOLEAN", new_data_fsx)
fs2020_variable_subscribe("PLANE HEADING DEGREES GYRO", "DEGREES", 
					      "NAV RELATIVE BEARING TO STATION:1", "DEGREES", 
					      "NAV RELATIVE BEARING TO STATION:2", "DEGREES", 
					      "ADF RADIAL:1", "DEGREES", 
					      "ADF RADIAL:2", "DEGREES", 
					      "GENERAL ENG COMBUSTION:1", "BOOLEAN", 
					      "GENERAL ENG COMBUSTION:2", "BOOLEAN", new_data_fsx)								   
xpl_dataref_subscribe("sim/cockpit/gyros/psi_ind_degm3", "FLOAT", 
					  "sim/cockpit2/radios/indicators/nav1_relative_bearing_deg", "FLOAT", 
					  "sim/cockpit2/radios/indicators/nav2_relative_bearing_deg", "FLOAT",
					  "sim/cockpit2/radios/indicators/adf1_relative_bearing_deg", "FLOAT", 
					  "sim/cockpit2/radios/indicators/adf2_relative_bearing_deg", "FLOAT", 
					  "sim/cockpit2/electrical/bus_volts", "FLOAT[6]", new_data_xpl)
					  
-- Timers --
tmr_update = timer_start(0, 50, timer_callback)					  