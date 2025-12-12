img_add_fullscreen("screen_background.png")

lt_gear_dn = img_add( "lt_gear.png", 259,252,58,50)
nose_gear_dn = img_add( "nose_gear.png", 356,127,50,52)
rt_gear_dn = img_add( "rt_gear.png", 447,252,58,50)
lt_tr = img_add( "lt_tr.png", 266,258,39,40)
nose_tr = img_add( "nose_tr.png", 363,131,39,40)
rt_tr = img_add( "rt_tr.png", 458,258,39,40)


function door_ops( position) 
    xpl_command("sim/flight_controls/door_toggle_1")
end


door_switch = switch_add( nil, "door_open.png", 121,124,149,105, door_ops)

function brake_ops( position) 
    xpl_dataref_write("sim/cockpit2/controls/parking_brake_ratio", "FLOAT",fif( position == 0 , 0.3 , 0   ))
end


brake_switch = switch_add( nil, "brakes_on.png", 526,313,146,116, brake_ops)

function set_brake( br_ratio )
    switch_set_position( brake_switch, fif( br_ratio == 0, 0, 1 ))
end


xpl_dataref_subscribe("sim/cockpit2/controls/parking_brake_ratio", "FLOAT", set_brake)


function gear_pos( gr_ratio)
    visible( lt_gear_dn, gr_ratio[2] == 1 )
    visible( nose_gear_dn, gr_ratio[1] == 1 )
    visible( rt_gear_dn, gr_ratio[3] == 1 )
    visible( lt_tr, gr_ratio[2] < 1 and gr_ratio[2] > 0 )
    visible( nose_tr, gr_ratio[1] < 1 and gr_ratio[1] > 0 )
    visible( rt_tr, gr_ratio[3] < 1 and gr_ratio[3] > 0 )
end

xpl_dataref_subscribe("sim/flightmodel2/gear/deploy_ratio" , "FLOAT[10]", gear_pos)

off_screen = img_add("dark_screen.png", 107,66,713,433)

local gbl_cockpit_light = 0
function darken( volts, canopy, cockpit_light )
    visible( off_screen, volts[1] < 10  )
    visible( door_switch, volts[1] >= 10 )
    visible( brake_switch, volts[1] >= 10 )
    
    switch_set_position(door_switch, math.ceil(canopy[1]) )
    gbl_cockpit_light = cockpit_light
end


xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts", "FLOAT[6]",
                      "sim/flightmodel2/misc/door_open_ratio", "FLOAT[2]", 
                      "sim/cockpit/electrical/cockpit_lights", "FLOAT", darken)
                      
function cabin_light( direction)
    xpl_dataref_write("sim/cockpit/electrical/cockpit_lights", "FLOAT", var_cap(gbl_cockpit_light + (direction * 0.05), 0, 1) )
end


dial_add( nil, 925, 455, 78, 78, cabin_light)