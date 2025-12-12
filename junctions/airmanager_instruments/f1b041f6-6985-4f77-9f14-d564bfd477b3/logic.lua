img_add_fullscreen("nosewheel_alt_background.png")

 function bustrans_black_gd(position)
xpl_command("laminar/B738/button_switch_cover10")
end

--153,614,160,58,
bustrans_guard = switch_add( "black_guard_down.png", "black_guard_up.png",  120,48,209,81, bustrans_black_gd)
switch_set_state( bustrans_guard, 0 )

function bt_black_sw(position)
if  position == 0 then
xpl_command("laminar/B738/switch/nose_steer_norm")
else
xpl_command("laminar/B738/switch/nose_steer_alt")
end
end


bt_switch = switch_add(  "black_left.png" ,"black_right.png",  214,48,81,81, bt_black_sw)




--BUS TRANS 
function set_bustrans(bt_guard, bt_sw)
switch_set_state(bustrans_guard, bt_guard[11])
visible(bt_switch, bt_guard[11]==1)
switch_set_state(bt_switch, bt_sw)
end 


xpl_dataref_subscribe("laminar/B738/button_switch/cover_position", "FLOAT[11]", "laminar/B738/switches/nose_steer_pos", "FLOAT",set_bustrans)