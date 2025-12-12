local prop_show_panel_background = user_prop_add_boolean("panel background visible?", true, "Should the panel graphics be visible behind the knob/lettering?")

-- LOAD AUTOBRAKE PANEL           
if (user_prop_get(prop_show_panel_background) == true) 
    then background_img = img_add_fullscreen ( "background_with_panel.png" )
    else background_img = img_add_fullscreen ( "background_no_panel.png" )
end

knob_pos_x = 72
knob_pos_y = 52
knob_width = 61
knob_height = 61

knob_img = img_add ( "auto_brake_knob.png" , knob_pos_x,knob_pos_y, knob_width , knob_height ) 

-- AUTOBRAKE & INDICATORS
function autobrake ( autobrake_setting)  
    autobrake_setting = var_cap ( autobrake_setting , 0 , 5 )  -- ENSURES VALUE OF ZIBO KNOB POSITION IS BETWEEN RTO - MAX
    rotate  ( knob_img , -45 + autobrake_setting * 45 )     -- ROTATES 2D KNOB ACCORDING TO ZIBO'S SELECTED (OR CMD'D) POSITION   
end

function ab_rotate ( direction )                           -- THIS ROTATES ZIBO KNOB ACCORDING TO 2D KNOB'S SELECTED POSITION
    if direction == 1 then 
        xpl_command ( "laminar/B738/knob/autobrake_up" )    -- COMMANDS ZIBO KNOB CW
    elseif direction == -1 then
        xpl_command ( "laminar/B738/knob/autobrake_dn" )    -- COMMANDS ZIBO KNOB CCW    
    end
end

-- THIS IS ACTVATED WHEN 2D KNOB IS TURNED & RETURNS CW OR CCW DIRECTION TO FUNCTION ab_rotate
ab_knob = dial_add ( nil , knob_pos_x,knob_pos_y, knob_width , knob_height , ab_rotate ) 
 
xpl_dataref_subscribe ( "laminar/B738/autobrake/autobrake_pos", "FLOAT", autobrake )