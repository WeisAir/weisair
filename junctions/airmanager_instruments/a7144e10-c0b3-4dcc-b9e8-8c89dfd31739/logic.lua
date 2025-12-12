-- Generic knob for knobster

local multi_knob = user_prop_add_boolean("Multi-Knob", true, "If it should have a major and minor knob.")
local knob_push_button = user_prop_add_boolean("Push Button Knob", false, "Does the knob also have a push button")
local button_text = user_prop_add_string("Knob Description", "", "Description shown under the knob.")
local center_knob_text = user_prop_add_string("Knob Text", "PUSH", "Text in center of knob, if its a push button knob.")
local major_ccw = user_prop_add_string("Major Knob CCW Command", "", "The command you want to assign to the major knob, turning counter clock-wise.")
local major_cw = user_prop_add_string("Major Knob CW Command", "", "The command you want to assign to the major knob, turning clock-wise.")
local minor_ccw = user_prop_add_string("Minor Knob CCW Command", "", "The command you want to assign to the minor knob, turning counter clock-wise.")
local minor_cw = user_prop_add_string("Minor Knob CW Command", "", "The command you want to assign to the minor knob, turning clock-wise.")
local minor_pressed_cmd = user_prop_add_string("Button Press Command", "", "Command to run when you push the minor knob.")


function major_callback(direction)
    if direction == 1 then -- clockwise
        xpl_command(user_prop_get(major_cw))
    else
        xpl_command(user_prop_get(major_ccw))
    end
end

function minor_callback(direction)
    if direction == 1 then -- clockwise
        xpl_command(user_prop_get(minor_cw))
    else
        xpl_command(user_prop_get(minor_ccw))
    end
end

function knob_pressed_callback()
    xpl_command(user_prop_get(minor_pressed_cmd))
end

dial_major = dial_add("efis_knob.png", 8.5, 20, 135, 135, major_callback)
dial_minor = dial_add("alt_knob.png", 30, 42, 90, 90, 1, minor_callback)
dial_button = button_add("knob-button.png", "knob-button.png", 45, 57, 60, 60, knob_pressed_callback) 
txt_add(user_prop_get(button_text), "font:inconsolata_bold.ttf; size:18; color: whote; halign:center;", 5, 170, 150, 20)
center_txt = txt_add(user_prop_get(center_knob_text), "font:inconsolata_bold.ttf; size:30; color: whote; halign:center;", 0, 72, 150, 30)

visible(center_txt, user_prop_get(knob_push_button))
visible(dial_button, user_prop_get(knob_push_button))
visible(dial_minor, user_prop_get(multi_knob))
opacity(dial_button, 0.0)