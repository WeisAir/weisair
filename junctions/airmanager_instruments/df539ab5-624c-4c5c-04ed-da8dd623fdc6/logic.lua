img_add_fullscreen("misc_annunciators.png")
d=0

AP_red_lite = img_add ( "AP_red.png" , 72, 98 , 80 , 80 )
AT_red_lite = img_add ( "AT_red.png" , 185, 98 , 80 , 80)
AP_amber_lite = img_add ( "AP_amber.png"  , 72, 98 , 80 , 80 )
AT_amber_lite = img_add ( "AT_amber.png" , 185, 98 , 80 , 80)
FMC_amber_lite = img_add ( "FMC_amber.png" , 301,98,80,81)





visible( AP_red_lite,false)
visible( AT_red_lite,false)
visible( AP_amber_lite,false)
visible( AT_amber_lite,false)
visible( FMC_amber_lite,false)


test_sw=  switch_add ("switch_down.png", nil , "switch_up.png", 435, 74 , 58, 148, nil)
--dn_sw= button_add ( nil, "switchdn_1.png"  , 852 - d , 77 , 46 , 54, test_dn_hold, test_off)
 switch_set_position(test_sw, 1)
function test_callback(direction)
  if direction == -1 then
    xpl_command("laminar/B738/toggle_switch/ap_disconnect_test1_up", 1)
  elseif  direction == 1 then
    xpl_command("laminar/B738/toggle_switch/ap_disconnect_test1_dn",1)
  end
end


function sreleased()
    xpl_command("laminar/B738/toggle_switch/ap_disconnect_test1_up", 0)
    xpl_command("laminar/B738/toggle_switch/ap_disconnect_test1_dn", 0)
end

 --Create overlying
scrollwheel_add_ver(nil, 435, 74, 58, 148, 58 , 40, test_callback, nil, sreleased) 

function test_set( position)
    if position == -1 then
        switch_set_position(test_sw, 0)
    elseif position == 1 then 
         switch_set_position(test_sw,2)
    else
         switch_set_position(test_sw, 1)
    end
end
xpl_dataref_subscribe("laminar/B738/toggle_switch/ap_discon_test1", "FLOAT", test_set)





function  reset_AP_pressed()
    xpl_command ( "laminar/B738/push_button/ap_light_pilot" , 1 )
end

function  reset_AP_released()
    xpl_command ( "laminar/B738/push_button/ap_light_pilot" , 0 )
end

AP_rst_btn = button_add ( nil , nil ,72, 98 , 80 , 80 , reset_AP_pressed, reset_AP_released )

function  reset_AT_pressed()
    xpl_command( "laminar/B738/push_button/at_light_pilot" , 1 )
end

function  reset_AT_released()
    xpl_command( "laminar/B738/push_button/at_light_pilot" , 0 )
end

AT_rst_btn = button_add ( nil , nil ,185, 98 , 80 , 80 , reset_AT_pressed, reset_AT_released )


function  reset_FMC_pressed()
    xpl_command ( "laminar/B738/push_button/fms_light_pilot" , 1 )
end

function  reset_FMC_released()
    xpl_command ( "laminar/B738/push_button/fms_light_pilot" , 0 )
end

FMC_rst_btn = button_add ( nil , nil ,301,98,80,81 , reset_FMC_pressed, reset_FMC_released )

--


--	MASTER FIRE button 



function annunc_lite_status(  ap_red_lite_on,  at_red_lite_on,  fmc_amber_lite_on )--, ap_amber_lite_on, at_amber_lite_on, fmc_amber_lite_on )
visible ( AP_amber_lite , ap_red_lite_on > 0  and testing == 1 )
visible ( AP_red_lite , ap_red_lite_on > 0 )
visible ( AT_red_lite , at_red_lite_on > 0 )
visible ( AT_amber_lite ,at_red_lite_on > 0  and testing == 1  )
visible ( FMC_amber_lite , fmc_amber_lite_on> 0 )
--visible ( MC_lite , MC_lite_on > .1 )
end

xpl_dataref_subscribe(  "laminar/B738/annunciator/ap_disconnect1" , "FLOAT" , 
 "laminar/B738/annunciator/at_disconnect1" , "FLOAT" ,
"laminar/B738/annunciator/at_fms_disconnect1", "FLOAT", annunc_lite_status )
--"x737/systems/afds/alert/capt/AP_PRST_amber" , "INT" ,
--"x737/systems/afds/alert/capt/AT_PRST_red" , "INT" ,
--"x737/systems/afds/alert/capt/AT_PRST_amber" , "INT" , 
--"x737/systems/afds/alert/capt/FMC_PRST_amber" , "INT" ,
--annunc_lite_status )

img_to_config= img_add( "to_on.png", 50,308,153,75)
img_cab_alt= img_add( "cab_on.png", 218,309,153,74)
img_sb_noarm= img_add( "sb_on.png", 415,310,152,73)
img_sb_arm= img_add( "sb_arm.png", 583,309,153,73)
img_stab_outtrim= img_add( "stab_on.png", 828,169,123,116)


function set_annunciators( to_config_on, cab_alt_on, sb_no_arm, sb_arm_on, stab_out)
visible( img_to_config, to_config_on > 0)
visible( img_cab_alt, cab_alt_on > 0)
visible( img_sb_noarm, sb_no_arm > 0)
visible( img_sb_arm, sb_arm_on > 0)
visible( img_stab_outtrim, stab_out > 0)
end

xpl_dataref_subscribe("laminar/B738/annunciator/takeoff_config", "FLOAT",
"laminar/B738/annunciator/cabin_alt", "FLOAT",
"laminar/B738/annunciator/spd_brk_not_arm", "FLOAT", 
"laminar/B738/annunciator/speedbrake_armed", "FLOAT",
"laminar/B738/annunciator/stab_out_of_trim", "FLOAT", set_annunciators)


--lite test brite



brite_test_sw= switch_add("svr_dn.png", "svr_mid.png", "svr_up.png", 628,111,90,117, nil)

function britetest_callback(direction)
  if direction == -1 then
    xpl_command("laminar/B738/toggle_switch/bright_test_up")
else
    xpl_command("laminar/B738/toggle_switch/bright_test_dn")
end
end

 --Create overlying
scrollwheel_add_ver(nil, 628,111,90,117,90, 40, britetest_callback)


function set_brite_test(position)
switch_set_position( brite_test_sw, position + 1)
end

xpl_dataref_subscribe("laminar/B738/toggle_switch/bright_test", "FLOAT", set_brite_test)