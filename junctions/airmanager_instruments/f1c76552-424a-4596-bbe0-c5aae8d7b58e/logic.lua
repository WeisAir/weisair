--PARKING BRAKE

function new_park_brake(position)
    xpl_command("sim/flight_controls/brakes_toggle_max")
    fsx_event("PARKING_BRAKES")
    fs2020_event("PARKING_BRAKES")
end
park_brake_sw = switch_add("park_brake_off.png", "park_brake_on.png" , 0, 0, 416, 182, new_park_brake)

function park_brake_switch(position)
    sw_on = fif(  position > 0  , 1, 0 )
    switch_set_position(park_brake_sw, position)
end    
xpl_dataref_subscribe("sim/cockpit2/controls/parking_brake_ratio","FLOAT",park_brake_switch)
fsx_variable_subscribe("BRAKE PARKING POSITION", "Position", park_brake_switch )
fs2020_variable_subscribe("BRAKE PARKING POSITION", "Position", park_brake_switch )

--end PARKING BRAKE