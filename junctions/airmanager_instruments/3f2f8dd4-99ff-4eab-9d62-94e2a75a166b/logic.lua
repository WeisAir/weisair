my_image = img_add_fullscreen("background.png")

-- user properties definitions
---- dials

local prop_lable_dial = user_prop_add_string("Dial Lable", "BARO", "The lable printed on the dial")
local prop_command_dial_outer_clockwise = user_prop_add_string("Command (outer dial clockwise)", "laminar/B738/EFIS_control/cpt/minimums_up", "The command to be fired if the outer dial is turned clockwise.")
local prop_command_dial_outer_counterclockwise = user_prop_add_string("Command (outer dial counterclockwise)", "laminar/B738/EFIS_control/cpt/minimums_dn", "The command to be fired if the outer dial is turned counterclockwise.")
local prop_command_dial_inner_clockwise = user_prop_add_string("Command (inner dial clockwise)", "laminar/B738/pfd/dh_pilot_up", "The command to be fired if the inner dial is turned clockwise.")
local prop_command_dial_inner_counterclockwise = user_prop_add_string("Command (inner dial counterclockwise)", "laminar/B738/pfd/dh_pilot_dn", "The command to be fired if the inner dial is turned counterclockwise.")
local prop_command_dial_push_btn = user_prop_add_string("Command for Dial Push Button", "laminar/B738/EFIS_control/capt/push_button/rst_press", "Command fired if the dial push button is pressed.")

----cosmetics
local prop_screws = user_prop_add_boolean("Show screws", true, "Show the screws")

----value display

local prop_dataref_mins_switch = user_prop_add_string("Radio/Baro Switch", "laminar/B738/EFIS_control/cpt/minimums", "the dataref that reflects the current mins mode")
local prop_dataref_mins_value_baro = user_prop_add_string("Mins (baro) value", "laminar/B738/pfd/dh_pilot", "barometric mins value")
local prop_dataref_mins_value_radio = user_prop_add_string("Mins (radio) value", "laminar/B738/pfd/dh_pilot", "radio mins value")
local prop_dataref_mins_switch_datatype = user_prop_add_enum("Mins Switch datatype", "float,int,double,string","double", "Mins Switch datatype")
local prop_dataref_mins_baro_datatype = user_prop_add_enum("Mins (baro) value datatype", "float,int,double,string","float", "Mins value datatype")
local prop_dataref_mins_radio_datatype = user_prop_add_enum("Mins (radio) value datatype", "float,int,double,string","float", "Mins value datatype")

local prop_mins_baro_value_format_string = user_prop_add_string("Mins (Baro) String Format", "%03.0f", "the format string to display the dataref value properly")
local prop_mins_radio_value_format_string = user_prop_add_string("Mins (Radio) String Format", "%03.0f", "the format string to display the dataref value properly")

local prop_value_color = user_prop_add_enum("Text Color", "green,red,yellow,white","green", "the color the value is displayed in")

--geometry and style settings
----instrument
local instrument_height = 110    
local instrument_width = 300

----knob
local knob_outer_width = 100	
local knob_outer_height = 100
local knob_inner_width = 80
local knob_inner_height = 80
local knob_outer_x = 0
local knob_outer_y = (instrument_height - knob_outer_height)*0.5
local knob_inner_x = knob_outer_x + (knob_outer_width -knob_inner_width)*0.5
local knob_inner_y = (instrument_height - knob_inner_height)*0.5
local knob_push_button_width = knob_inner_width*0.75 
local knob_push_button_height = knob_inner_height*0.75
local knob_push_button_x = (knob_inner_width-knob_push_button_width)*0.5 + knob_inner_x
local knob_push_button_y = (knob_inner_height-knob_push_button_height)*0.5 + knob_inner_y

----screws
local screw_width = 15
local screw_height = 15
local screw_border_offset = 3

----value display
local value_text_width = 161
local value_text_height = 40
local value_text_x = 113
local value_text_y = 45
--local value_text_style = "font: digital-7-mono.ttf; size:40; color: " .. user_prop_get(prop_value_color) .. "; halign:center; valign:center; background_color:white"
local value_text_style = "font: digital-7-mono.ttf; size:40; color: " .. user_prop_get(prop_value_color) .. "; halign:center; valign:center;"
----value display lable
local display_lable_style = "font: arimo_bold.ttf; size:25; color: white; halign:center; valign:center;"
local display_lable_x = value_text_x
local display_lable_y = value_text_y - 40
local display_lable_width = value_text_width
local display_lable_height = value_text_height

-- callback functions
---- dual dial

function callback_outer_knob_turn(direction)
	if direction == 1 then
		xpl_command(user_prop_get(prop_command_dial_outer_clockwise))
	elseif direction == -1 then
		xpl_command(user_prop_get(prop_command_dial_outer_counterclockwise))
	end
end

function callback_inner_knob_turn(direction)
	if direction == 1 then
		xpl_command(user_prop_get(prop_command_dial_inner_clockwise))
	elseif direction == -1 then
		xpl_command(user_prop_get(prop_command_dial_inner_counterclockwise))
	end
end

function callback_knob_press()
	xpl_command(user_prop_get(prop_command_dial_push_btn))
end

function value_dataref(mins_switch, mins_value_baro, mins_value_radio)
        
	if mins_switch == 1.0 then
	    txt_set(lable_dial,"MINS (BARO)") 
	    txt_set(value_text, string.format(user_prop_get(prop_mins_baro_value_format_string), mins_value_baro))
	end
		
	if mins_switch == 0.0 then 
	    txt_set(lable_dial,"MINS (Radio)") 
	    txt_set(value_text, string.format(user_prop_get(prop_mins_radio_value_format_string), mins_value_radio))
	end
	
	

end

--add UI Elements
----value text boxes
value_text = txt_add("100", value_text_style,value_text_x, value_text_y, value_text_width, value_text_height)

----dials
dial_outer = dial_add("mcp_knob.png", knob_outer_x, knob_outer_y, knob_outer_width, knob_outer_height, callback_outer_knob_turn)
dial_inner = dial_add("mcp_knob.png", knob_inner_x, knob_inner_y, knob_inner_width, knob_inner_height, callback_inner_knob_turn)

----knob pushbuttons
push_button_dial = button_add(nil,nil, knob_push_button_x, knob_push_button_y,	knob_push_button_width, knob_push_button_height,  callback_knob_press)

----dial lables overlay
lable_dial = txt_add(user_prop_get(prop_lable_dial), display_lable_style, display_lable_x, display_lable_y, display_lable_width, display_lable_height)

----screws
screw_ul = img_add("screw.png", screw_border_offset, screw_border_offset, screw_width, screw_height)
screw_ll = img_add("screw.png", screw_border_offset, instrument_height - screw_border_offset - screw_height , screw_width, screw_height)
screw_ur = img_add("screw.png", instrument_width - screw_border_offset - screw_width, screw_border_offset, screw_width, screw_height)
screw_lr = img_add("screw.png", instrument_width - screw_border_offset - screw_width, instrument_height - screw_border_offset - screw_height, screw_width, screw_height)

--visibility settings
group_screws = group_add(screw_ul,screw_ll,screw_ur,screw_lr)
visible(group_screws,false)
if user_prop_get(prop_screws)==true then visible(group_screws,true) end
group_knob = group_add(dial_outer, dial_inner, push_button_dial, lable_dial)


--dataref subscription
xpl_dataref_subscribe(
user_prop_get(prop_dataref_mins_switch),user_prop_get(prop_dataref_mins_switch_datatype),
user_prop_get(prop_dataref_mins_value_baro),user_prop_get(prop_dataref_mins_baro_datatype),
user_prop_get(prop_dataref_mins_value_radio),user_prop_get(prop_dataref_mins_radio_datatype),
value_dataref)