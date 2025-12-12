backgrouund_img = img_add_fullscreen ( "background.png" )
flap_pointer_img = img_add ( "flap_pointer.png" , 135 , 33 , 104 , 104 )
ab_knob_img  = img_add ( "auto_brake_knob.png" , 30 , 76 , 65 , 65 )
autobrake_amber_lite = img_add ( "ab_disarm.png" , 34 , 23 , 58 , 29 )
antiskid_amber_lite = img_add ( "as_inop.png" , 27 , 165 , 59 , 29 )
le_green_lite = img_add ( "LE_green.png" , 186 , 160 , 59 , 27 )
le_amber_lite = img_add ( "LE_yellow.png" , 121 , 160 , 57 , 26 )
visible(autobrake_amber_lite, false)
visible(antiskid_amber_lite, false)
visible(le_green_lite, false)
visible(le_amber_lite, false)
rotate ( flap_pointer_img ,0 ) -- 1 35  2 75  5 110   10  150  175  25 205  30  235  40 268
rotate ( ab_knob_img ,0)  -- 134   177
ab_cur_val= 1

function new_controls ( LE_transit_on , LE_extend_on, AB_disarm_on, AS_inop_on, flap_pos , autobrake_setting  )
visible(le_green_lite, LE_extend_on > 0)
visible(le_amber_lite, LE_transit_on > 0)
visible(autobrake_amber_lite, AB_disarm_on > 0)
visible(antiskid_amber_lite, AS_inop_on > 0)

if flap_pos < 1 then
rotate ( flap_pointer_img ,35 * flap_pos )
elseif flap_pos < 2 then
rotate ( flap_pointer_img ,35 + (75-35) * (flap_pos - 1) )
elseif flap_pos < 3 then
rotate ( flap_pointer_img ,75 + (110-75) * (flap_pos - 2) )
elseif flap_pos < 4 then
rotate ( flap_pointer_img ,110 + (150-110) * (flap_pos - 3) )
elseif flap_pos < 5 then
rotate ( flap_pointer_img ,150+ (175-150) * (flap_pos - 4) )
elseif flap_pos < 6 then
rotate ( flap_pointer_img ,175+ (205-175) * (flap_pos - 5) )
elseif flap_pos < 7 then
rotate ( flap_pointer_img ,205+ (235-205) * (flap_pos - 6) )
elseif flap_pos <= 8 then
rotate ( flap_pointer_img ,235 + (268-235) * (flap_pos - 7) )
end
autobrake_setting = var_cap ( autobrake_setting , 0 , 5 )
rotate ( ab_knob_img , -45 + autobrake_setting * 45 )
ab_cur_val= autobrake_setting
end

function ab_rotate ( direction )
ab_cur_val= ab_cur_val + direction
ab_cur_val = var_cap ( ab_cur_val , 0 , 5 )
xpl_dataref_write ( "sim/cockpit2/switches/auto_brake_level" , "INT" , ab_cur_val ) 
end

ab_knob = dial_add ( nil , 30 , 76 , 65 , 65 , ab_rotate )


xpl_dataref_subscribe( "x737/systems/flaps/LE_TRANSIT" , "FLOAT" ,
  "x737/systems/flaps/LE_EXT" , "FLOAT"  , 
  "x737/systems/brakes/abrkDisarmedOn", "FLOAT", 
  "x737/systems/brakes/antiskidInopOn", "FLOAT", 
  "x737/systems/flaps/flapDeploymentEnum" , "FLOAT",
  "sim/cockpit2/switches/auto_brake_level" , "INT",  new_controls )