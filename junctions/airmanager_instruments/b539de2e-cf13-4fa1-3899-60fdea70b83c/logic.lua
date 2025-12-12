-- Generic Annunciator (rectangle shape)

-- Setup
background_frame = img_add_fullscreen("annunciator_frame_black.png")

local has_two_text_lines = user_prop_add_boolean("Second Text Line", true, "Does the annunciator show two text lines?")
local line_1_text = user_prop_add_string("First Line Text", "SPEED BRAKE", "The first line of text displayed by the annunciator.")
local line_2_text = user_prop_add_string("Second Line Text", "DO NOT ARM", "The second line of text displayed by the annunciator.")
local announciator_dataref_name = user_prop_add_string("Simulator Source Data Name", "laminar/B738/annunciator/spd_brk_not_arm", "The simulator data field to read annunciator status from.")
local announciator_dataref_type = user_prop_add_enum("Simulator Source Data Type", "float,int","float","The data type of the simulators annunciator status.")
local announciator_dataref_active_color = user_prop_add_enum("Active Annunciator Color", "red,green,yellow,white,aliceblue,orange","red","The color the annunciator is illuminated by.")
local font_size = user_prop_add_integer("Text Font Size", 10,50,18, "The font size of displayed text (between 10 and 50)")

if user_prop_get(announciator_dataref_active_color) == "red" then backgroud_image_active = img_add_fullscreen("annunciator_frame_active_red.png") end
if user_prop_get(announciator_dataref_active_color) == "aliceblue" then backgroud_image_active = img_add_fullscreen("annunciator_frame_active_blue.png") end
if user_prop_get(announciator_dataref_active_color) == "green" then backgroud_image_active = img_add_fullscreen("annunciator_frame_active_green.png") end
if user_prop_get(announciator_dataref_active_color) == "white" then backgroud_image_active = img_add_fullscreen("annunciator_frame_active_white.png") end
if user_prop_get(announciator_dataref_active_color) == "orange" then backgroud_image_active = img_add_fullscreen("annunciator_frame_active_amber.png") end
if user_prop_get(announciator_dataref_active_color) == "yellow" then backgroud_image_active = img_add_fullscreen("annunciator_frame_active_yellow.png") end
visible(backgroud_image_active,false)

local txt_style_two_lines_inactive = "font: roboto_bold.ttf; halign:center; size:" .. user_prop_get(font_size) .."; color: #101010;"
local txt_style_one_line_inactive = "font: roboto_bold.ttf; halign:center; valign:center; size:" .. user_prop_get(font_size) .."; color: #101010;"
local txt_style_two_lines_active = "font: roboto_bold.ttf; halign:center; size:" .. user_prop_get(font_size) .."; color: " .. user_prop_get(announciator_dataref_active_color)
local txt_style_one_line_active = "font: roboto_bold.ttf; halign:center; valign:center; size:" .. user_prop_get(font_size) .."; color: " .. user_prop_get(announciator_dataref_active_color)

-- initial display of inactive annunciator
if user_prop_get(has_two_text_lines) == true then 
	line_1 = txt_add(user_prop_get(line_1_text), txt_style_two_lines_inactive , 0,instrument_prop("HEIGHT")*0.15,instrument_prop("WIDTH"),instrument_prop("HEIGHT")/2)
	line_2 = txt_add(user_prop_get(line_2_text), txt_style_two_lines_inactive , 0,instrument_prop("HEIGHT")/2,instrument_prop("WIDTH"),instrument_prop("HEIGHT")/2)

end

if user_prop_get(has_two_text_lines) == false then 
	line = txt_add(user_prop_get(line_1_text), txt_style_one_line_inactive , 0, 0, instrument_prop("WIDTH"), instrument_prop("HEIGHT"))
end

-- Callback functions depending on annunciator data type

function ann_value_float_callback(ann_value)

	if user_prop_get(has_two_text_lines) == true then 

		if ann_value == 0.0 then
			visible(backgroud_image_active,false)
			txt_style(line_1, txt_style_two_lines_inactive)
			txt_style(line_2, txt_style_two_lines_inactive)
		end
		
		if ann_value > 0.0 then
			visible(backgroud_image_active,true)
			txt_style(line_1, txt_style_two_lines_active)
			txt_style(line_2, txt_style_two_lines_active)
		end
	end

	if user_prop_get(has_two_text_lines) == false then 
		
		if ann_value == 0.0 then
			txt_style(line, txt_style_one_line_inactive)
		end
		
		if ann_value > 0.0 then
			txt_style(line, txt_style_one_line_active)	
		end
	end

end

function ann_value_int_callback(ann_value)

	if user_prop_get(has_two_text_lines) == true then 

		if ann_value == 0 then
			txt_style(line_1, txt_style_two_lines_inactive)
			txt_style(line_2, txt_style_two_lines_inactive)
		end
		
		if ann_value > 0 then
			txt_style(line_1, txt_style_two_lines_active)
			txt_style(line_2, txt_style_two_lines_active)
		end
	end

	if user_prop_get(has_two_text_lines) == false then 
		
		if ann_value == 0 then
			txt_style(line, txt_style_one_line_inactive)
		end
		
		if ann_value > 0 then
			txt_style(line, txt_style_one_line_active)	
		end
	end

end


-- Simulator data subscription
if user_prop_get(announciator_dataref_type) == "float" then

	xpl_dataref_subscribe(user_prop_get(announciator_dataref_name), "FLOAT", ann_value_float_callback)

end

if user_prop_get(announciator_dataref_type) == "int" then

	xpl_dataref_subscribe(user_prop_get(announciator_dataref_name), "INT", ann_value_int_callback)

end

