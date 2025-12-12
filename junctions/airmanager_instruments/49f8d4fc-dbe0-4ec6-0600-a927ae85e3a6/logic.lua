-- This is a modification of Russ Barlow's EADT x737NG Flaps-Autobrakes instrument that converts it for use with the ZiboMod 737.
-- The autobrake knob and indicator lights use ZIBO datarefs and commands so they will only work correctly with the ZIBO 737. 
-- An X-Plane dataref is used to slow the movement of the flap pointer.
-- Tested with ZiboMod 737-800 v.3.40 and Air Manager 3.7.
-- GoodSim 5/28/20

-- LOAD FLAPS AUTOBRAKE PANEL           
backgrouund_img      = img_add_fullscreen ( "background.png" )              -- FLAP POSITION DIAL REDRAWN
flap_pointer_img     = img_add ( "flap_pointer.png" , 138 , 35 , 98 , 98 )  -- 135 , 33 , 104 , 104
ab_knob_img          = img_add ( "auto_brake_knob.png" , 30 , 76 , 65 , 65 )
autobrake_amber_lite = img_add ( "ab_disarm.png" , 34 , 23 , 58 , 29, "visible:false" )
antiskid_amber_lite  = img_add ( "as_inop.png" , 27 , 165 , 59 , 29, "visible:false" )
le_green_lite        = img_add ( "LE_green.png" , 186 , 160 , 59 , 27, "visible:false" )
le_amber_lite        = img_add ( "LE_yellow.png" , 121 , 160 , 57 , 26, "visible:false" )

rotate  ( flap_pointer_img ,0 )          
rotate  ( ab_knob_img ,0 )               

-- FLAPS & SLATS INDICATORS                                                                  
function flaps ( LE_transit_on , LE_extend_on, flap_deploy_ratio )
    visible ( le_amber_lite, LE_transit_on > 0 )       
    visible ( le_green_lite, LE_extend_on > 0 )              
    rotate  ( flap_pointer_img , 262 * flap_deploy_ratio ) -- 0/0  1/.125  2/.25  5/.375  10/.5   15/.625 25/.75  30/.875  40/1   (Pos/Ratio)
end                                                    -- 0/0  1/34    2/67   5/101   10/134  15/168  25/201  30/235   40/268 (Pos/Deg)

-- AUTOBRAKE & INDICATORS
function autobrake ( autobrake_setting, AB_disarm_on, AS_inop_on )
    visible ( autobrake_amber_lite, AB_disarm_on > 0 )           
    visible ( antiskid_amber_lite,    AS_inop_on > 0 )      
    autobrake_setting = var_cap ( autobrake_setting , 0 , 5 )  -- ENSURES VALUE OF ZIBO KNOB POSITION IS BETWEEN RTO - MAX
    rotate  ( ab_knob_img , -45 + autobrake_setting * 45 )     -- ROTATES 2D KNOB ACCORDING TO ZIBO'S SELECTED (OR CMD'D) POSITION   
end

function ab_rotate ( direction )                           -- THIS ROTATES ZIBO KNOB ACCORDING TO 2D KNOB'S SELECTED POSITION
    if direction == 1 then 
        xpl_command ( "laminar/B738/knob/autobrake_up" )    -- COMMANDS ZIBO KNOB CW
    elseif direction == -1 then
        xpl_command ( "laminar/B738/knob/autobrake_dn" )    -- COMMANDS ZIBO KNOB CCW    
    end
end

-- THIS IS ACTVATED WHEN 2D KNOB IS TURNED & RETURNS CW OR CCW DIRECTION TO FUNCTION ab_rotate
ab_knob = dial_add ( nil , 30 , 76 , 65 , 65 , ab_rotate ) 
 
xpl_dataref_subscribe ( "laminar/B738/autobrake/autobrake_pos", "FLOAT",  
                        "laminar/B738/autobrake/autobrake_disarm", "FLOAT",
                        "laminar/B738/annunciator/anti_skid_inop", "FLOAT", autobrake )

xpl_dataref_subscribe ( "laminar/B738/annunciator/slats_transit", "FLOAT", 
                        "laminar/B738/annunciator/slats_extend", "FLOAT",
                        "sim/flightmodel2/controls/flap_handle_deploy_ratio", "FLOAT", flaps )