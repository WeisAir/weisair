-- user properties definitions

local prop_command = user_prop_add_string("Command", "sim/none/none", "the command sent if the button is pressed")
--local prop_command_type = user_prop_add_enum("Command type", "once,begin,end","once", "the type of the command according to XPLANE docs")
local prop_lable_text = user_prop_add_string("Button Lable Text", "SYS", "the lable text printed on the button")

--geometry and style settings

local instrument_height = 57
local instrument_width = 112

local lable_text_width = instrument_width
local lable_text_height = instrument_height
local lable_text_x = 0
local lable_text_y = 0
local lable_text_style = "font: arimo_bold.ttf; size:27; color: white; halign:center; valign:center"

--add button
function pressed_callback()
  xpl_command(user_prop_get(prop_command),"BEGIN")
end

function released_callback()
  xpl_command(user_prop_get(prop_command),"END")
end

my_button = button_add("button.png", "button_pressed.png", 0, 0, instrument_width, instrument_height, pressed_callback, released_callback)


--add button lable text boxes
lable_text = txt_add(user_prop_get(prop_lable_text), lable_text_style,lable_text_x, lable_text_y, lable_text_width, lable_text_height)
