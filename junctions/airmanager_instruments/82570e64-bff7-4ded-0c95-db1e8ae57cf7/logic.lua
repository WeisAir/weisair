local prop_screws = user_prop_add_boolean("Show screws", true, "Show the screws")

background = img_add_fullscreen("background.png") 
local txt_style = "font: roboto_bold.ttf; valign:center; size: 22; color: white;"
local val_style = "font: roboto_bold.ttf; halign:right; valign:center; size: 22; color: yellow;"
txt_add("FLAPS POS:", txt_style, 20,20,112,28)
txt_add("AUTO BRAKES: ", txt_style, 20,50,120,28)

local instrument_height = 100    
local instrument_width = 200

----screws settings
local screw_width = 15
local screw_height = 15
local screw_border_offset = 3

local flaps_value = txt_add("0", val_style, 90,20,95,28)
local brakes_value = txt_add("OFF", val_style, 90,50,95,28)

----screws images
screw_ul = img_add("screw.png", screw_border_offset, screw_border_offset, screw_width, screw_height)
screw_ll = img_add("screw.png", screw_border_offset, instrument_height - screw_border_offset - screw_height , screw_width, screw_height)
screw_ur = img_add("screw.png", instrument_width - screw_border_offset - screw_width, screw_border_offset, screw_width, screw_height)
screw_lr = img_add("screw.png", instrument_width - screw_border_offset - screw_width, instrument_height - screw_border_offset - screw_height, screw_width, screw_height)

--screws visibility settings
group_screws = group_add(screw_ul,screw_ll,screw_ur,screw_lr)
visible(group_screws,false)
if user_prop_get(prop_screws)==true then visible(group_screws,true) end

function brake_flaps_pos (brakes_pos, flaps_pos)

-- flaps
	if flaps_pos == 0.0 	then txt_set(flaps_value, "0") end
	if flaps_pos == 0.125 	then txt_set(flaps_value, "1") end
	if flaps_pos == 0.25 	then txt_set(flaps_value, "2") end
	if flaps_pos == 0.375 	then txt_set(flaps_value, "5") end
	if flaps_pos == 0.5 	then txt_set(flaps_value, "10") end
	if flaps_pos == 0.625 	then txt_set(flaps_value, "15") end
	if flaps_pos == 0.75 	then txt_set(flaps_value, "25") end
	if flaps_pos == 0.875 	then txt_set(flaps_value, "30") end
	if flaps_pos == 1.0 	then txt_set(flaps_value, "40") end

-- brakes
	if brakes_pos == 0.0 	then txt_set(brakes_value, "RTO") end
	if brakes_pos == 1.0 	then txt_set(brakes_value, "OFF") end
	if brakes_pos == 2.0 	then txt_set(brakes_value, "1") end
	if brakes_pos == 3.0 	then txt_set(brakes_value, "2") end
	if brakes_pos == 4.0 	then txt_set(brakes_value, "3") end
	if brakes_pos == 5.0 	then txt_set(brakes_value, "MAX") end

end
xpl_dataref_subscribe ( "laminar/B738/autobrake/autobrake_pos", "FLOAT",  
                        "sim/flightmodel2/controls/flap_handle_deploy_ratio", "FLOAT", brake_flaps_pos )

