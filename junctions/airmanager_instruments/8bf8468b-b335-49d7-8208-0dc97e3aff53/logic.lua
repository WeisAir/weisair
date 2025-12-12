background_image = img_add_fullscreen ( "background.png" )

img_rect_width = 91
img_rect_height = 54
img_square_width = 76
img_square_height = 75


-- flap pointer
flap_pointer_img    		 = img_add ( "flap_pointer.png" , 530 , 105 , 200 , 200 ) 


--inactive announciators (grey)
grey_altitude_alert 		= img_add ( "announciators/grey_altitude_alert.png" 			, 108 	, 199 	, img_rect_width 	, img_rect_height )
grey_anti_skid_inop 		= img_add ( "announciators/grey_anti_skid_inop.png" 			, 217 	, 140 	, img_rect_width 	, img_rect_height )
grey_auto_brake_disarm 		= img_add ( "announciators/grey_auto_brake_disarm.png" 			, 315 	, 140 	, img_rect_width 	, img_rect_height )
grey_below_gs_pinhibit 		= img_add ( "announciators/grey_below_gs_pinhibit.png" 			, 10 	, 199 	, img_rect_width 	, img_rect_height )
grey_flap_load_relief 		= img_add ( "announciators/grey_flap_load_relief.png" 			, 492 	, 15 	, img_rect_width 	, img_rect_height )
grey_le_flaps_ext 			= img_add ( "announciators/grey_le_flaps_ext.png" 				, 589 	, 15 	, img_rect_width 	, img_rect_height )
grey_le_flaps_transit 		= img_add ( "announciators/grey_le_flaps_transit.png" 			, 687 	, 15 	, img_rect_width 	, img_rect_height )
grey_low_oil_pressure_l		= img_add ( "announciators/grey_low_oil_pressure.png" 			, 443 	, 417 	, img_rect_width 	, img_rect_height )
grey_low_oil_pressure_r		= img_add ( "announciators/grey_low_oil_pressure.png" 			, 633 	, 417 	, img_rect_width 	, img_rect_height )
grey_oil_filter_bypass_l	= img_add ( "announciators/grey_oil_filter_bypass.png"			, 538 	, 417 	, img_rect_width 	, img_rect_height )
grey_oil_filter_bypass_r	= img_add ( "announciators/grey_oil_filter_bypass.png"			, 730 	, 417 	, img_rect_width 	, img_rect_height )
grey_pull_up 				= img_add ( "announciators/grey_pull_up.png" 					, 11 	, 140 	, img_rect_width 	, img_rect_height )
grey_reverser_unlocked_l	= img_add ( "announciators/grey_reverser_unlocked.png" 			, 76 	, 417 	, img_rect_width 	, img_rect_height )
grey_reverser_unlocked_r	= img_add ( "announciators/grey_reverser_unlocked.png" 			, 276 	, 417 	, img_rect_width 	, img_rect_height )
grey_speed_brake_armed 		= img_add ( "announciators/grey_speed_brake_armed.png" 			, 315 	, 199 	, img_rect_width 	, img_rect_height )
grey_speed_brake_do_not_arm = img_add ( "announciators/grey_speed_brake_do_not_arm.png" 	, 216 	, 199 	, img_rect_width 	, img_rect_height )
grey_start_valve_open_l		= img_add ( "announciators/grey_start_valve_open.png" 			, 490 	, 360 	, img_rect_width 	, img_rect_height )
grey_start_valve_open_r		= img_add ( "announciators/grey_start_valve_open.png" 			, 682 	, 360 	, img_rect_width 	, img_rect_height )
grey_terrain_on_display 	= img_add ( "announciators/grey_terrain_on_display.png" 		, 108 	, 140 	, img_rect_width 	, img_rect_height )
grey_ap_prst 				= img_add ( "announciators/grey_xx_prst.png" 					, 11 	, 15 	, img_square_width 	, img_square_height )
grey_at_prst 				= img_add ( "announciators/grey_xx_prst.png" 					, 90 	, 15 	, img_square_width 	, img_square_height )
grey_fmc_prst 				= img_add ( "announciators/grey_xx_prst.png" 					, 170 	, 15 	, img_square_width 	, img_square_height )

--active announciators (green)
green_terrain_on_display 	= img_add ( "announciators/green_terrain_on_display.png" 		, 108 	, 140 	, img_rect_width 	, img_rect_height )
green_speed_brake_armed 	= img_add ( "announciators/green_speed_brake_armed.png" 		, 315 	, 199 	, img_rect_width 	, img_rect_height )
green_le_flaps_ext 			= img_add ( "announciators/green_le_flaps_ext.png" 				, 589 	, 15 	, img_rect_width 	, img_rect_height )

--active announciators (orange)
orange_altitude_alert 			= img_add ( "announciators/orange_altitude_alert.png" 			, 108 	, 199 	, img_rect_width 	, img_rect_height )
orange_anti_skid_inop 			= img_add ( "announciators/orange_anti_skid_inop.png" 			, 217 	, 140 	, img_rect_width 	, img_rect_height )
orange_auto_brake_disarm 		= img_add ( "announciators/orange_auto_brake_disarm.png" 		, 315 	, 140 	, img_rect_width 	, img_rect_height )
orange_below_gs_pinhibit 		= img_add ( "announciators/orange_below_gs_pinhibit.png" 		, 10 	, 199 	, img_rect_width 	, img_rect_height )
orange_flap_load_relief 		= img_add ( "announciators/orange_flap_load_relief.png" 		, 492 	, 15 	, img_rect_width 	, img_rect_height )
orange_le_flaps_transit 		= img_add ( "announciators/orange_le_flaps_transit.png" 		, 687 	, 15 	, img_rect_width 	, img_rect_height )
orange_low_oil_pressure_l		= img_add ( "announciators/orange_low_oil_pressure.png" 		, 443 	, 417 	, img_rect_width 	, img_rect_height )
orange_low_oil_pressure_r		= img_add ( "announciators/orange_low_oil_pressure.png" 		, 633 	, 417 	, img_rect_width 	, img_rect_height )
orange_oil_filter_bypass_l		= img_add ( "announciators/orange_oil_filter_bypass.png"		, 538 	, 417 	, img_rect_width 	, img_rect_height )
orange_oil_filter_bypass_r		= img_add ( "announciators/orange_oil_filter_bypass.png"		, 730 	, 417 	, img_rect_width 	, img_rect_height )
orange_pull_up 					= img_add ( "announciators/orange_pull_up.png" 					, 11 	, 140 	, img_rect_width 	, img_rect_height )
orange_reverser_unlocked_l		= img_add ( "announciators/orange_reverser_unlocked.png" 		, 76 	, 417 	, img_rect_width 	, img_rect_height )
orange_reverser_unlocked_r		= img_add ( "announciators/orange_reverser_unlocked.png" 		, 276 	, 417 	, img_rect_width 	, img_rect_height )
orange_start_valve_open_l		= img_add ( "announciators/orange_start_valve_open.png" 		, 490 	, 360 	, img_rect_width 	, img_rect_height )
orange_start_valve_open_r		= img_add ( "announciators/orange_start_valve_open.png" 		, 682 	, 360 	, img_rect_width 	, img_rect_height )
orange_ap_prst 					= img_add ( "announciators/orange_ap_prst.png" 					, 11 	, 15 	, img_square_width 	, img_square_height )
orange_at_prst 					= img_add ( "announciators/orange_at_prst.png" 					, 90 	, 15 	, img_square_width 	, img_square_height )
orange_fmc_prst 				= img_add ( "announciators/orange_fmc_prst.png" 				, 170 	, 15 	, img_square_width 	, img_square_height )

--active announciators (red)
red_ap_prst 					= img_add ( "announciators/red_ap_prst.png" 					, 11 	, 15 	, img_square_width 	, img_square_height )
red_at_prst 					= img_add ( "announciators/red_at_prst.png" 					, 90 	, 15 	, img_square_width 	, img_square_height )
red_speed_brake_do_not_arm 		= img_add ( "announciators/red_speed_brake_do_not_arm.png" 		, 216 	, 199 	, img_rect_width 	, img_rect_height )

function announciators_state (
anti_skid, 
speed_brake_armed, 
speed_brake_noarm, 
low_oil_1, 
low_oil_2, 
revers_unlkd_1, 
revers_unlkd_2, 
flap_load_rel, 
auto_brk_disarm, 
le_transit, 
le_ext, 
eng1_valve, 
eng2_valve, 
alt_alert, 
pullup_alert, 
below_gs,
terr_on_display,
dummy,
ap_rst,
fmc_rst
)

-- green states
visible ( green_speed_brake_armed, speed_brake_armed 		> 0.49) 
visible ( green_le_flaps_ext, le_ext 						> 0.49)
visible ( green_terrain_on_display, terr_on_display			> 0.49) 		

-- orange states
visible ( orange_altitude_alert,alt_alert 					> 0.00) 			
visible ( orange_anti_skid_inop,anti_skid 					> 0.49) 			
visible ( orange_auto_brake_disarm,auto_brk_disarm 			> 0.49) 		
visible ( orange_below_gs_pinhibit,below_gs 				> 0.49) 		
visible ( orange_flap_load_relief,flap_load_rel 			> 0.49) 		
visible ( orange_le_flaps_transit,le_transit				> 0.49) 		
visible ( orange_low_oil_pressure_l,low_oil_1				> 0.49)		
visible ( orange_low_oil_pressure_r,low_oil_2				> 0.49)		
visible ( orange_oil_filter_bypass_l,dummy					> 0.49)		
visible ( orange_oil_filter_bypass_r,dummy					> 0.49)		
visible ( orange_pull_up,pullup_alert						> 0.49) 					
visible ( orange_reverser_unlocked_l,revers_unlkd_1			> 0.49)		
visible ( orange_reverser_unlocked_r,revers_unlkd_2			> 0.49)		
visible ( orange_start_valve_open_l,eng1_valve				> 0.49)		
visible ( orange_start_valve_open_r,eng2_valve				> 0.49)		
visible ( orange_ap_prst,									false) 					
visible ( orange_at_prst,									false) 					
visible ( orange_fmc_prst,fmc_rst							> 0.49) 				

-- red states
visible ( red_at_prst,false)
visible ( red_ap_prst,ap_rst								> 0.00)
visible ( red_speed_brake_do_not_arm,speed_brake_noarm 		> 0.49)
	
end


function flaps ( flap_deploy_ratio )     
    rotate  ( flap_pointer_img , 266 * flap_deploy_ratio ) -- 0/0  1/.125  2/.25  5/.375  10/.5   15/.625 25/.75  30/.875  40/1   (Pos/Ratio)
end                                                    -- 0/0  1/34    2/67   5/101   10/134  15/168  25/201  30/235   40/268 (Pos/Deg)


xpl_dataref_subscribe( 
"ixeg/733/hydraulics/anti_skid_inop_ann" , "FLOAT", 
"ixeg/733/hydraulics/speed_brake_armed_ann" , "FLOAT",
"ixeg/733/hydraulics/speed_brake_noarm_ann", "FLOAT",
"ixeg/733/ecam/low_oilp_1_ann", "FLOAT", 
"ixeg/733/ecam/low_oilp_2_ann", "FLOAT", 
"ixeg/733/ecam/rev_unlkd_1_ann", "FLOAT", 
"ixeg/733/ecam/rev_unlkd_2_ann", "FLOAT", 
"ixeg/733/hydraulics/flap_load_relief_ann", "FLOAT", 
"ixeg/733/hydraulics/hyd_auto_brake_disarm_ann", "FLOAT", 
"ixeg/733/le_devices/le_transit_main_ann", "FLOAT", 
"ixeg/733/le_devices/le_ext_main_ann", "FLOAT", 
"ixeg/733/bleedair/engine1_start_valve_ann", "FLOAT", 
"ixeg/733/bleedair/engine2_start_valve_ann", "FLOAT", 
"ixeg/733/MCP/altitude_alert_ann", "FLOAT", 							
"ixeg/733/MCP/pullup_alert_ann", "FLOAT", 							
"ixeg/733/misc/egpws_gs_ann", "FLOAT", 						
"ixeg/733/misc/egpws_tod_ann", "FLOAT",
"ixeg/733/caution/dummy_ann", "FLOAT",
"ixeg/733/caution/caution_ap_rst_ind", "FLOAT",
"ixeg/733/FMC/cdu1_msg_ann", "FLOAT",
announciators_state)

xpl_dataref_subscribe ( 
"sim/flightmodel2/controls/flap_handle_deploy_ratio", "FLOAT",
flaps)