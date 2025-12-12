-- Configuration option to drive navcom box 1 (default) or 2
box_number = user_prop_add_enum("Box 1 or 2","1,2","1","Select use for box 1 or 2")

local knob_rot = 6
local box = user_prop_get(box_number)
local outer_knob_ccw_function = "RXP/GTN/FMS_OUTER_CCW_"..box
local outer_knob_cw_function = "RXP/GTN/FMS_OUTER_CW_"..box
local inner_knob_ccw_function = "RXP/GTN/FMS_INNER_CCW_"..box
local inner_knob_cw_function = "RXP/GTN/FMS_INNER_CW_"..box
local button_function = "RXP/GTN/FMS_PUSH_"..box

-- No background is displayed or used, only knob in foreground

-- OUTER KNOB
function dial_outer(direction)
    if direction == 1 then
        xpl_command(outer_knob_cw_function)
    elseif direction== -1 then
        xpl_command(outer_knob_ccw_function)
    end
end

outer_knob = dial_add("outer_knob.png", 5, 5, 91, 91, dial_outer)
dial_click_rotate(outer_knob, knob_rot)
touch_setting(outer_knob , "ROTATE_TICK", 30)

-- INNER KNOB
function dial_inner(direction)
    if direction == 1 then
        xpl_command(inner_knob_cw_function)
    elseif direction== -1 then
        xpl_command(inner_knob_ccw_function)
    end
end

inner_knob = dial_add("inner_knob.png", 19, 19, 64, 64, dial_inner)
dial_click_rotate(inner_knob, knob_rot)
touch_setting(inner_knob , "ROTATE_TICK", 30)

-- BUTTON
function button_click()
    xpl_command(button_function)
end

button_add("button.png", "button_in.png", 28, 28, 48, 47, button_click)