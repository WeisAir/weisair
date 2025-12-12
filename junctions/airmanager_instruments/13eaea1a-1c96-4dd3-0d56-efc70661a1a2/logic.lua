background = img_add_fullscreen("background.png") 
local txt_style = "font: roboto_bold.ttf; valign:center; size: 12; color: white;"
local val_style = "font: roboto_bold.ttf; halign:right; valign:center; size: 14; color: yellow;"
txt_add("FLAPS POS:", txt_style, 5,0,112,28)
txt_add("AUTO BRAKES: ", txt_style, 5,28,112,28)

local flaps_value = txt_add("0", val_style, 0,-1,95,28)
local brakes_value = txt_add("OFF", val_style, 0,27,95,28)

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
	if brakes_pos == -1.0 	then txt_set(brakes_value, "RTO") end
	if brakes_pos == 0.0 	then txt_set(brakes_value, "OFF") end
	if brakes_pos == 1.0 	then txt_set(brakes_value, "1") end
	if brakes_pos == 2.0 	then txt_set(brakes_value, "2") end
	if brakes_pos == 3.0 	then txt_set(brakes_value, "3") end
	if brakes_pos == 4.0 	then txt_set(brakes_value, "MAX") end

end
xpl_dataref_subscribe ( "ixeg/733/hydraulics/hyd_auto_brake_act", "FLOAT",  
                        "ixeg/733/flaps_deploy_ratio", "FLOAT", brake_flaps_pos )

