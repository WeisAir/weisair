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
visible(le_green_lite, LE_extend_on > 0.0)
visible(le_amber_lite, LE_transit_on > 0.0)
visible(autobrake_amber_lite, AB_disarm_on > 0.0)
visible(antiskid_amber_lite, AS_inop_on > 0.0)

if flap_pos < 0.125 then
rotate ( flap_pointer_img ,35 * flap_pos )
elseif flap_pos < 0.25 then
rotate ( flap_pointer_img ,35 + (75-35) * (flap_pos - 1) )
elseif flap_pos < 0.375 then
rotate ( flap_pointer_img ,75 + (110-75) * (flap_pos - 2) )
elseif flap_pos < 0.5 then
rotate ( flap_pointer_img ,110 + (150-110) * (flap_pos - 3) )
elseif flap_pos < 0.625 then
rotate ( flap_pointer_img ,150+ (175-150) * (flap_pos - 4) )
elseif flap_pos < 0.75 then
rotate ( flap_pointer_img ,175+ (205-175) * (flap_pos - 5) )
elseif flap_pos < 0.825 then
rotate ( flap_pointer_img ,205+ (235-205) * (flap_pos - 6) )
elseif flap_pos <= 1.0 then
rotate ( flap_pointer_img ,235 + (268-235) * (flap_pos - 7) )
end
autobrake_setting = var_cap ( autobrake_setting , -1 , 4 )
rotate ( ab_knob_img , -45 + (autobrake_setting+1) * 45 )
ab_cur_val= autobrake_setting
end

function ab_rotate ( direction )
ab_cur_val= ab_cur_val + direction
ab_cur_val = var_cap ( ab_cur_val , -1 , 4 )
xpl_dataref_write ( "ixeg/733/hydraulics/hyd_auto_brake_act" , "FLOAT" , ab_cur_val ) 
end

ab_knob = dial_add ( nil , 30 , 76 , 65 , 65 , ab_rotate )


xpl_dataref_subscribe( "ixeg/733/le_devices/le_transit_main_ann" , "FLOAT" ,
  "ixeg/733/le_devices/le_ext_main_ann" , "FLOAT"  , 
  "ixeg/733/hydraulics/hyd_auto_brake_disarm_ann", "FLOAT", 
  "ixeg/733/hydraulics/anti_skid_inop_ann", "FLOAT", 
  "ixeg/733/hydraulics/hyd_flap_lever_act" , "FLOAT",
  "ixeg/733/hydraulics/hyd_auto_brake_act" , "FLOAT",  new_controls )