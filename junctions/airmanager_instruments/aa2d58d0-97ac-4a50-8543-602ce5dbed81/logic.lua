my_image = img_add_fullscreen("background_rect.png")
local add_frame = user_prop_add_boolean("Add Frame to Annunciator", true, "Shows a tiny frame around the annunciator on demand.")
local add_lable = user_prop_add_boolean("Add Lable to Annunciator", false, "Shows a text lable to the annunciator on demand.")
local lable_pos = user_prop_add_enum("Lable Position", "top,bottom,left,right","top","The position of the lable next to the annunciator.")
local lable_text = user_prop_add_string("Lable Text", "L CTR", "The lable name next to the annunciator")
local announciator_dataref_name = user_prop_add_string("Simulator Source Data Name", "laminar/B738/annunciator/spar1_valve_closed", "The simulator data field to read annunciator status from.")
local announciator_dataref_type = user_prop_add_enum("Simulator Source Data Type", "float,int","float","The data type of the simulators annunciator status.")

local lable_txt_style = "font: roboto_bold.ttf; halign:center; valign:center; size: 15; color: white;"

-- send otional command by click
local click_command = user_prop_add_string("Click Command", "", "A Command that is sent to the sim if the annunciator is clicked")
function callback_btn()	xpl_command(user_prop_get(click_command)) end
if user_prop_get(click_command) ~= "" then btn = button_add(nil,nil,0,0,136,65, callback_btn) end

if user_prop_get(add_lable) == true then
	if user_prop_get(lable_pos) == "top" then 
		annunciator_inactive = img_add("ann_inactive.png",0,20,91,45)
		annunciator_active = img_add("ann_active.png",0,20,91,45)
		txt_add(user_prop_get(lable_text), lable_txt_style, 0,0,91,20)
	end
	
	if user_prop_get(lable_pos) == "bottom" then 
		annunciator_inactive = img_add("ann_inactive.png",0,0,91,45)
		annunciator_active = img_add("ann_active.png",0,0,91,45)
		txt_add(user_prop_get(lable_text), lable_txt_style, 0,45,91,20)
	end
	
	if user_prop_get(lable_pos) == "left" then 
		annunciator_inactive = img_add("ann_inactive.png",45,0,91,45)
		annunciator_active = img_add("ann_active.png",45,0,91,45)
		txt_add(user_prop_get(lable_text), lable_txt_style, 0,0,45,45)
	end
	
	if user_prop_get(lable_pos) == "right" then 
		annunciator_inactive = img_add("ann_inactive.png",0,0,91,45)
		annunciator_active = img_add("ann_active.png",0,0,91,45)
		txt_add(user_prop_get(lable_text), lable_txt_style, 91,0,45,45)
	end
	
else 
	if user_prop_get(add_frame) == true then
	    annunciator_inactive = img_add("ann_inactive.png",3,3,129,59) 
	    annunciator_active = img_add("ann_active.png",3,3,129,59) 
	else
	    annunciator_inactive = img_add_fullscreen("ann_inactive.png") 
	    annunciator_active = img_add_fullscreen("ann_active.png")
	end 
end

visible(annunciator_active,false)

-- Callback functions depending on annunciator data type

function ann_value_float_callback(ann_value)

	if ann_value == 0.0 then
		visible(annunciator_inactive,true)
		visible(annunciator_active,false)
	end
	
	if ann_value > 0.0 then
		visible(annunciator_inactive,false)
		visible(annunciator_active,true)
	end
end

function ann_value_int_callback(ann_value)

	if ann_value == 0 then
		visible(annunciator_inactive,true)
		visible(annunciator_active,false)
	end
	
	if ann_value > 0 then
		visible(annunciator_inactive,false)
		visible(annunciator_active,true)
	end
end

-- Simulator data subscription
if user_prop_get(announciator_dataref_type) == "float" then

	xpl_dataref_subscribe(user_prop_get(announciator_dataref_name), "FLOAT", ann_value_float_callback)

end

if user_prop_get(announciator_dataref_type) == "int" then

	xpl_dataref_subscribe(user_prop_get(announciator_dataref_name), "INT", ann_value_int_callback)

end