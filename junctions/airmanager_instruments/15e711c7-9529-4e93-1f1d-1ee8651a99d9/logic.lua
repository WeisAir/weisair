-- This is a modification of Russ Barlow's EADT x737NG annunciator panel that converts it for use with the ZiboMod 737.
-- It uses ZIBO datarefs and commands and will only work correctly with the ZIBO 737. 
-- Tested with ZiboMod 737-800 v.3.40 and Air Manager 3.7.
-- GoodSim 5/28/20

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

-- LIGHT CONTROLS
function annunc_lite_status(FLT_CON_lite, IRS_lite, FUEL_lite, ELEC_lite, APU_lite, OVHT_DET_lite, ANTI_ICE_lite, HYD_lite, DOORS_lite, ENG_lite, OVERHEAD_lite, AIR_COND_lite) 
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
annunc_lite_status )
