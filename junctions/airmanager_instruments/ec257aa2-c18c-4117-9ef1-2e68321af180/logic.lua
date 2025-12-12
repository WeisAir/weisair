img_add_fullscreen("flaps_background.png")
flap_up_img = img_add_fullscreen("flaps_handle_up.png")
flap_50_img = img_add_fullscreen("flaps_handle_50.png")
flap_100_img = img_add_fullscreen("flaps_handle_100.png")
visible( flap_50_img, false)
visible( flap_100_img, false)
flap_group = group_add(flap_up_img,flap_50_img,flap_100_img)

	-- visible( flap_group, false)
		--visible( flap_up_img, true)

function handle_position_set( pos)

	if pos < 0.49 then 
		visible( flap_group, false)
		visible( flap_up_img, true)
	elseif pos < 0.99 then
		visible( flap_group, false)
		visible( flap_50_img, true)
	else
		visible( flap_group, false)
		visible( flap_100_img, true)
	end
end

xpl_dataref_subscribe( "sim/cockpit2/controls/flap_ratio", "FLOAT", handle_position_set)

 
function flap_callback(direction)
if direction == 1 then
xpl_command("sim/flight_controls/flaps_down")
else
xpl_command("sim/flight_controls/flaps_up")
end
end

-- Create an invisible slider (nil image references)
flap_scroll = scrollwheel_add_ver( nil, 120 , 40, 450, 460, 450 , 50, flap_callback)
mouse_setting(flap_scroll , "CURSOR", "grab_hand.png")