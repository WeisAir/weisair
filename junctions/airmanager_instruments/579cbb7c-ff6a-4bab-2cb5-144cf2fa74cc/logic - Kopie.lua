background = img_add_fullscreen("background_sm.png")

-- geometry and style settings
local button_width = 134
local button_height = 59
local button_gap_x = 7.5
local button_gap_y = 13
local button_row_1 = 13.562
local button_col_1 = 20.339
local button_dots_width = 45
local button_dots_height = 12.5
local button_lable_style = "font: arimo_bold.ttf; size:25; color: white; halign:center;"
local button_lable_style_inop = "font: arimo_bold.ttf; size:25; color: #3A3B3C; halign:center;"
 
local knob_width = 67
local knob_height = 67
local knob_gap_y = 22
local knob_row_1 = 165 - 8 
local knob_col_1 = 19.339
local knob_col_2 = 254 -20
local knob_col_3 = 703 +20
local knob_col_4 = 937
local knob_lable_style = "font: arimo_bold.ttf; size:20; color: white; halign:center; valign:center"
local knob_lable_style_inop = "font: arimo_bold.ttf; size:20; color: #3A3B3C; halign:center; valign:center"

local value_text_width = 131
local value_text_height = knob_height
local value_text_offset_x = knob_width + 4
local value_text_style = "font: digital-7-mono.ttf; size:30; color: green; halign:center; valign:center"
local value_text_style_inop = "font: digital-7-mono.ttf; size:30; color: #3A3B3C; halign:center; valign:center"
local value_text_style_act = "font: digital-7-mono.ttf; size:28; color: green; halign:center; valign:center"
local value_text_style_stby = "font: digital-7-mono.ttf; size:28; color: red; halign:center; valign:center"
local value_text_style_sub = "font: digital-7-mono.ttf; size:18; color: white; halign:center; valign:center"

local xpdr_dot_pos_y = knob_row_1	+ 3.43* knob_height + 3* knob_gap_y
local xpdr_dot_pos_0_x = knob_col_3 - 1.9* value_text_offset_x + 86
local xpdr_dot_pos_1_x = knob_col_3 - 1.9* value_text_offset_x + 70
local xpdr_dot_pos_2_x = knob_col_3 - 1.9* value_text_offset_x + 55
local xpdr_dot_pos_3_x = knob_col_3 - 1.9* value_text_offset_x + 40
local xpdr_knob_diameter = 4

local info_bar_x = 29
local info_bar_y = 504
local info_bar_width = 968
local info_bar_height = 30
local info_bar_txt_style_inactive = "font: arimo_bold.ttf; size:15; color: #3A3B3C; halign:center; valign:center"
local info_bar_txt_style_active = "font: arimo_bold.ttf; size:15; color: green; halign:center; valign:center"
local info_bar_txt_style_static = "font: arimo_bold.ttf; size:15; color: white; halign:center; valign:center"

-- used data variables
local xpdr_selected_digit = 0

-- button callback functions
--NOTE: matrix annotation convention: ROW.COLUMN => 1.2 means 1st row, 2nd. column
function callback_btn_1_1()
	--SPEED
	xpl_command("laminar/B738/autopilot/speed_press")
end

function callback_btn_1_2()
	--VNAV
	xpl_command("laminar/B738/autopilot/vnav_press")
end

function callback_btn_1_3()
	--LNAV
	xpl_command("laminar/B738/autopilot/lnav_press")
end

function callback_btn_1_4()
	--VOR LOC
	xpl_command("laminar/B738/autopilot/vorloc_press")
end

function callback_btn_1_5()
	--ALTHLD
	xpl_command("laminar/B738/autopilot/alt_hld_press")
end

function callback_btn_1_6()
	--CMDA
	xpl_command("laminar/B738/autopilot/cmd_a_press")
end

function callback_btn_1_7()
	--CMDB
	xpl_command("laminar/B738/autopilot/cmd_b_press")
end

function callback_btn_2_1()
	--N1
	xpl_command("laminar/B738/autopilot/n1_press")
end

function callback_btn_2_2()
	--LVL CHG
	xpl_command("laminar/B738/autopilot/lvl_chg_press")
end

function callback_btn_2_3()
	--HDG SEL
	xpl_command("laminar/B738/autopilot/hdg_sel_press")
end

function callback_btn_2_4()
	--APP
	xpl_command("laminar/B738/autopilot/app_press")
end

function callback_btn_2_5()
	--VS
	xpl_command("laminar/B738/autopilot/vs_press")
end

function callback_btn_2_6()
	--CWS-A
	xpl_command("laminar/B738/autopilot/cws_a_press")
end

function callback_btn_2_7()
	--CWS-B
	xpl_command("laminar/B738/autopilot/cws_b_press")
end

-- dual dial callback functions

function callback_outer_knob_turn_1_1(direction)
--ALT 1000er
	if direction == 1 then
		xpl_command("sim/autopilot/altitude_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/altitude_down")
	end
end

function callback_inner_knob_turn_1_1(direction)
--ALT 100er
end

function callback_knob_press_1_1()
	--ALT INV
	xpl_command("laminar/B738/autopilot/alt_interv")
end

function callback_outer_knob_turn_1_2(direction)
	--CRS1 10er
	if direction == 1 then
		xpl_command("sim/radios/obs_HSI_up")
	elseif direction == -1 then
		xpl_command("sim/radios/obs_HSI_down")
	end
end

function callback_inner_knob_turn_1_2(direction)
--CRS1 1er
end

function callback_knob_press_1_2()
	--CRS1 Sync with CRS2
	dataref("course_pilot", "laminar/B738/autopilot/course_pilot", "readonly")
	dataref("course_copilot", "laminar/B738/autopilot/course_copilot", "writable")
	if (course_pilot ~= course_copilot) then set("laminar/B738/autopilot/course_copilot", course_pilot) end

end

function callback_outer_knob_turn_1_3(direction)
	--ADF1 10er
	if direction == 1 then
		xpl_command("sim/radios/stby_adf1_tens_up")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_adf1_tens_down")
	end
end

function callback_inner_knob_turn_1_3(direction)
	--ADF1 1er
	if direction == 1 then
		xpl_command("sim/radios/stby_adf1_ones_up")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_adf1_ones_down")
	end
end

function callback_knob_press_1_3()
	--ADF1 active / stby toggle
	xpl_command("sim/radios/adf1_standy_flip")
end

function callback_outer_knob_turn_1_4(direction)
	--COM1 123
	if direction == 1 then
		xpl_command("sim/radios/stby_com1_coarse_up")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_com1_coarse_down")
	end

end

function callback_inner_knob_turn_1_4(direction)
	--COM1 456 -> detect turn speed to be faster
	if direction == 1 then
		xpl_command("sim/radios/stby_com1_fine_up_833")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_com1_fine_down_833")
	end
end

function callback_knob_press_1_4()
	--COM1 active / stby toggle
	xpl_command("sim/radios/com1_standy_flip")

end

function callback_outer_knob_turn_2_1(direction)
	--HDG 10er
	if direction == 1 then 
		xpl_command("sim/autopilot/heading_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/heading_down")
	end
end

function callback_inner_knob_turn_2_1(direction)
--HDG 1er
end

function callback_knob_press_2_1()
--HDG ???
end

function callback_outer_knob_turn_2_2(direction)
	--CRS2 10er
	if direction == 1 then
		xpl_command("sim/radios/copilot_obs_HSI_up")
	elseif direction == -1 then
		xpl_command("sim/radios/copilot_obs_HSI_down")
	end
end

function callback_inner_knob_turn_2_2(direction)
--CRS2 1er
end

function callback_knob_press_2_2()
	-- CRS2 sync CRS1
	dataref("course_pilot", "laminar/B738/autopilot/course_pilot", "writable")
	dataref("course_copilot", "laminar/B738/autopilot/course_copilot", "readonly")
	if (course_pilot ~= course_copilot) then set("laminar/B738/autopilot/course_pilot", course_copilot) end
end

function callback_outer_knob_turn_2_3(direction)
	--ADF1 10er
	if direction == 1 then
		xpl_command("sim/radios/stby_adf2_tens_up")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_adf2_tens_down")
	end
end

function callback_inner_knob_turn_2_3(direction)
	--ADF1 1er
	if direction == 1 then
		xpl_command("sim/radios/stby_adf2_ones_up")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_adf2_ones_down")
	end
end

function callback_knob_press_2_3()
	--ADF1 active / stby toggle
	xpl_command("sim/radios/adf2_standy_flip")
end

function callback_outer_knob_turn_2_4(direction)
	--COM2 123
	if direction == 1 then
		xpl_command("sim/radios/stby_com2_fine_up_833")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_com2_fine_down_833")
	end
end

function callback_inner_knob_turn_2_4(direction)
	--COM2 456 -> detect turn speed to be faster
	if direction == 1 then
		xpl_command("sim/radios/stby_com2_fine_up_833")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_com2_fine_down_833")
	end
end

function callback_knob_press_2_4()
	--COM2 active / stby toggle
	xpl_command("sim/radios/com2_standy_flip")
end

function callback_outer_knob_turn_3_1(direction)
	--IAS 10er
	if direction == 1 then
		xpl_command("sim/autopilot/airspeed_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/airspeed_down")
	end	

end

function callback_inner_knob_turn_3_1(direction)
--IAS 1er
end

function callback_knob_press_3_1()
	--SPEED INV
	xpl_command("laminar/B738/autopilot/spd_interv")
end

function callback_outer_knob_turn_3_2(direction)
--inop
end

function callback_inner_knob_turn_3_2(direction)
--inop
end

function callback_knob_press_3_2()
--inop
end

function callback_outer_knob_turn_3_3(direction)
--DME 10er
end

function callback_inner_knob_turn_3_3(direction)
--DME 1er
end

function callback_knob_press_3_3()
--DME ???
end

function callback_outer_knob_turn_3_4(direction)
	--NAV1 123
	if direction == 1 then
		xpl_command("sim/radios/stby_nav1_coarse_up")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_nav1_coarse_down")
	end
end

function callback_inner_knob_turn_3_4(direction)
	--NAV1 456
	if direction == 1 then
		xpl_command("sim/radios/stby_nav1_fine_up")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_nav1_fine_down")
	end
end

function callback_knob_press_3_4()
	--NAV1 active / stby toggle
	xpl_command("sim/radios/nav1_standy_flip")
end

function callback_outer_knob_turn_4_1(direction)
	--VS 1000er
	if direction == 1 then 
		xpl_command("sim/autopilot/vertical_speed_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/vertical_speed_down")
	end
end

function callback_inner_knob_turn_4_1(direction)
	--VS 100er
	if direction == 1 then 
		xpl_command("sim/autopilot/vertical_speed_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/vertical_speed_down")
	end
end

function callback_knob_press_4_1()
--VS set 0
end

function callback_outer_knob_turn_4_2(direction)
--inop
end

function callback_inner_knob_turn_4_2(direction)
--inop
end

function callback_knob_press_4_2()
--inop
end

function callback_outer_knob_turn_4_3(direction)
	--XPDR select digit
	--FN+ => maybe toggle XPDR modes
	
	xpdr_selected_digit = xpdr_selected_digit + direction
	xpdr_selected_digit_current = var_cap(xpdr_selected_digit,0,3)
			
	if xpdr_selected_digit_current == 0 then move(xpdr_active_digit_dot,xpdr_dot_pos_0_x) end		
	if xpdr_selected_digit_current == 1 then move(xpdr_active_digit_dot,xpdr_dot_pos_1_x) end
	if xpdr_selected_digit_current == 2 then move(xpdr_active_digit_dot,xpdr_dot_pos_2_x) end
	if xpdr_selected_digit_current == 3 then move(xpdr_active_digit_dot,xpdr_dot_pos_3_x) end	

	xpdr_selected_digit = xpdr_selected_digit_current
	
end

function callback_inner_knob_turn_4_3(direction)
	--XPDR select 0..7 per digit
	
	if direction == 1 then 
		
		if xpdr_selected_digit == 0 then xpl_command("sim/transponder/transponder_ones_up") end
		if xpdr_selected_digit == 1 then xpl_command("sim/transponder/transponder_tens_up") end
		if xpdr_selected_digit == 2 then xpl_command("sim/transponder/transponder_hundreds_up") end
		if xpdr_selected_digit == 3 then xpl_command("sim/transponder/transponder_thousands_up") end

	end
	
	if direction == -1 then
		
		if xpdr_selected_digit == 0 then xpl_command("sim/transponder/transponder_ones_down") end
		if xpdr_selected_digit == 1 then xpl_command("sim/transponder/transponder_tens_down") end
		if xpdr_selected_digit == 2 then xpl_command("sim/transponder/transponder_hundreds_down") end
		if xpdr_selected_digit == 3 then xpl_command("sim/transponder/transponder_thousands_down") end
		
	end
	
end

function callback_knob_press_4_3()
	--XPDR ident
	xpl_command("laminar/B738/push_button/transponder_ident_dn")
end

function callback_outer_knob_turn_4_4(direction)
	--NAV2 123
	if direction == 1 then 
		xpl_command("sim/radios/stby_nav2_coarse_up")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_nav2_coarse_down")
	end
end

function callback_inner_knob_turn_4_4(direction)
	--NAV2 456 -> detect turn speed to be faster
	if direction == 1 then 
		xpl_command("sim/radios/stby_nav2_fine_up")
	elseif direction == -1 then
		xpl_command("sim/radios/stby_nav2_fine_down")
	end
end

function callback_knob_press_4_4()
	--NAV2 active / stby toggle
	xpl_command("sim/radios/nav2_standy_flip")
end

-- add button overlay
btn_1_1 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1,                                    	button_row_1, button_width, button_height, callback_btn_1_1)
btn_1_2 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 1* button_width + 1* button_gap_x,	button_row_1, button_width, button_height, callback_btn_1_2)
btn_1_3 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 2* button_width + 2* button_gap_x,  	button_row_1, button_width, button_height, callback_btn_1_3)
btn_1_4 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 3* button_width + 3* button_gap_x,	button_row_1, button_width, button_height, callback_btn_1_4)
btn_1_5 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 4* button_width + 4* button_gap_x,  	button_row_1, button_width, button_height, callback_btn_1_5)
btn_1_6 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 5* button_width + 5* button_gap_x,	button_row_1, button_width, button_height, callback_btn_1_6)
btn_1_7 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 6* button_width + 6* button_gap_x,	button_row_1, button_width, button_height, callback_btn_1_7)
                     					 
btn_2_1 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1,                                    	button_row_1 + button_height + button_gap_y, button_width, button_height, callback_btn_2_1)
btn_2_2 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 1* button_width + 1* button_gap_x,	button_row_1 + button_height + button_gap_y, button_width, button_height, callback_btn_2_2)
btn_2_3 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 2* button_width + 2* button_gap_x,  	button_row_1 + button_height + button_gap_y, button_width, button_height, callback_btn_2_3)
btn_2_4 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 3* button_width + 3* button_gap_x,	button_row_1 + button_height + button_gap_y, button_width, button_height, callback_btn_2_4)
btn_2_5 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 4* button_width + 4* button_gap_x,  	button_row_1 + button_height + button_gap_y, button_width, button_height, callback_btn_2_5)
btn_2_6 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 5* button_width + 5* button_gap_x,	button_row_1 + button_height + button_gap_y, button_width, button_height, callback_btn_2_6)
btn_2_7 = button_add("btn_not_pressed.png", "btn_pressed.png", button_col_1 + 6* button_width + 6* button_gap_x,	button_row_1 + button_height + button_gap_y, button_width, button_height, callback_btn_2_7)

-- add button light dots (inactive)
btn_dots_white_1_1 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width),                                    	button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_white_1_2 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 1* button_width + 1* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_white_1_3 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 2* button_width + 2* button_gap_x, button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_white_1_4 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 3* button_width + 3* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_white_1_5 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 4* button_width + 4* button_gap_x, button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_white_1_6 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 5* button_width + 5* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_white_1_7 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 6* button_width + 6* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_white_2_1 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width),                                    	button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_white_2_2 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 1* button_width + 1* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_white_2_3 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 2* button_width + 2* button_gap_x, button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_white_2_4 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 3* button_width + 3* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_white_2_5 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 4* button_width + 4* button_gap_x, button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_white_2_6 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 5* button_width + 5* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_white_2_7 = img_add("white_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 6* button_width + 6* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)

-- add button light dots (active)
btn_dots_green_1_1 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width),                                    	button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_green_1_2 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 1* button_width + 1* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_green_1_3 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 2* button_width + 2* button_gap_x, button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_green_1_4 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 3* button_width + 3* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_green_1_5 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 4* button_width + 4* button_gap_x, button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_green_1_6 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 5* button_width + 5* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_green_1_7 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 6* button_width + 6* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height), button_dots_width, button_dots_height)
btn_dots_green_2_1 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width),                                    	button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_green_2_2 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 1* button_width + 1* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_green_2_3 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 2* button_width + 2* button_gap_x, button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_green_2_4 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 3* button_width + 3* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_green_2_5 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 4* button_width + 4* button_gap_x, button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_green_2_6 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 5* button_width + 5* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)
btn_dots_green_2_7 = img_add("green_dots.png", button_col_1 + 0.5*(button_width-button_dots_width) + 6* button_width + 6* button_gap_x,	button_row_1 + (button_height - 1.5*button_dots_height) + button_height + button_gap_y, button_dots_width, button_dots_height)

visible(btn_dots_green_1_1, false)
visible(btn_dots_green_1_2, false)
visible(btn_dots_green_1_3, false)
visible(btn_dots_green_1_4, false)
visible(btn_dots_green_1_5, false)
visible(btn_dots_green_1_6, false)
visible(btn_dots_green_1_7, false)
visible(btn_dots_green_2_1, false)
visible(btn_dots_green_2_2, false)
visible(btn_dots_green_2_3, false)
visible(btn_dots_green_2_4, false)
visible(btn_dots_green_2_5, false)
visible(btn_dots_green_2_6, false)
visible(btn_dots_green_2_7, false)


-- add button lable overlay
lable_btn_1_1 = txt_add("SPEED", button_lable_style, button_col_1,                                    	button_row_1 + button_gap_y, button_width, button_height)
lable_btn_1_2 = txt_add("VNAV", button_lable_style, button_col_1 + 1* button_width + 1* button_gap_x,	button_row_1 + button_gap_y, button_width, button_height)
lable_btn_1_3 = txt_add("LNAV", button_lable_style, button_col_1 + 2* button_width + 2* button_gap_x,  	button_row_1 + button_gap_y, button_width, button_height)
lable_btn_1_4 = txt_add("VOR LOC", button_lable_style, button_col_1 + 3* button_width + 3* button_gap_x,	button_row_1 + button_gap_y, button_width, button_height)
lable_btn_1_5 = txt_add("ALT HLD", button_lable_style, button_col_1 + 4* button_width + 4* button_gap_x,  	button_row_1 + button_gap_y, button_width, button_height)
lable_btn_1_6 = txt_add("CMD-A", button_lable_style, button_col_1 + 5* button_width + 5* button_gap_x,	button_row_1 + button_gap_y, button_width, button_height)
lable_btn_1_7 = txt_add("CMD-B", button_lable_style, button_col_1 + 6* button_width + 6* button_gap_x,	button_row_1 + button_gap_y, button_width, button_height)
	 
lable_btn_2_1 = txt_add("N1", button_lable_style, button_col_1,                                    	button_row_1 + button_height + 2* button_gap_y, button_width, button_height, callback_btn_2_1)
lable_btn_2_2 = txt_add("LVL CHG", button_lable_style, button_col_1 + 1* button_width + 1* button_gap_x,	button_row_1 + button_height + 2* button_gap_y, button_width, button_height, callback_btn_2_2)
lable_btn_2_3 = txt_add("HDG SEL", button_lable_style, button_col_1 + 2* button_width + 2* button_gap_x,  	button_row_1 + button_height + 2* button_gap_y, button_width, button_height, callback_btn_2_3)
lable_btn_2_4 = txt_add("APP", button_lable_style, button_col_1 + 3* button_width + 3* button_gap_x,	button_row_1 + button_height + 2* button_gap_y, button_width, button_height, callback_btn_2_4)
lable_btn_2_5 = txt_add("VS", button_lable_style, button_col_1 + 4* button_width + 4* button_gap_x,  	button_row_1 + button_height + 2* button_gap_y, button_width, button_height, callback_btn_2_5)
lable_btn_2_6 = txt_add("CWS-A", button_lable_style, button_col_1 + 5* button_width + 5* button_gap_x,	button_row_1 + button_height + 2* button_gap_y, button_width, button_height, callback_btn_2_6)
lable_btn_2_7 = txt_add("CWS-B", button_lable_style, button_col_1 + 6* button_width + 6* button_gap_x,	button_row_1 + button_height + 2* button_gap_y, button_width, button_height, callback_btn_2_7)

--add outer dials
dial_outer_1_1 = dial_add("knob_sm.png", knob_col_1, knob_row_1, knob_width, knob_height, callback_outer_knob_turn_1_1)
dial_outer_1_2 = dial_add("knob_sm.png", knob_col_2, knob_row_1, knob_width, knob_height, callback_outer_knob_turn_1_2)
dial_outer_1_3 = dial_add("knob_sm.png", knob_col_3, knob_row_1, knob_width, knob_height, callback_outer_knob_turn_1_3)
dial_outer_1_4 = dial_add("knob_sm.png", knob_col_4, knob_row_1, knob_width, knob_height, callback_outer_knob_turn_1_4)
	
dial_outer_2_1 = dial_add("knob_sm.png", knob_col_1, knob_row_1  + 1* knob_height + 1* knob_gap_y, 	knob_width, knob_height, 		callback_outer_knob_turn_2_1)
dial_outer_2_2 = dial_add("knob_sm.png", knob_col_2, knob_row_1 	+ 1* knob_height + 1* knob_gap_y, 	knob_width, knob_height, 	callback_outer_knob_turn_2_2)
dial_outer_2_3 = dial_add("knob_sm.png", knob_col_3, knob_row_1	+ 1* knob_height + 1* knob_gap_y,	knob_width, knob_height, 		callback_outer_knob_turn_2_3)
dial_outer_2_4 = dial_add("knob_sm.png", knob_col_4, knob_row_1	+ 1* knob_height + 1* knob_gap_y,	knob_width, knob_height, 		callback_outer_knob_turn_2_4)
						
dial_outer_3_1 = dial_add("knob_sm.png", knob_col_1, knob_row_1  + 2* knob_height + 2* knob_gap_y,	knob_width, knob_height, 		callback_outer_knob_turn_3_1)
dial_outer_3_2 = dial_add("knob_sm.png", knob_col_2, knob_row_1 	+ 2* knob_height + 2* knob_gap_y, 	knob_width, knob_height, 	callback_outer_knob_turn_3_2)
dial_outer_3_3 = dial_add("knob_sm.png", knob_col_3, knob_row_1	+ 2* knob_height + 2* knob_gap_y,	knob_width, knob_height, 		callback_outer_knob_turn_3_3)
dial_outer_3_4 = dial_add("knob_sm.png", knob_col_4, knob_row_1	+ 2* knob_height + 2* knob_gap_y,	knob_width, knob_height, 		callback_outer_knob_turn_3_4)
						
dial_outer_4_1 = dial_add("knob_sm.png", knob_col_1, knob_row_1	+ 3* knob_height + 3* knob_gap_y, 	knob_width, knob_height, 		callback_outer_knob_turn_4_1)
dial_outer_4_2 = dial_add("knob_sm.png", knob_col_2, knob_row_1 	+ 3* knob_height + 3* knob_gap_y, 	knob_width, knob_height, 	callback_outer_knob_turn_4_2)
dial_outer_4_3 = dial_add("knob_sm.png", knob_col_3, knob_row_1	+ 3* knob_height + 3* knob_gap_y,	knob_width, knob_height, 		callback_outer_knob_turn_4_3)
dial_outer_4_4 = dial_add("knob_sm.png", knob_col_4, knob_row_1	+ 3* knob_height + 3* knob_gap_y,	knob_width, knob_height, 		callback_outer_knob_turn_4_4)

--add inner dials
dial_inner_1_1 = dial_add("knob_sm.png", knob_col_1 + 0.075*knob_width, knob_row_1 + 0.075*knob_height, 										0.85*knob_width, 0.85*knob_height, callback_inner_knob_turn_1_1)
dial_inner_1_2 = dial_add("knob_sm.png", knob_col_2 + 0.075*knob_width, knob_row_1 + 0.075*knob_height, 										0.85*knob_width, 0.85*knob_height, callback_inner_knob_turn_1_2)
dial_inner_1_3 = dial_add("knob_sm.png", knob_col_3 + 0.075*knob_width, knob_row_1 + 0.075*knob_height, 										0.85*knob_width, 0.85*knob_height, callback_inner_knob_turn_1_3)
dial_inner_1_4 = dial_add("knob_sm.png", knob_col_4 + 0.075*knob_width, knob_row_1 + 0.075*knob_height, 										0.85*knob_width, 0.85*knob_height, callback_inner_knob_turn_1_4)
																																																
dial_inner_2_1 = dial_add("knob_sm.png", knob_col_1 + 0.075*knob_width, knob_row_1 + 0.075*knob_height + 1* knob_height + 1* knob_gap_y, 		0.85*knob_width, 0.85*knob_height, 		callback_inner_knob_turn_2_1)
dial_inner_2_2 = dial_add("knob_sm.png", knob_col_2 + 0.075*knob_width, knob_row_1 + 0.075*knob_height + 1* knob_height + 1* knob_gap_y, 		0.85*knob_width, 0.85*knob_height, 		callback_inner_knob_turn_2_2)
dial_inner_2_3 = dial_add("knob_sm.png", knob_col_3 + 0.075*knob_width, knob_row_1 + 0.075*knob_height	+ 1* knob_height + 1* knob_gap_y,		0.85*knob_width, 0.85*knob_height, 	callback_inner_knob_turn_2_3)
dial_inner_2_4 = dial_add("knob_sm.png", knob_col_4 + 0.075*knob_width, knob_row_1 + 0.075*knob_height	+ 1* knob_height + 1* knob_gap_y,		0.85*knob_width, 0.85*knob_height, 	callback_inner_knob_turn_2_4)
																																																
dial_inner_3_1 = dial_add("knob_sm.png", knob_col_1 + 0.075*knob_width, knob_row_1 + 0.075*knob_height + 2* knob_height + 2* knob_gap_y,		0.85*knob_width, 0.85*knob_height, 		callback_inner_knob_turn_3_1)
dial_inner_3_2 = dial_add("knob_sm.png", knob_col_2 + 0.075*knob_width, knob_row_1 + 0.075*knob_height + 2* knob_height + 2* knob_gap_y, 		0.85*knob_width, 0.85*knob_height, 		callback_inner_knob_turn_3_2)
dial_inner_3_3 = dial_add("knob_sm.png", knob_col_3 + 0.075*knob_width, knob_row_1 + 0.075*knob_height	+ 2* knob_height + 2* knob_gap_y,		0.85*knob_width, 0.85*knob_height, 	callback_inner_knob_turn_3_3)
dial_inner_3_4 = dial_add("knob_sm.png", knob_col_4 + 0.075*knob_width, knob_row_1 + 0.075*knob_height	+ 2* knob_height + 2* knob_gap_y,		0.85*knob_width, 0.85*knob_height, 	callback_inner_knob_turn_3_4)
																																																
dial_inner_4_1 = dial_add("knob_sm.png", knob_col_1 + 0.075*knob_width, knob_row_1 + 0.075*knob_height	+ 3* knob_height + 3* knob_gap_y, 		0.85*knob_width, 0.85*knob_height, 	callback_inner_knob_turn_4_1)
dial_inner_4_2 = dial_add("knob_sm.png", knob_col_2 + 0.075*knob_width, knob_row_1 + 0.075*knob_height + 3* knob_height + 3* knob_gap_y, 		0.85*knob_width, 0.85*knob_height, 		callback_inner_knob_turn_4_2)
dial_inner_4_3 = dial_add("knob_sm.png", knob_col_3 + 0.075*knob_width, knob_row_1 + 0.075*knob_height	+ 3* knob_height + 3* knob_gap_y,		0.85*knob_width, 0.85*knob_height, 	callback_inner_knob_turn_4_3)
dial_inner_4_4 = dial_add("knob_sm.png", knob_col_4 + 0.075*knob_width, knob_row_1 + 0.075*knob_height	+ 3* knob_height + 3* knob_gap_y,		0.85*knob_width, 0.85*knob_height, 	callback_inner_knob_turn_4_4)

--add knob pushbuttons
push_button_dial_1_1 = button_add(nil,nil, knob_col_1 + 0.125*knob_width, knob_row_1 + 0.125*knob_height, 										0.75*knob_width, 0.75*knob_height, 	callback_knob_press_1_1)
push_button_dial_1_2 = button_add(nil,nil, knob_col_2 + 0.125*knob_width, knob_row_1 + 0.125*knob_height, 										0.75*knob_width, 0.75*knob_height, 	callback_knob_press_1_2)
push_button_dial_1_3 = button_add(nil,nil, knob_col_3 + 0.125*knob_width, knob_row_1 + 0.125*knob_height, 										0.75*knob_width, 0.75*knob_height, 	callback_knob_press_1_3)
push_button_dial_1_4 = button_add(nil,nil, knob_col_4 + 0.125*knob_width, knob_row_1 + 0.125*knob_height, 										0.75*knob_width, 0.75*knob_height, 	callback_knob_press_1_4)
								  
push_button_dial_2_1 = button_add(nil,nil, knob_col_1 + 0.125*knob_width, knob_row_1 + 0.125*knob_height + 1* knob_height + 1* knob_gap_y, 	0.75*knob_width, 0.75*knob_height, 		callback_knob_press_2_1)
push_button_dial_2_2 = button_add(nil,nil, knob_col_2 + 0.125*knob_width, knob_row_1 + 0.125*knob_height + 1* knob_height + 1* knob_gap_y, 	0.75*knob_width, 0.75*knob_height, 		callback_knob_press_2_2)
push_button_dial_2_3 = button_add(nil,nil, knob_col_3 + 0.125*knob_width, knob_row_1 + 0.125*knob_height	+ 1* knob_height + 1* knob_gap_y,	0.75*knob_width, 0.75*knob_height, 	callback_knob_press_2_3)
push_button_dial_2_4 = button_add(nil,nil, knob_col_4 + 0.125*knob_width, knob_row_1 + 0.125*knob_height	+ 1* knob_height + 1* knob_gap_y,	0.75*knob_width, 0.75*knob_height, 	callback_knob_press_2_4)
								  
push_button_dial_3_1 = button_add(nil,nil, knob_col_1 + 0.125*knob_width, knob_row_1 + 0.125*knob_height + 2* knob_height + 2* knob_gap_y,	0.75*knob_width, 0.75*knob_height, 		callback_knob_press_3_1)
push_button_dial_3_2 = button_add(nil,nil, knob_col_2 + 0.125*knob_width, knob_row_1 + 0.125*knob_height + 2* knob_height + 2* knob_gap_y, 	0.75*knob_width, 0.75*knob_height, 		callback_knob_press_3_2)
push_button_dial_3_3 = button_add(nil,nil, knob_col_3 + 0.125*knob_width, knob_row_1 + 0.125*knob_height	+ 2* knob_height + 2* knob_gap_y,	0.75*knob_width, 0.75*knob_height, 	callback_knob_press_3_3)
push_button_dial_3_4 = button_add(nil,nil, knob_col_4 + 0.125*knob_width, knob_row_1 + 0.125*knob_height	+ 2* knob_height + 2* knob_gap_y,	0.75*knob_width, 0.75*knob_height, 	callback_knob_press_3_4)
								  
push_button_dial_4_1 = button_add(nil,nil, knob_col_1 + 0.125*knob_width, knob_row_1 + 0.125*knob_height	+ 3* knob_height + 3* knob_gap_y, 	0.75*knob_width, 0.75*knob_height, 	callback_knob_press_4_1)
push_button_dial_4_2 = button_add(nil,nil, knob_col_2 + 0.125*knob_width, knob_row_1 + 0.125*knob_height + 3* knob_height + 3* knob_gap_y, 	0.75*knob_width, 0.75*knob_height, 		callback_knob_press_4_2)
push_button_dial_4_3 = button_add(nil,nil, knob_col_3 + 0.125*knob_width, knob_row_1 + 0.125*knob_height	+ 3* knob_height + 3* knob_gap_y,	0.75*knob_width, 0.75*knob_height, 	callback_knob_press_4_3)
push_button_dial_4_4 = button_add(nil,nil, knob_col_4 + 0.125*knob_width, knob_row_1 + 0.125*knob_height	+ 3* knob_height + 3* knob_gap_y,	0.75*knob_width, 0.75*knob_height, 	callback_knob_press_4_4)

--add dial lables overlay
lable_dial_1_1 = txt_add("ALT", knob_lable_style, knob_col_1, knob_row_1, knob_width, knob_height)
lable_dial_1_2 = txt_add("CRS1", knob_lable_style, knob_col_2, knob_row_1, knob_width, knob_height)
lable_dial_1_3 = txt_add("ADF1", knob_lable_style, knob_col_3, knob_row_1, knob_width, knob_height)
lable_dial_1_4 = txt_add("COM1", knob_lable_style, knob_col_4, knob_row_1, knob_width, knob_height)
								
lable_dial_2_1 = txt_add("HDG", knob_lable_style, knob_col_1, knob_row_1  + 1* knob_height + 1* knob_gap_y, 	knob_width, knob_height)
lable_dial_2_2 = txt_add("CRS2", knob_lable_style, knob_col_2, knob_row_1 	+ 1* knob_height + 1* knob_gap_y, 	knob_width, knob_height)
lable_dial_2_3 = txt_add("ADF2", knob_lable_style, knob_col_3, knob_row_1	+ 1* knob_height + 1* knob_gap_y,	knob_width, knob_height)
lable_dial_2_4 = txt_add("COM2", knob_lable_style, knob_col_4, knob_row_1	+ 1* knob_height + 1* knob_gap_y,	knob_width, knob_height)
								
lable_dial_3_1 = txt_add("IAS", knob_lable_style, knob_col_1, knob_row_1  + 2* knob_height + 2* knob_gap_y,	knob_width, knob_height)
lable_dial_3_2 = txt_add("INOP", knob_lable_style_inop, knob_col_2, knob_row_1 	+ 2* knob_height + 2* knob_gap_y, 	knob_width, knob_height)
lable_dial_3_3 = txt_add("INOP", knob_lable_style_inop, knob_col_3, knob_row_1	+ 2* knob_height + 2* knob_gap_y,	knob_width, knob_height)
lable_dial_3_4 = txt_add("NAV1", knob_lable_style, knob_col_4, knob_row_1	+ 2* knob_height + 2* knob_gap_y,	knob_width, knob_height)
								
lable_dial_4_1 = txt_add("VS", knob_lable_style, knob_col_1, knob_row_1	+ 3* knob_height + 3* knob_gap_y, 	knob_width, knob_height)
lable_dial_4_2 = txt_add("INOP", knob_lable_style_inop, knob_col_2, knob_row_1 	+ 3* knob_height + 3* knob_gap_y, 	knob_width, knob_height)
lable_dial_4_3 = txt_add("XPDR", knob_lable_style, knob_col_3, knob_row_1	+ 3* knob_height + 3* knob_gap_y,	knob_width, knob_height)
lable_dial_4_4 = txt_add("NAV2", knob_lable_style, knob_col_4, knob_row_1	+ 3* knob_height + 3* knob_gap_y,	knob_width, knob_height)

--add value boxes
value_1_1 = img_add("value_box.png", knob_col_1 + value_text_offset_x	, knob_row_1, value_text_width, value_text_height)
value_1_2 = img_add("value_box.png", knob_col_2 + value_text_offset_x	, knob_row_1, value_text_width, value_text_height)
value_1_3 = img_add("value_box.png", knob_col_3 - 1.9* value_text_offset_x, knob_row_1, value_text_width, value_text_height)
value_1_4 = img_add("value_box.png", knob_col_4 - 1.9* value_text_offset_x, knob_row_1, value_text_width, value_text_height)

value_2_1 = img_add("value_box.png", knob_col_1 + value_text_offset_x	, knob_row_1	+ 1* knob_height + 1* knob_gap_y, 	value_text_width, value_text_height)
value_2_2 = img_add("value_box.png", knob_col_2 + value_text_offset_x	, knob_row_1 + 1* knob_height + 1* knob_gap_y, 	value_text_width, value_text_height)
value_2_3 = img_add("value_box.png", knob_col_3 - 1.9* value_text_offset_x, knob_row_1	+ 1* knob_height + 1* knob_gap_y,	value_text_width, value_text_height)
value_2_4 = img_add("value_box.png", knob_col_4 - 1.9* value_text_offset_x, knob_row_1	+ 1* knob_height + 1* knob_gap_y,	value_text_width, value_text_height)

value_3_1 = img_add("value_box.png", knob_col_1 + value_text_offset_x	, knob_row_1 + 2* knob_height + 2* knob_gap_y,	value_text_width, value_text_height)
value_3_2 = img_add("value_box.png", knob_col_2 + value_text_offset_x	, knob_row_1 + 2* knob_height + 2* knob_gap_y, 	value_text_width, value_text_height)
value_3_3 = img_add("value_box.png", knob_col_3 - 1.9* value_text_offset_x, knob_row_1	+ 2* knob_height + 2* knob_gap_y,	value_text_width, value_text_height)
value_3_4 = img_add("value_box.png", knob_col_4 - 1.9* value_text_offset_x, knob_row_1	+ 2* knob_height + 2* knob_gap_y,	value_text_width, value_text_height)
	 
value_4_1 = img_add("value_box.png", knob_col_1 + value_text_offset_x	, knob_row_1 + 3* knob_height + 3* knob_gap_y,	value_text_width, value_text_height)
value_4_2 = img_add("value_box.png", knob_col_2 + value_text_offset_x	, knob_row_1 + 3* knob_height + 3* knob_gap_y, 	value_text_width, value_text_height)
value_4_3 = img_add("value_box.png", knob_col_3 - 1.9* value_text_offset_x, knob_row_1	+ 3* knob_height + 3* knob_gap_y,	value_text_width, value_text_height)
value_4_4 = img_add("value_box.png", knob_col_4 - 1.9* value_text_offset_x, knob_row_1	+ 3* knob_height + 3* knob_gap_y,	value_text_width, value_text_height)

--add value bar for misc annuniciators

info_bar = img_add("misc_ann_bar.png", info_bar_x,info_bar_y, info_bar_width,info_bar_height)

--add movig dot for XPDR digit selector
xpdr_active_digit_dot = img_add("xpdr_active_digit_dot.png", xpdr_dot_pos_0_x, xpdr_dot_pos_y, xpdr_knob_diameter, xpdr_knob_diameter) 


--add value text boxes
value_1_1 = txt_add("38000", 		value_text_style, 		knob_col_1 + value_text_offset_x							, knob_row_1, value_text_width, value_text_height)
value_1_2 = txt_add("42", 			value_text_style, 		knob_col_2 + value_text_offset_x							, knob_row_1, value_text_width, value_text_height)
value_1_3_act = txt_add("348", 		value_text_style_act, 	knob_col_3 - 1.9* value_text_offset_x						, knob_row_1, value_text_width, 0.5*value_text_height)
value_1_3_stby = txt_add("348", 	value_text_style_stby, 	knob_col_3 - 1.9* value_text_offset_x						, knob_row_1+0.5*value_text_height, value_text_width, 0.5*value_text_height)
value_1_4_act = txt_add("123.456", 	value_text_style_act, 	knob_col_4 - 1.9* value_text_offset_x						, knob_row_1, value_text_width, 0.5*value_text_height)
value_1_4_stby = txt_add("123.456", value_text_style_stby, 	knob_col_4 - 1.9* value_text_offset_x						, knob_row_1+0.5*value_text_height, value_text_width, 0.5*value_text_height)
					
value_2_1 = txt_add("122", 			value_text_style, 		knob_col_1 + value_text_offset_x							, knob_row_1	+ 1* knob_height + 1* knob_gap_y, 	value_text_width, value_text_height)
value_2_2 = txt_add("41", 			value_text_style, 		knob_col_2 + value_text_offset_x							, knob_row_1  	+ 1* knob_height + 1* knob_gap_y, 	value_text_width, value_text_height)
value_2_3_act = txt_add("183", 		value_text_style_act, 	knob_col_3 - 1.9* value_text_offset_x						, knob_row_1	+ 1* knob_height + 1* knob_gap_y, 	value_text_width, 0.5*value_text_height)
value_2_3_stby = txt_add("134", 	value_text_style_stby, 	knob_col_3 - 1.9* value_text_offset_x						, knob_row_1	+ 1* knob_height + 1* knob_gap_y +0.5*value_text_height, value_text_width, 0.5*value_text_height)
value_2_4_act = txt_add("123.456", 	value_text_style_act, 	knob_col_4 - 1.9* value_text_offset_x						, knob_row_1	+ 1* knob_height + 1* knob_gap_y,	value_text_width, 0.5*value_text_height)
value_2_4_stby = txt_add("123.456", value_text_style_stby, 	knob_col_4 - 1.9* value_text_offset_x						, knob_row_1	+ 1* knob_height + 1* knob_gap_y +0.5*value_text_height,	value_text_width, 0.5*value_text_height)
					
value_3_1 = txt_add("135", 			value_text_style, 		knob_col_1 + value_text_offset_x							, knob_row_1  	+ 2* knob_height + 2* knob_gap_y,	value_text_width, value_text_height)
value_3_2 = txt_add("INOP", 		value_text_style_inop, 	knob_col_2 + value_text_offset_x							, knob_row_1 	+ 2* knob_height + 2* knob_gap_y, 	value_text_width, value_text_height)
value_3_3 = txt_add("INOP", 		value_text_style_inop,	knob_col_3 - 1.9* value_text_offset_x						, knob_row_1	+ 2* knob_height + 2* knob_gap_y,	value_text_width, value_text_height)
value_3_4_act = txt_add("118.095", 	value_text_style_act, 	knob_col_4 - 1.9* value_text_offset_x						, knob_row_1	+ 2* knob_height + 2* knob_gap_y,	value_text_width, 0.5*value_text_height)
value_3_4_stby = txt_add("118.095", value_text_style_stby, 	knob_col_4 - 1.9* value_text_offset_x						, knob_row_1	+ 2* knob_height + 2* knob_gap_y +0.5*value_text_height,	value_text_width, 0.5*value_text_height)
					
value_4_1 = txt_add("-1200", 		value_text_style, 		knob_col_1 + value_text_offset_x							, knob_row_1	+ 3* knob_height + 3* knob_gap_y, 	value_text_width, value_text_height)
value_4_2 = txt_add("INOP", 		value_text_style_inop, 	knob_col_2 + value_text_offset_x							, knob_row_1 	+ 3* knob_height + 3* knob_gap_y, 	value_text_width, value_text_height)
value_4_3 = txt_add("2204", 		value_text_style_act, 	knob_col_3 - 1.9* value_text_offset_x						, knob_row_1	+ 3* knob_height + 3* knob_gap_y,	value_text_width, 0.5*value_text_height)
value_4_3_sub1 = txt_add("MODE", 	value_text_style_sub, 	knob_col_3 - 1.9* value_text_offset_x						, knob_row_1	+ 3* knob_height + 3* knob_gap_y + 0.5*value_text_height ,	0.5*value_text_width, 0.5*value_text_height)
value_4_3_sub2 = txt_add("IDENT", 	value_text_style_sub, 	knob_col_3 - 1.9* value_text_offset_x+0.5*value_text_width	, knob_row_1	+ 3* knob_height + 3* knob_gap_y + 0.5*value_text_height,	0.5*value_text_width, 0.5*value_text_height)
value_4_4_act = txt_add("118.095", 	value_text_style_act, 	knob_col_4 - 1.9* value_text_offset_x						, knob_row_1	+ 3* knob_height + 3* knob_gap_y,	value_text_width, 0.5*value_text_height)
value_4_4_stby = txt_add("118.095", value_text_style_stby, 	knob_col_4 - 1.9* value_text_offset_x						, knob_row_1	+ 3* knob_height + 3* knob_gap_y +0.5*value_text_height,	value_text_width, 0.5*value_text_height)

--add info bar text boxes

value_info_bar_1 = txt_add("UTC: 07:13:22",	info_bar_txt_style_static, knob_col_1 , info_bar_y, value_text_width + value_text_offset_x + knob_width, info_bar_height)
value_info_bar_2 = txt_add("FLIGHT DIRs OFF",	info_bar_txt_style_inactive, knob_col_2 , info_bar_y, value_text_width + value_text_offset_x + knob_width, info_bar_height)
value_info_bar_3 = txt_add("AUTO THR DISARM",	info_bar_txt_style_inactive, knob_col_3 - 1.9* value_text_offset_x - knob_width , info_bar_y, value_text_width + value_text_offset_x + knob_width, info_bar_height)
value_info_bar_4 = txt_add("BARO 1013 | 29.91",	info_bar_txt_style_static, knob_col_4 - 1.9* value_text_offset_x - knob_width , info_bar_y, value_text_width + value_text_offset_x + knob_width, info_bar_height)

--dataref callback setters

function ap_modes (speed, vnav, lnav, vorloc, althld, cmda, cmdb, n1, lvlchg, hdgsel, app, vs, cwsa, cwsb)

	if speed 	== 1.0 then visible(btn_dots_green_1_1, true) else visible(btn_dots_green_1_1, false) end
	if vnav 	== 1.0 then visible(btn_dots_green_1_2, true) else visible(btn_dots_green_1_2, false) end
	if lnav 	== 1.0 then visible(btn_dots_green_1_3, true) else visible(btn_dots_green_1_3, false) end
	if vorloc 	== 1.0 then visible(btn_dots_green_1_4, true) else visible(btn_dots_green_1_4, false) end
	if althld 	== 1.0 then visible(btn_dots_green_1_5, true) else visible(btn_dots_green_1_5, false) end
	if cmda 	== 1.0 then visible(btn_dots_green_1_6, true) else visible(btn_dots_green_1_6, false) end
	if cmdb 	== 1.0 then visible(btn_dots_green_1_7, true) else visible(btn_dots_green_1_7, false) end
	if n1 		== 1.0 then visible(btn_dots_green_2_1, true) else visible(btn_dots_green_2_1, false) end
	if lvlchg 	== 1.0 then visible(btn_dots_green_2_2, true) else visible(btn_dots_green_2_2, false) end
	if hdgsel 	== 1.0 then visible(btn_dots_green_2_3, true) else visible(btn_dots_green_2_3, false) end
	if app 		== 1.0 then visible(btn_dots_green_2_4, true) else visible(btn_dots_green_2_4, false) end
	if vs 		== 1.0 then visible(btn_dots_green_2_5, true) else visible(btn_dots_green_2_5, false) end
	if cwsa 	== 1.0 then visible(btn_dots_green_2_6, true) else visible(btn_dots_green_2_6, false) end
	if cwsb 	== 1.0 then visible(btn_dots_green_2_7, true) else visible(btn_dots_green_2_7, false) end

end

function instrument_values (alt, crs1, adf1, adf1_stby, com1, com1_stby, hdg, crs2, adf2, adf2_stby, com2, com2_stby, ias, nav1, nav1_stby, vs, xpdr_code, xpdr_mode,xpdr_ident, nav2, nav2_stby)

	txt_set(value_1_1, 		string.format("%03.0f", 	alt))
	txt_set(value_1_2, 		string.format("%03.0f", 	crs1))
	txt_set(value_1_3_act, 	string.format("%05.01f", 	adf1))
	txt_set(value_1_3_stby, string.format("%05.01f", 	adf1_stby))
	txt_set(value_2_3_act, 	string.format("%05.01f", 	adf2))
	txt_set(value_2_3_stby, string.format("%05.01f", 	adf2_stby))
	txt_set(value_1_4_act, 	string.format("%06.03f", 	com1 / 1000))
	txt_set(value_1_4_stby, string.format("%06.03f", 	com1_stby / 1000))
	txt_set(value_2_1, 		string.format("%03.0f", 	hdg))
	txt_set(value_2_2, 		string.format("%03.0f", 	crs2))
	txt_set(value_2_4_act, 	string.format("%06.03f",	com2 / 1000))
	txt_set(value_2_4_stby, string.format("%06.03f", 	com2_stby / 1000))	
	txt_set(value_3_1, 		string.format("%.0f", 		ias)) --todo: integrate Overspeed Indicator
	txt_set(value_3_4_act, 	string.format("%06.03f", 	nav1 / 100))
	txt_set(value_3_4_stby, string.format("%06.03f", 	nav1_stby / 100))
	
	--add VS assignment string
	if vs == 0 then
		txt_set(value_4_1, "     ")
	else	
		if vs<0 then
			vs_val = string.format("%4d",vs*(-1.0))
			vs_txt = "- " .. vs_val
			txt_set(value_4_1, vs_txt)
		else
			vs_val = string.format("%4d",vs)
			vs_txt = "+ " .. vs_val
			txt_set(value_4_1, vs_txt)
		end
	end
	
	txt_set(value_4_3, string.format("%04.0f", xpdr_code))
	
	--display readable text for xpdr mode
	
	if xpdr_mode == 1.0 then txt_set(value_4_3_sub1, "STBY") end
	if xpdr_mode == 2.0 then txt_set(value_4_3_sub1, "ALT OFF") end
	if xpdr_mode == 3.0 then txt_set(value_4_3_sub1, "ALT ON") end
	if xpdr_mode == 4.0 then txt_set(value_4_3_sub1, "TA") end 
	if xpdr_mode == 5.0 then txt_set(value_4_3_sub1, "TA/RA") end 
	
	--Ident annunciator	
	if xpdr_ident == 1 then txt_style(value_4_3_sub2 , "color: green;") end
	if xpdr_ident == 0 then txt_style(value_4_3_sub2 , "color: white;") end
	
	txt_set(value_4_4_act, string.format("%06.03f", nav2 / 100))
	txt_set(value_4_4_stby, string.format("%06.03f", nav2_stby / 100))
	
end

function info_bar_values (utc_hh, utc_mm, utc_ss, fd_cpt, fd_fo, athr_armed, baro_inch)

	--Zulu Time Annunciator
	txt_set(value_info_bar_1, "UTC: " .. utc_hh .. ":" .. utc_mm .. ":" .. utc_ss)
	
	--Flight Director Annunciator
	if (fd_cpt == 1.0 and fd_fo == 1.0) then
		txt_set(value_info_bar_2, "FLIGHT DIRs ON")
		txt_style(value_info_bar_2, "color: green")
	end
	
	if (fd_cpt == 0.0 and fd_fo == 0.0) then
		txt_set(value_info_bar_2, "FLIGHT DIRs OFF")
		txt_style(value_info_bar_2, "color: #3A3B3C")
	end
	
	--Auto Throttle Annunciator
	if athr_armed == 1.0 then
		txt_set(value_info_bar_3, "AUTO THR ARMED")
		txt_style(value_info_bar_3, "color: green")
	end
	
	if athr_armed == 0.0 then
		txt_set(value_info_bar_3, "AUTO THR DISARM")
		txt_style(value_info_bar_3, "color: #3A3B3C")
	end
	
	--BARO pressure Annunciator
	
	txt_set(value_info_bar_4, string.format("%4.0f",33.865*baro_inch) .. " hpa | " .. string.format("%4.2f",baro_inch) .. " inch")
	
	

end
	
-- xplane dataref subscribe	
xpl_dataref_subscribe("laminar/B738/autopilot/speed_status1","INT",		--1.1 SPEED
					  "laminar/B738/autopilot/vnav_status1","INT",		--1.2 VNAV
					  "laminar/B738/autopilot/lnav_status","INT",		--1.3 LNAV
					  "laminar/B738/autopilot/vorloc_status","INT",		--1.4 VOR LOC
					  "laminar/B738/autopilot/alt_hld_status","INT",	--1.5 ALT HLD
					  "laminar/B738/autopilot/cmd_a_status","INT",		--1.6 CMD-A
					  "laminar/B738/autopilot/cmd_b_status","INT",		--1.7 CMD-B
					  "laminar/B738/autopilot/n1_status","INT",			--2.1 N1
					  "laminar/B738/autopilot/lvl_chg_status","INT",	--2.2 LVL CHG
					  "laminar/B738/autopilot/hdg_sel_status","INT",	--2.3 HDG SEL
					  "laminar/B738/autopilot/app_status","INT",		--2.4 APP
					  "laminar/B738/autopilot/vs_status","INT",			--2.5 VS
					  "laminar/B738/autopilot/cws_a_status","INT",		--2.6 CWS-A
					  "laminar/B738/autopilot/cws_b_status","INT",		--2.7 CWS-B
ap_modes)

xpl_dataref_subscribe("laminar/B738/autopilot/mcp_alt_dial","FLOAT",							--1.1 ALT
					  "laminar/radios/pilot/nav_obs","FLOAT",									--1.2 CRS1
					  "sim/cockpit/radios/adf1_freq_hz","INT",									--1.3 ADF1 (active)
					  "sim/cockpit/radios/adf1_stdby_freq_hz","INT",							--1.3 ADF1 (standby)
					  "sim/cockpit2/radios/actuators/com1_frequency_hz_833","INT",				--1.4 COM1 (active)
					  "sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833","INT",		--1.4 COM1 (standby)
					  "laminar/B738/autopilot/mcp_hdg_dial","FLOAT",							--2.1 HDG
					  "laminar/radios/copilot/nav_obs","FLOAT",									--2.2 CRS2
					  "sim/cockpit/radios/adf2_freq_hz","INT",									--2.3 ADF2 (active)
					  "sim/cockpit/radios/adf2_stdby_freq_hz","INT",							--2.3 ADF2 (standby)
					  "sim/cockpit2/radios/actuators/com2_frequency_hz_833","INT",				--2.4 COM2 (active)
					  "sim/cockpit2/radios/actuators/com2_standby_frequency_hz_833","INT",		--2.4 COM2 (standby)
					  "laminar/B738/autopilot/mcp_speed_dial_kts","FLOAT",								--3.1 IAS
				--	  "sim/XXX/XXX","FLOAT",													--3.2 INOP
				--	  "sim/XXX/XXX","FLOAT",													--3.3 DME
					  "sim/cockpit/radios/nav1_freq_hz","INT",									--3.4 NAV1 (active)
					  "sim/cockpit/radios/nav1_stdby_freq_hz","INT",							--3.4 NAV1 (standby)
					  "laminar/B738/autopilot/ap_vvi_pos","FLOAT",								--4.1 VS
				--	  "sim/XXX/XXX","FLOAT",													--4.2 INOP
					  "sim/cockpit/radios/transponder_code","INT",								--4.3 XPDR (code)
					  "laminar/B738/knob/transponder_pos","FLOAT",								--4.3 XPDR (mode)
					  "sim/cockpit/radios/transponder_id","INT",								--4.3 XPDR (ident)
					  "sim/cockpit/radios/nav2_freq_hz","INT",									--4.4 NAV2 (active)
					  "sim/cockpit/radios/nav2_stdby_freq_hz","INT",							--4.4 NAV2 (standby)
instrument_values)

xpl_dataref_subscribe("sim/cockpit2/clock_timer/zulu_time_hours","INT",			--UTC HH
					  "sim/cockpit2/clock_timer/zulu_time_minutes","INT",		--UTC MM
					  "sim/cockpit2/clock_timer/zulu_time_seconds","INT",		--UTC SS
					  "laminar/B738/autopilot/flight_director_pos","FLOAT",		--FD Pilot
					  "laminar/B738/autopilot/flight_director_fo_pos","FLOAT",	--FD CoPilot
					  "laminar/B738/autopilot/autothrottle_arm_pos","FLOAT",	--ATHR armed
					  "laminar/B738/EFIS/baro_sel_in_hg_pilot","FLOAT",			--BARO in
info_bar_values)

