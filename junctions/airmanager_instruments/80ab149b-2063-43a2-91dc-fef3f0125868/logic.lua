-- user properties definitions
-- dials

local prop_knob_position = user_prop_add_enum("Dial Position", "left,right","left","The position of the dial knob. By Default the knob is on the left side, the value box is on the right side")
local prop_lable_dial = user_prop_add_string("Dial Lable", "XXX", "The lable printed on the dial")
local prop_command_dial_outer_clockwise = user_prop_add_string("Command (outer dial clockwise)", "sim/none/none", "The command to be fired if the outer dial is turned clockwise.")
local prop_command_dial_outer_counterclockwise = user_prop_add_string("Command (outer dial counterclockwise)", "sim/none/none", "The command to be fired if the outer dial is turned counterclockwise.")
local prop_command_dial_inner_clockwise = user_prop_add_string("Command (inner dial clockwise)", "sim/none/none", "The command to be fired if the inner dial is turned clockwise.")
local prop_command_dial_inner_counterclockwise = user_prop_add_string("Command (inner dial counterclockwise)", "sim/none/none", "The command to be fired if the inner dial is turned counterclockwise.")
local prop_command_dial_push_btn = user_prop_add_string("Command for Dial Push Button", "sim/none/none", "Command fired if the dial push button is pressed.")
local prop_value_dataref = user_prop_add_string("Value Dataref", "sim/none/none", "the dataref providing the value displayed")
local prop_value_datatype = user_prop_add_enum("Dataref Type", "float,int,double,string","float", "the value dataref data type")
local prop_value_format_string = user_prop_add_string("Dataref String Format", "%05.01f", "the format string to display the dataref value properly")
local prop_use_divider = user_prop_add_boolean("Use value divider", false, "Should a divider be applied to the dataref value? Can be helpful for displaying decimals in frequencies with only one dataref provided")
local prop_use_divider_value = user_prop_add_integer("Value divider", 1,10000,1000, "the divider value the dataref value is divided by")

--instrument dims: 80px x 220px

--geometry and style settings

--local instrument_height = instrument_prop(HEIGHT)
--local instrument_width = instrument_prop(WIDTH)

local instrument_height = 80
local instrument_width = 220

local knob_outer_width = 67	
local knob_outer_height = 67
local knob_inner_width = 57
local knob_inner_height = 57
local knob_outer_x = 10
local knob_outer_y = (instrument_height - knob_outer_height)*0.5
local knob_inner_x = knob_outer_x + (knob_outer_width -knob_inner_width)*0.5
local knob_inner_y = (instrument_height - knob_inner_height)*0.5
local knob_lable_style = "font: arimo_bold.ttf; size:20; color: white; halign:center; valign:center;"
local knob_lable_x = knob_inner_x
local knob_lable_y = knob_inner_y
local knob_lable_width = knob_inner_width
local knob_lable_height = knob_inner_height

local knob_push_button_width = 30 
local knob_push_button_height = 30
local knob_push_button_x = 20
local knob_push_button_y = 20

local value_text_width = instrument_width - (knob_outer_width + 3*knob_outer_x)
local value_text_height = knob_outer_height
local value_text_x = knob_outer_width + 2*knob_outer_x
local value_text_y = knob_outer_y
local value_text_style = "font: digital-7-mono.ttf; size:27; color: green; halign:center; valign:center"

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
dial_outer = dial_add("knob_sm.png", knob_outer_x, knob_outer_y, knob_outer_width, knob_outer_height, callback_outer_knob_turn)
dial_inner = dial_add("knob_sm.png", knob_inner_x, knob_inner_y, knob_inner_width, knob_inner_height, callback_inner_knob_turn)

--add knob pushbuttons
push_button_dial = button_add(nil,nil, knob_push_button_x, knob_push_button_y,	knob_push_button_width, knob_push_button_height,  callback_knob_press)

--add dial lables overlay
lable_dial = txt_add(user_prop_get(prop_lable_dial), knob_lable_style, knob_lable_x, knob_lable_y, knob_lable_width, knob_lable_height)

--add value boxes
value_box = img_add("value_box.png", value_text_x, value_text_y, value_text_width, value_text_height)

--add value text boxes
value_text = txt_add("12345678", value_text_style,value_text_x, value_text_y, value_text_width, value_text_height)

--dataref callback setters


group_knob = group_add(dial_outer, dial_inner, push_button_dial, lable_dial)
group_value_box = group_add(value_box,value_text)

if user_prop_get(prop_knob_position) == "right" then

	move(group_knob,2*knob_outer_x + value_text_width)
	move(group_value_box, knob_outer_x)

end


function value_dataref(dataref_current_value)
        
       -- print(user_prop_get(prop_value_dataref))
       -- print(user_prop_get(prop_value_format_string))
       -- print(user_prop_get(prop_value_datatype))
       -- print(dataref_current_value)
        
        if user_prop_get(prop_use_divider) == true
            then dataref_current_value = dataref_current_value / user_prop_get(prop_use_divider_value)
        end
       
	txt_set(value_text, string.format(user_prop_get(prop_value_format_string), dataref_current_value))
	--txt_set(value_text, string.format("%06.03f", dataref_current_value))
		
end

--dataref callback subscribe

xpl_dataref_subscribe(user_prop_get(prop_value_dataref),user_prop_get(prop_value_datatype),value_dataref)
