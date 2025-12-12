-- This is a modification of Russ Barlow's EADT x737NG annunciator panel that converts it for use with the ZiboMod 737.
-- It uses ZIBO datarefs and commands and will only work correctly with the ZIBO 737. 
-- Tested with ZiboMod 737-800 v.3.40 and Air Manager 3.7.
-- GoodSim 5/28/20

-- LOAD PANEL
image_id = img_add_fullscreen ( "Annunciator_Panel_bkgnd.png" )

MC_lite        = img_add ( "MC_lite.png" , 108 , 35 , 77 , 76, "visible:false" )
FW_lite        = img_add ( "fire_warn.png" , 18 , 35 , 78 , 76, "visible:false" )
AP_red_lite    = img_add ( "AP_red.png" , 641 , 59 , 53 , 53 )
AT_red_lite    = img_add ( "AT_red.png" , 712 , 59 , 54 , 53 )
AP_amber_lite  = img_add ( "AP_amber.png" , 641 , 59 , 53 , 53 )
AT_amber_lite  = img_add ( "AT_amber.png" , 712 , 59 , 54 , 53 )
FMC_amber_lite = img_add ( "FMC_amber.png" , 785 , 59 , 54 , 53 )
flt_cont_lite  = img_add ( "flt_cont.png" , 210 , 29 , 94 , 29, "visible:false" )
elec_lite      = img_add ( "elec.png" , 304 , 29 , 84 , 29, "visible:false" )
anti_ice_lite  = img_add ( "anti_ice.png" , 421 , 28 , 100 , 30, "visible:false" )
eng_lite       = img_add ( "eng.png" , 521 , 28 , 79 , 30, "visible:false" )
irs_lite       = img_add ( "irs.png" , 210 , 58 , 89 , 30, "visible:false" )
apu_lite       = img_add ( "apu.png" , 299 , 58 , 89 , 30, "visible:false" )
hyd_lite       = img_add ( "hyd.png" , 421 , 58 , 75 , 30, "visible:false" )
overhead_lite  = img_add ( "overhead.png" , 496 , 58 , 104 , 30, "visible:false" )
fuel_lite      = img_add ( "fuel.png" , 210 , 88 , 79 , 28, "visible:false" )
ovht_det_lite  = img_add ( "ovht_det.png" , 289 , 88 , 99 , 28, "visible:false" )
doors_lite     = img_add ( "doors.png" , 421 , 88 , 80 , 29, "visible:false" )
air_cond_lite  = img_add ( "air_cond.png" , 501 , 88 , 99 , 29, "visible:false" )

visible ( AP_amber_lite,  false )
visible ( AT_amber_lite,  false )
visible ( AP_red_lite,    false )
visible ( AT_red_lite,    false )
visible ( FMC_amber_lite, false )

-- FIRE WARNING SWITCH
function click_FW()                      
xpl_command ( "laminar/B738/push_button/fire_bell_light1" ) -- xpl_command ( "sim/annunciator/clear_master_warning" ) NOT NEEDED
end
FW_prst = button_add ( nil  , nil , 18 , 35 , 78 , 76 , click_FW )

-- MASTER CAUTION SWITCH
function click_MC() 
xpl_command ( "laminar/B738/push_button/master_caution1" ) -- xpl_command ( "sim/annunciator/clear_master_caution" ) NOT NEEDED
end
MC_prst = button_add ( nil  , nil ,108 , 35 , 77 , 76 , click_MC )

-- LIGHT TEST SWITCH (CAPT & FO 6 PACKS)                                            
function press_twelve()                                    
xpl_command ( "laminar/B738/push_button/capt_six_pack", 1 ) 
xpl_command ( "laminar/B738/push_button/fo_six_pack", 1 )   
end
function release_twelve()                                 
xpl_command ( "laminar/B738/push_button/capt_six_pack", 0 ) 
xpl_command ( "laminar/B738/push_button/fo_six_pack", 0 )
end  
twelve_pack = button_add ( nil  ,"twelve_test.png" , 210 , 29 , 389 , 88  , press_twelve, release_twelve )                                                                                                                                                                                    

-- LIGHT TEST SWITCH (AUTOFLIGHT STATUS ANNUNCIATORS)       
function test_up_hold()                                 
xpl_command ( "laminar/B738/toggle_switch/ap_disconnect_test1_up", 1 )
end
function test_up_off()
xpl_command ( "laminar/B738/toggle_switch/ap_disconnect_test1_up", 0 )
end
function test_down_hold()
xpl_command ( "laminar/B738/toggle_switch/ap_disconnect_test1_dn", 1 )
end
function test_down_off()
xpl_command ( "laminar/B738/toggle_switch/ap_disconnect_test1_dn", 0 )
end
up_sw = button_add ( "switchmid_1.png", "switchup_1.png", 852 , 43 , 46 , 54, test_up_hold, test_up_off )
dn_sw = button_add ( nil, "switchdn_1.png"  , 852 , 77 , 46 , 54, test_down_hold, test_down_off )

-- AUTOPILOT STATUS RESET
function reset_AP_pressed()
xpl_command ( "laminar/B738/push_button/ap_light_pilot", 1 )
end
function reset_AP_released()
xpl_command ( "laminar/B738/push_button/ap_light_pilot", 0 )
end
AP_rst_btn = button_add ( nil , nil ,641 , 59 , 53 , 53 , reset_AP_pressed, reset_AP_released )  

-- AUTOTHROTTLE STATUS RESET
function reset_AT_pressed()
xpl_command ( "laminar/B738/push_button/at_light_pilot", 1 )
end
function reset_AT_released()
xpl_command ( "laminar/B738/push_button/at_light_pilot", 0 )
end
AT_rst_btn = button_add ( nil , nil ,712 , 59 , 54 , 53 , reset_AT_pressed, reset_AT_released ) 

-- FMC STATUS RESET  
function reset_FMC_pressed() 
xpl_command ( "laminar/B738/push_button/fms_light_pilot" )
end
FMC_rst_btn = button_add ( nil , nil ,785 , 59 , 54 , 53 , reset_FMC_pressed ) 

-- LIGHT CONTROLS
function annunc_lite_status(FLT_CON_lite, IRS_lite, FUEL_lite, ELEC_lite, APU_lite, OVHT_DET_lite, ANTI_ICE_lite, HYD_lite, DOORS_lite, ENG_lite, OVERHEAD_lite, AIR_COND_lite, ap_red_lite_on, at_red_lite_on, ap_amber_lite_on, at_amber_lite_on, ap_at_test_up, fmc_amber_lite_on, MC_lite_on, FW_lite_on ) 
visible ( flt_cont_lite , FLT_CON_lite       == 1 ) 
visible ( irs_lite , IRS_lite                == 1 )                                                                                                                                                                           
visible ( fuel_lite , FUEL_lite              == 1 )                                                                                                                                                           
visible ( elec_lite , ELEC_lite              == 1 )
visible ( apu_lite , APU_lite                == 1 )
visible ( ovht_det_lite , OVHT_DET_lite      == 1 )
visible ( anti_ice_lite , ANTI_ICE_lite      == 1 )
visible ( hyd_lite , HYD_lite                == 1 )
visible ( doors_lite , DOORS_lite            == 1 )
visible ( eng_lite , ENG_lite                == 1 )                  
visible ( overhead_lite , OVERHEAD_lite      == 1 )        
visible ( air_cond_lite , AIR_COND_lite      == 1 )        
visible ( AP_red_lite , ap_red_lite_on       == 1 )          
visible ( AT_red_lite , at_red_lite_on       == 1 )
visible ( AP_amber_lite , ap_amber_lite_on == 1 or ap_at_test_up == 1) 
visible ( AT_amber_lite , at_amber_lite_on == 1 or ap_at_test_up == 1)        
visible ( FMC_amber_lite , fmc_amber_lite_on == 1 )    
visible ( MC_lite , MC_lite_on > .1 )                 
visible ( FW_lite , FW_lite_on > .1 )                 
end

xpl_dataref_subscribe("laminar/B738/annunciator/six_pack_flt_cont", "FLOAT",
"laminar/B738/annunciator/six_pack_irs", "FLOAT",
"laminar/B738/annunciator/six_pack_fuel", "FLOAT",                                        
"laminar/B738/annunciator/six_pack_elec", "FLOAT",
"laminar/B738/annunciator/six_pack_apu", "FLOAT",
"laminar/B738/annunciator/six_pack_fire", "FLOAT",       -- OVHT DET
"laminar/B738/annunciator/six_pack_ice", "FLOAT",
"laminar/B738/annunciator/six_pack_hyd", "FLOAT",
"laminar/B738/annunciator/six_pack_doors", "FLOAT",
"laminar/B738/annunciator/six_pack_eng", "FLOAT",        
"laminar/B738/annunciator/six_pack_overhead", "FLOAT",    
"laminar/B738/annunciator/six_pack_air_cond", "FLOAT",
"laminar/B738/annunciator/ap_disconnect1", "FLOAT",      -- A/P RED:   A/P DISENGAGED - DATAREF TOGGLES (BLINKS) ON/OFF (1/0)     
"laminar/B738/annunciator/at_disconnect1", "FLOAT",      -- A/T RED:   A/T DISENGAGED - DATAREF TOGGLES (BLINKS) ON/OFF (1/0)               
"laminar/B738/annunciator/ap_warn1", "FLOAT",            -- A/P AMBER: A/P REVERTS TO CWS PITCH OR ROLL WHILE IN CMD - (BLINKS) - ADDED TO ZIBO 3.40
"laminar/B738/annunciator/at_fms_warn1", "FLOAT",        -- A/T AMBER: A/T UNABLE TO MAINTAIN DESIGNATED SPEED - (BLINKS) - ADDED TO ZIBO 3.40 - *NEEDS TESTING       
"laminar/B738/toggle_switch/ap_discon_test1", "FLOAT",   -- A/P A/T FMC LIGHT TEST TOGGLE: AMBER=1 UP   OFF=0   RED=-1 DOWN                       
"laminar/B738/annunciator/at_fms_disconnect1", "FLOAT",                    
"laminar/B738/annunciator/master_caution_light", "FLOAT",                                                           
"laminar/B738/annunciator/fire_bell_annun", "FLOAT", annunc_lite_status )


-- ENTER THE ZIBO

-- A/P A/T FMC TEST (AMBER) 
-- laminar/B738/toggle_switch/ap_disconnect_test1_up    CMD             =UP FOR AMBER CONDITION TEST
-- laminar/B738/toggle_switch/ap_discon_test1           FLOAT    R/O    =1 FOR A/P A/T FMC AMBER TEST SWITCH UP
-- laminar/B738/annunciator/ap_disconnect1              FLOAT    R/O    =1 FOR A/P AMBER (RED ALSO)
-- laminar/B738/annunciator/at_disconnect1              FLOAT    R/O    =1 FOR A/T AMBER (RED ALSO)
-- laminar/B738/annunciator/at_fms_disconnect1          FLOAT    R/O    =1 FOR FMC AMBER

-- A/P A/T FMC TEST (RED)
-- laminar/B738/toggle_switch/ap_disconnect_test1_dn    CMD             =DOWN FOR RED CONDITION TEST
-- laminar/B738/toggle_switch/ap_discon_test1           FLOAT    R/O    =-1 FOR A/P A/T (RED) FMC (AMBER) TEST SWITCH DOWN (OFF=0)
-- laminar/B738/annunciator/ap_disconnect1              FLOAT    R/O    =1 FOR A/P RED (AMBER ALSO)
-- laminar/B738/annunciator/at_disconnect1              FLOAT    R/O    =1 FOR A/T RED (AMBER ALSO)
-- laminar/B738/annunciator/at_fms_disconnect1          FLOAT    R/O    =1 FOR FMC AMBER 

-- A/P A/T FMC RESET
-- laminar/B738/push_button/ap_light_pilot              CMD            (USE BEGIN/END CMDS)
-- laminar/B738/push_button/at_light_pilot              CMD            (USE BEGIN/END CMDS)
-- laminar/B738/push_button/fms_light_pilot             CMD            (BEGIN/END NOT NEEDED)
-- laminar/B738/annunciator/ap_warn1                    FLOAT    R/O    A/P AMBER ON/OFF = 1/0 (BLINKS) ZIBO 3.40
-- laminar/B738/annunciator/at_fms_warn1             ?  FLOAT    R/O    A/T AMBER ON/OFF = 1/0 (BLINKS) ZIBO 3.40 ???
-- Laminar/B738/autopilot/ap_warn                    ?  FLOAT           =0 WHEN RESET ?
-- laminar/B738/fmc/fmc_message_warn                 ?  FLOAT           =0 WHEN RESET ?
           
-- MASTER CAUTION
-- laminar/B738/push_button/master_caution1             CMD    
-- sim/annunciator/clear_master_caution                 CMD    
-- laminar/B738/annunciator/master_caution_light        FLOAT   R/O     =1 MC ON
-- sim/cockpit/warnings/annunciators/master_caution     INT     R/W     =1 MC ON 
-- sim/cockpit2/annunciators/master_caution             INT     R/W     =1 MC ON
-- sim/annunciator/clear_master_accept               ?  CMD      
-- sim/cockpit/warnings/annunciators/master_accept   ?  INT     R/W     =1
-- sim/cockpit2/annunciators/master_accept           ?  INT     R/W     =1

-- MASTER WARNING
-- laminar/B738/push_button/fire_bell_light1            CMD     
-- sim/annunciator/clear_master_warning  (FIRE WARN)    CMD     
-- laminar/B738/annunciator/fire_bell_annun             FLOAT   R/O     =1 FW ON  

-- ALSO

-- LIGHTS
-- CMDS laminar/B738/toggle_switch/bright_test_up & laminar/B738/toggle_switch/bright_test_dn FOR FUTURE COCKPIT ANNUNCIATOR TEST PANEL
-- CMD sim/annunciator/test_all_annunciators ALSO
-- sim/cockpit2/annunciators/master_caution, INT (NOT RELIABLE-USE LAMINAR)

-- FUEL
-- sim/cockpit/warnings/annunciators/fuel_quantity INT R/W  LOW FUEL=1  OUT OF FUEL=0 

-- ELECTRICAL
-- laminar/B738/annunciator/elec











