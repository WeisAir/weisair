-- user properties definitions

local prop_value_dataref = user_prop_add_string("Value Dataref", "sim/none/none", "the dataref providing the value displayed")
local prop_value_datatype = user_prop_add_enum("Dataref Type", "float,int,double,string","float", "the value dataref data type")
local prop_value_format_string = user_prop_add_string("Dataref String Format", "%05.01f", "the format string to display the dataref value properly")
local prop_value_color = user_prop_add_enum("Text Color", "green,red,yellow,white,blue, cyan","cyan", "the color the value is displayed in")
local prop_use_divider = user_prop_add_boolean("Use value divider", false, "Should a divider be applied to the dataref value? Can be helpful for displaying decimals in frequencies with only one dataref provided")
local prop_show_description = user_prop_add_boolean("Show Value Description", true, "Add a value description, e.g. title")
local prop_value_description = user_prop_add_string("Value description", "ENG 1 Temp (°C)", "a description explaining the shown value")
local prop_use_divider_value = user_prop_add_integer("Value divider", 1,10000,1000, "the divider value the dataref value is divided by")
local prop_background = user_prop_add_boolean("show background", true, "add a background the displayed value")

if(user_prop_get(prop_background) == true) then
my_image = img_add_fullscreen("value_plate.png")
end


--geometry and style settings

local instrument_height = 300
local instrument_width = 720

local value_text_width = instrument_width
local value_text_height = instrument_height
local value_text_x = -4
local value_text_y = 0
local description_offset_top = 20
local value_text_style = "font: digital-7-mono.ttf; size:150; color: " .. user_prop_get(prop_value_color) .. "; halign:center; valign:center"
local value_description_text_style = "font: arimo_bold.ttf; size:60; color: white; halign:center; valign:top"

--add value text boxes
value_text = txt_add("123.456", value_text_style,value_text_x, value_text_y + description_offset_top, value_text_width, value_text_height)

--add description textbox
if(user_prop_get(prop_show_description) == true) then
    description_text = txt_add("ENG 1 Temp (°C)", value_description_text_style, 0, description_offset_top, value_text_width, value_text_height)
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
