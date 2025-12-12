-- user properties definitions
-- dials

local prop_lable_dial = user_prop_add_string("Dial Lable", "XXX", "The lable printed on the dial")
local prop_command_dial_outer_clockwise = user_prop_add_string("Command (outer dial clockwise)", "sim/none/none", "The command to be fired if the outer dial is turned clockwise.")
local prop_command_dial_outer_counterclockwise = user_prop_add_string("Command (outer dial counterclockwise)", "sim/none/none", "The command to be fired if the outer dial is turned counterclockwise.")
local prop_command_dial_inner_clockwise = user_prop_add_string("Command (inner dial clockwise)", "sim/none/none", "The command to be fired if the inner dial is turned clockwise.")
local prop_command_dial_inner_counterclockwise = user_prop_add_string("Command (inner dial counterclockwise)", "sim/none/none", "The command to be fired if the inner dial is turned counterclockwise.")
local prop_command_dial_push_btn = user_prop_add_string("Command for Dial Push Button", "sim/none/none", "Command fired if the dial push button is pressed.")

--instrument dims: 140x73

--geometry and style settings

local instrument_height = 79    
local instrument_width = 140

local knob_outer_width = 79	
local knob_outer_height = 79
local knob_inner_width = 56
local knob_inner_height = 56
local knob_outer_x = instrument_width
local knob_outer_y = (instrument_height - knob_outer_height)*0.5
local knob_inner_x = knob_outer_x + (knob_outer_width -knob_inner_width)*0.5
local knob_inner_y = (instrument_height - knob_inner_height)*0.5
local knob_lable_style = "font: arimo_bold.ttf; size:25; color: white; halign:right; valign:center;"
--local knob_lable_style = "font: arimo_bold.ttf; size:25; color: white; halign:right; valign:center; background_color:black"
local knob_lable_x = 0
local knob_lable_y = 0
local knob_lable_width = instrument_width
local knob_lable_height = instrument_height + 1

local knob_push_button_width = knob_inner_width*0.75 
local knob_push_button_height = knob_inner_height*0.75
local knob_push_button_x = (knob_inner_width-knob_push_button_width)*0.5 + knob_inner_x
local knob_push_button_y = (knob_inner_height-knob_push_button_height)*0.5 + knob_inner_y



-- dual dial callback functions

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

--add dials
dial_outer = dial_add("mcp_knob.png", knob_outer_x, knob_outer_y, knob_outer_width, knob_outer_height, callback_outer_knob_turn)
dial_inner = dial_add("mcp_knob.png", knob_inner_x, knob_inner_y, knob_inner_width, knob_inner_height, callback_inner_knob_turn)

--add knob pushbuttons
push_button_dial = button_add(nil,nil, knob_push_button_x, knob_push_button_y,	knob_push_button_width, knob_push_button_height,  callback_knob_press)

--add dial lables overlay
lable_dial = txt_add(user_prop_get(prop_lable_dial), knob_lable_style, knob_lable_x, knob_lable_y, knob_lable_width, knob_lable_height)

--dataref callback setters

group_knob = group_add(dial_outer, dial_inner, push_button_dial, lable_dial)
