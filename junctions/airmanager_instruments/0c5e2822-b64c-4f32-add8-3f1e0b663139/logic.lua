img_add_fullscreen("eng_start_background.png")

function start_push_pressed()
    xpl_command("laminar/SF50/eng_start_stop_toggle", "BEGIN")
end

function start_push_released()
    xpl_command("laminar/SF50/eng_start_stop_toggle", "END")
end

button_add(nil, "eng_start_button_push.png", 25,41,229,196, start_push_pressed, start_push_released)  

function start_twist(position, direction)
    if direction == 1 then
        xpl_command("laminar/SF50/ignition_up")
    else
        xpl_command("laminar/SF50/ignition_down")
    end
end

start_sw = switch_add("eng_start_knob_off.png", "eng_start_knob_run.png", 52,304,232,232, start_twist)

function set_start_switch(position, burning_fuel)
    switch_set_position(start_sw, position)
    arm_pos = position
    running = burning_fuel[1]
end

xpl_dataref_subscribe("laminar/SF50/ignition_position", "FLOAT", 
                      "sim/flightmodel2/engines/engine_is_burning_fuel", "INT[8]", set_start_switch)