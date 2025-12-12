my_image = img_add_fullscreen("background.png")

-- user properties definitions
---- dials

local prop_lable_dial = user_prop_add_string("Dial Lable", "COM1", "The lable printed on the dial")
local prop_command_dial_outer_clockwise = user_prop_add_string("Command (outer dial clockwise)", "sim/radios/stby_com1_coarse_up", "The command to be fired if the outer dial is turned clockwise.")
local prop_command_dial_outer_counterclockwise = user_prop_add_string("Command (outer dial counterclockwise)", "sim/radios/stby_com1_coarse_down", "The command to be fired if the outer dial is turned counterclockwise.")
local prop_command_dial_inner_clockwise = user_prop_add_string("Command (inner dial clockwise)", "sim/radios/stby_com1_fine_up_833", "The command to be fired if the inner dial is turned clockwise.")
local prop_command_dial_inner_counterclockwise = user_prop_add_string("Command (inner dial counterclockwise)", "sim/radios/stby_com1_fine_down_833", "The command to be fired if the inner dial is turned counterclockwise.")
local prop_command_dial_push_btn = user_prop_add_string("Command for Dial Push Button", "sim/radios/com1_standy_flip", "Command fired if the dial push button is pressed.")

----cosmetics
local prop_screws = user_prop_add_boolean("Show screws", true, "Show the screws")

----value display
local prop_value_dataref_upper = user_prop_add_string("Value Dataref (upper display)", "sim/cockpit2/radios/actuators/com1_frequency_hz_833", "the dataref providing the upper value displayed")
local prop_value_dataref_lower = user_prop_add_string("Value Dataref (lower display)", "sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833", "the dataref providing the upper value displayed")
local prop_value_datatype = user_prop_add_enum("Dataref Type", "float,int,double,string","int", "the value dataref data type")
local prop_value_format_string = user_prop_add_string("Dataref String Format", "%06.03f", "the format string to display the dataref value properly")
local prop_value_color_upper = user_prop_add_enum("Text Color (upper display)", "green,red,yellow,white","green", "the color the value is displayed in the upper display")
local prop_value_color_lower = user_prop_add_enum("Text Color (lower display)", "green,red,yellow,white","red", "the color the value is displayed in the lower display")
local prop_use_divider = user_prop_add_boolean("Use value divider", true, "Should a divider be applied to the dataref value? Can be helpful for displaying decimals in frequencies with only one dataref provided")
local prop_use_divider_value = user_prop_add_integer("Value divider", 1,10000,1000, "the divider value the dataref value is divided by")

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

----value display (common params)
local value_text_width = 104
local value_text_height = 30
local value_text_x = 171

----value display (upper)
local value_text_y_upper = 10
--local value_text_style_upper = "font: digital-7-mono.ttf; size:27; color: " .. user_prop_get(prop_value_color) .. "; halign:center; valign:center; background_color:white"
local value_text_style_upper = "font: digital-7-mono.ttf; size:29; color: " .. user_prop_get(prop_value_color_upper) .. "; halign:center; valign:center;" 

----value display (lower)
local value_text_y_lower = 64
--local value_text_style = "font: digital-7-mono.ttf; size:27; color: " .. user_prop_get(prop_value_color) .. "; halign:center; valign:center; background_color:white"
local value_text_style_lower = "font: digital-7-mono.ttf; size:29; color: " .. user_prop_get(prop_value_color_lower) .. "; halign:center; valign:center;" 

----value display lable
local display_lable_style = "font: arimo_bold.ttf; size:22; color: white; halign:center; valign:center;"
local display_lable_x = 85
local display_lable_y = 38
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


----value text boxes
value_text_upper = txt_add("123.456", value_text_style_upper,value_text_x, value_text_y_upper, value_text_width, value_text_height)
value_text_lower = txt_add("123.456", value_text_style_lower,value_text_x, value_text_y_lower, value_text_width, value_text_height)

function callback_knob_press()
	xpl_command(user_prop_get(prop_command_dial_push_btn))
end

function value_dataref(dataref_current_value_upper, dataref_current_value_lower)
                
        if user_prop_get(prop_use_divider) == true
            then 
                dataref_current_value_upper = dataref_current_value_upper / user_prop_get(prop_use_divider_value)
                dataref_current_value_lower = dataref_current_value_lower / user_prop_get(prop_use_divider_value)
        end
       
	txt_set(value_text_upper, string.format(user_prop_get(prop_value_format_string), dataref_current_value_upper))
	txt_set(value_text_lower, string.format(user_prop_get(prop_value_format_string), dataref_current_value_lower))
	
		
end

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
    user_prop_get(prop_value_dataref_upper),user_prop_get(prop_value_datatype),
    user_prop_get(prop_value_dataref_lower),user_prop_get(prop_value_datatype),
    
    value_dataref)