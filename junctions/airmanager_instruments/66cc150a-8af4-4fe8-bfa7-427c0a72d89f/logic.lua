-- Based on the generic RMI by Siminnovations
-- Adapted for ATR 72-500 by flyatr
-- remove the bezel by clicking in the top left corner of the instrument

-- config storage 

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

-- Add images and text --

 img_add_fullscreen("backplate.png")

img_compass = img_add("rmi_rose.png",0,0,660,660)

img_s2_needle = img_add("rmi_needle_2.png",0,0,660,660)
img_s1_needle = img_add("rmi_needle_1.png",0,0,660,660)
n1_off_flag = img_add("flag_1.png", 53,218,37,400)
n2_off_flag = img_add("flag_2.png", 569,223,37,400)
hdg_off_flag = img_add("hdg_flag.png", 33,58,402,37)
rotate( hdg_off_flag , 19)
rotate(n1_off_flag, 19)
rotate(n2_off_flag, -19)
img_add("rmi_cap.png",0,0,660,660)
img_bezel = img_add_fullscreen("rmi_background.png")
-- Functions --
function new_data_xpl(heading, bearing_nav1, bearing_nav2, bearing_adf1, bearing_adf2, l_voradf, r_voradf, v1_avail, v2_avail,  power)
	-- electrical bus supply
	
	electrical_bus = fif( power[1] > 12,  true, false)
	-- off flag
	visible(hdg_off_flag, not electrical_bus)
	
	-- Rotate the compass rose
	rotate(img_compass, heading * -1)
	
	if electrical_bus then
	-- Rotate source 1 needle (yellow)
	  if l_voradf == 0 then
		gbl_target_s1_heading = bearing_nav1
                visible(n1_off_flag , v1_avail==0)
	  else
		gbl_target_s1_heading = bearing_adf1
                visible(n1_off_flag , bearing_adf1 > 89.99  and   bearing_adf1 < 90.01 )
	  end

	-- Rotate source 2 needle (green)
	  if r_voradf == 0 then
		gbl_target_s2_heading = bearing_nav2
                visible(n2_off_flag , v2_avail==0)
	  else
		gbl_target_s2_heading = bearing_adf2
                 visible(n2_off_flag , bearing_adf2 > 89.99  and   bearing_adf2 < 90.01 )
	  end
	else
		gbl_target_s1_heading = 90
		gbl_target_s2_heading = 90
                    visible(n1_off_flag , true)
                    visible(n2_off_flag , true)
	end
    switch_set_position(switch_1, l_voradf)
    switch_set_position(switch_2, r_voradf)
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



-- Add the buttons --
function callback_b1(position)
 xpl_command("sim/radios/RMI_L_tog")
end
switch_1 = switch_add("up_1_knob.png", "right_1_knob.png",0,463, 190, 169, callback_b1)


function callback_b2(position, direction)
xpl_command("sim/radios/RMI_R_tog")
end
switch_2 = switch_add("up_2_knob.png", "left_2_knob.png",464,465, 190, 169, callback_b2)

	


					  
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/heading_electric_deg_mag_pilot", "FLOAT", 
					  "sim/cockpit2/radios/indicators/nav1_relative_bearing_deg", "FLOAT", 
					  "sim/cockpit2/radios/indicators/nav2_relative_bearing_deg", "FLOAT",
					  "sim/cockpit2/radios/indicators/adf1_relative_bearing_deg", "FLOAT", 
					  "sim/cockpit2/radios/indicators/adf2_relative_bearing_deg", "FLOAT", 
                                            "sim/cockpit2/radios/actuators/RMI_left_use_adf_pilot", "INT", 
                                           "sim/cockpit2/radios/actuators/RMI_right_use_adf_pilot", "INT",
                                            "sim/cockpit2/radios/indicators/nav1_display_horizontal", "INT",
                                            "sim/cockpit2/radios/indicators/nav2_display_horizontal", "INT",
					  "sim/cockpit2/electrical/bus_volts", "FLOAT[6]", new_data_xpl)



					  
-- Timers --
tmr_update = timer_start(0, 50, timer_callback)					  