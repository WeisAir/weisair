img_add_fullscreen("du_panel_background.png")


function select_main( position, direction)
    if direction == -1 then
        xpl_command("laminar/B738/toggle_switch/main_pnl_du_capt_left")
    else
        xpl_command("laminar/B738/toggle_switch/main_pnl_du_capt_right")
    end
end
main_knob= switch_add( "knob315.png", "knob000.png", "knob045.png", "knob090.png", "knob135.png", 72,112,168,168, select_main)
function select_lower( position, direction)
    if direction == -1 then
        xpl_command("laminar/B738/toggle_switch/lower_du_capt_left")
    else
        xpl_command("laminar/B738/toggle_switch/lower_du_capt_right")
    end
end
lower_knob= switch_add( "knob315.png", "knob000.png", "knob045.png", 339,112,168,168, select_lower)


function set_du_knobs(main_pos, lower_pos)
switch_set_position( main_knob, main_pos + 1)
switch_set_position( lower_knob, lower_pos + 1)
end

xpl_dataref_subscribe("laminar/B738/toggle_switch/main_pnl_du_capt", "FLOAT",
                                     "laminar/B738/toggle_switch/lower_du_capt", "FLOAT",    set_du_knobs)