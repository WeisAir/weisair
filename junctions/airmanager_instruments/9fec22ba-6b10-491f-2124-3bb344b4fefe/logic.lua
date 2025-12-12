local prop_value_dataref_xpdr_code	= user_prop_add_string("XPDR Code Dataref ", "sim/cockpit2/radios/actuators/transponder_code", "the dataref that represents the set xpdr code")
local prop_value_dataref_xpdr_mode	= user_prop_add_string("XPDR Mode Dataref ", "sim/cockpit2/radios/actuators/transponder_mode", "the dataref that represents the set xpdr mode")
local prop_value_dataref_xpdr_ident = user_prop_add_string("XPDR Ident Dataref", "sim/cockpit/radios/transponder_id", "the dataref that represents whether IDENT is selected")

local prop_value_xpdr_code_datatype = user_prop_add_enum("XPDR Code Dataref Type", "float,int,double,string","int", "the data type for the XPDR Code dataref")
local prop_value_xpdr_code_datatype = user_prop_add_enum("XPDR Mode Dataref Type", "float,int,double,string","int", "the data type for the XPDR Code dataref")
local prop_value_xpdr_code_datatype = user_prop_add_enum("XPDR Ident Dataref Type", "float,int,double,string","int", "the data type for the XPDR Code dataref")

local prop_command_dial_push_btn = user_prop_add_string("IDENT Command", "sim/radios/transponder_ident", "IDENT Command to send XPDR code.")
local prop_screws = user_prop_add_boolean("Show screws", true, "Show the screws")

my_image = img_add_fullscreen("background.png")

--geometry and style settings

local instrument_height = 110    
local instrument_width = 300

local knob_outer_width = 100	
local knob_outer_height = 100
local knob_inner_width = 80
local knob_inner_height = 80
local knob_outer_x = 0
local knob_outer_y = (instrument_height - knob_outer_height)*0.5
local knob_inner_x = knob_outer_x + (knob_outer_width -knob_inner_width)*0.5
local knob_inner_y = (instrument_height - knob_inner_height)*0.5

local display_lable_style = "font: arimo_bold.ttf; size:30; color: white; halign:center; valign:center;"
local display_lable_x = 2
local display_lable_y = -18
local display_lable_width = instrument_width
local display_lable_height = instrument_height + 1

local knob_push_button_width = knob_inner_width*0.75 
local knob_push_button_height = knob_inner_height*0.75
local knob_push_button_x = (knob_inner_width-knob_push_button_width)*0.5 + knob_inner_x
local knob_push_button_y = (knob_inner_height-knob_push_button_height)*0.5 + knob_inner_y

local xpdr_value_text_style = "font: digital-7-mono.ttf; size:35; color: green; halign:center; valign:center;"

local xpdr_dot_pos_y = 83
local xpdr_dot_pos_0_x = 173
local xpdr_dot_pos_1_x = 156
local xpdr_dot_pos_2_x = 137
local xpdr_dot_pos_3_x = 119
local xpdr_knob_diameter = 10

----screws
local screw_width = 15
local screw_height = 15
local screw_border_offset = 3

-- used data variables
local xpdr_selected_digit = 0

txt_xprd_code = txt_add("2204",xpdr_value_text_style,114,51,70,30)
txt_xpdr_mode = txt_add("ALT OFF",xpdr_value_text_style,205,27,70,20)
txt_xprd_idnt = txt_add("IDENT",xpdr_value_text_style,205,60,70,20)
txt_style(txt_xpdr_mode , "size:20;")
txt_style(txt_xprd_idnt , "size:25;")

-- dual dial callback functions

function callback_outer_knob_turn(direction)
	--XPDR select digit
	--FN+ => maybe toggle XPDR modes
	
	xpdr_selected_digit = xpdr_selected_digit - direction
	xpdr_selected_digit_current = var_cap(xpdr_selected_digit,-1,3)
	
	if xpdr_selected_digit_current > -1 then
	    visible(xpdr_mode_selector, false)
            visible(xpdr_active_digit_dot, true)
        end
							
	if xpdr_selected_digit_current == 0 then move(xpdr_active_digit_dot,xpdr_dot_pos_0_x) end		
	if xpdr_selected_digit_current == 1 then move(xpdr_active_digit_dot,xpdr_dot_pos_1_x) end
	if xpdr_selected_digit_current == 2 then move(xpdr_active_digit_dot,xpdr_dot_pos_2_x) end
	if xpdr_selected_digit_current == 3 then move(xpdr_active_digit_dot,xpdr_dot_pos_3_x) end	
        
        if xpdr_selected_digit_current == -1 then 
            --hop over to mode delector
            visible(xpdr_mode_selector, true)
            visible(xpdr_active_digit_dot, false)
        end

	xpdr_selected_digit = xpdr_selected_digit_current
	print(xpdr_selected_digit)
end

function callback_inner_knob_turn(direction)
	--XPDR select 0..7 per digit
	
	if direction == 1 then 
		
		if xpdr_selected_digit == -1 then xpl_command("laminar/B738/knob/transponder_mode_up") end
		if xpdr_selected_digit == 0 then xpl_command("sim/transponder/transponder_ones_up") end
		if xpdr_selected_digit == 1 then xpl_command("sim/transponder/transponder_tens_up") end
		if xpdr_selected_digit == 2 then xpl_command("sim/transponder/transponder_hundreds_up") end
		if xpdr_selected_digit == 3 then xpl_command("sim/transponder/transponder_thousands_up") end

	end
	
	if direction == -1 then
		
		if xpdr_selected_digit == -1 then xpl_command("laminar/B738/knob/transponder_mode_dn") end
		if xpdr_selected_digit == 0 then xpl_command("sim/transponder/transponder_ones_down") end
		if xpdr_selected_digit == 1 then xpl_command("sim/transponder/transponder_tens_down") end
		if xpdr_selected_digit == 2 then xpl_command("sim/transponder/transponder_hundreds_down") end
		if xpdr_selected_digit == 3 then xpl_command("sim/transponder/transponder_thousands_down") end
		
	end
end

function callback_knob_press()
	--XPDR ident
	xpl_command(user_prop_get(prop_command_dial_push_btn))
	
end

function xpdr_values (xpdr_code, xpdr_mode,xpdr_ident)

	txt_set(txt_xprd_code, string.format("%04.0f", xpdr_code))
	
	--display readable text for xpdr mode
	
	if xpdr_mode == 1.0 then txt_set(txt_xpdr_mode, "STBY") end
	if xpdr_mode == 2.0 then txt_set(txt_xpdr_mode, "ALT OFF") end
	if xpdr_mode == 3.0 then txt_set(txt_xpdr_mode, "ALT ON") end
	if xpdr_mode == 4.0 then txt_set(txt_xpdr_mode, "TA") end 
	if xpdr_mode == 5.0 then txt_set(txt_xpdr_mode, "TA/RA") end 
	
	--Ident annunciator	
	if xpdr_ident == 1 then txt_style(txt_xprd_idnt , "color: green;") end
	if xpdr_ident == 0 then txt_style(txt_xprd_idnt , "color: white;") end
	
end

--add dials
dial_outer = dial_add("mcp_knob.png", knob_outer_x, knob_outer_y, knob_outer_width, knob_outer_height, callback_outer_knob_turn)
dial_inner = dial_add("mcp_knob.png", knob_inner_x, knob_inner_y, knob_inner_width, knob_inner_height, callback_inner_knob_turn)

--add knob pushbuttons
push_button_dial = button_add(nil,nil, knob_push_button_x, knob_push_button_y,	knob_push_button_width, knob_push_button_height,  callback_knob_press)

--add dial lables overlay
lable_dial = txt_add("XPDR", display_lable_style, display_lable_x, display_lable_y, display_lable_width, display_lable_height)

--xpdr active dot
xpdr_active_digit_dot = img_add("xpdr_active_digit_dot.png",xpdr_dot_pos_0_x,xpdr_dot_pos_y,xpdr_knob_diameter,xpdr_knob_diameter)
xpdr_mode_selector = img_add("xpdr_active_digit_dot.png",205,50,70,xpdr_knob_diameter*0.5)
visible(xpdr_mode_selector, false)

----screws
screw_ul = img_add("screw.png", screw_border_offset, screw_border_offset, screw_width, screw_height)
screw_ll = img_add("screw.png", screw_border_offset, instrument_height - screw_border_offset - screw_height , screw_width, screw_height)
screw_ur = img_add("screw.png", instrument_width - screw_border_offset - screw_width, screw_border_offset, screw_width, screw_height)
screw_lr = img_add("screw.png", instrument_width - screw_border_offset - screw_width, instrument_height - screw_border_offset - screw_height, screw_width, screw_height)

--visibility settings
group_screws = group_add(screw_ul,screw_ll,screw_ur,screw_lr)
visible(group_screws,false)
if user_prop_get(prop_screws)==true then visible(group_screws,true) end


--dataref callback setters
group_knob = group_add(dial_outer, dial_inner, push_button_dial, lable_dial)

--dataref subscription
xpl_dataref_subscribe(
    user_prop_get(prop_value_dataref_xpdr_code),user_prop_get(prop_value_xpdr_code_datatype),
    user_prop_get(prop_value_dataref_xpdr_mode),user_prop_get(prop_value_xpdr_mode_datatype),
    user_prop_get(prop_value_dataref_xpdr_ident),user_prop_get(prop_value_xpdr_ident_datatype),
    xpdr_values)