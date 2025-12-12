img_add_fullscreen( "fuel_control_background.png")


function move_selector( position, direction)

	if position== 0 then 
		if direction == 1 then
			new_pos = 4 
		else
			new_pos = 1
		end
	elseif position == 1 then
		if direction == 1 then
			new_pos = 3 
		else
			new_pos = 1
		end
	else
		if direction == 1 then
			new_pos = 3 
		else
			new_pos = 4
		end
	end
	xpl_dataref_write("sim/cockpit2/fuel/fuel_tank_selector", "INT", new_pos)

end

fuel_sel_sw = switch_add( "fuel_select_left.png", "fuel_select_auto.png", "fuel_select_right.png",55,112,192,197, move_selector)

local tank = 0
function set_selector(position)
	if position == 1 then 
		tank = 0
	elseif position == 4 then 
		tank = 1
	elseif position == 3 then 
		tank = 2
	end
	switch_set_position( fuel_sel_sw, tank)
end
xpl_dataref_subscribe("sim/cockpit2/fuel/fuel_tank_selector", "INT", set_selector)