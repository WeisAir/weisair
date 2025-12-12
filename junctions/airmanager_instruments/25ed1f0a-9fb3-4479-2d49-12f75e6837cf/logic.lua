img_add_fullscreen("ldg_gear_background.png")



function cycle_gear( position)

end

gear_switch = switch_add( "gear_up.png", "gear_down.png", 17,493,166,541, cycle_gear)





function gear_callback(direction)

  if direction == -1 then
    xpl_command("sim/flight_controls/landing_gear_up" )
  end

  if direction == 1 then
    xpl_command("sim/flight_controls/landing_gear_down" )
  end
end

-- Create a new scroll wheel
gear_scroll = scrollwheel_add_ver(nil,38, 486, 128, 475, 38, 90, gear_callback)

mouse_setting(gear_scroll , "CURSOR", "grab_hand.png")

function gear_change(position)
switch_set_position(gear_switch , position )
end



xpl_dataref_subscribe("sim/cockpit/switches/gear_handle_status", "INT", gear_change)

function revert_display()
xpl_command("sim/GPS/G1000_display_reversion")
end



button_add( nil, "ldg_gear_display_bu.png", 71,183,61,61, revert_display)



function set_baro(direction)
if direction == 1 then
xpl_command("sim/instruments/barometer_up")
else
xpl_command("sim/instruments/barometer_down")
end
end


dial_add( "ldg_gear_baro_knob.png", 63,344,72,72,2, set_baro)