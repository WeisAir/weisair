image_id = img_add_fullscreen ( "annunciator_background1.png" )

MC_lite = img_add ( "MC_lite.png" , 108 , 35 , 77 , 76 )
fire_warn_lite = img_add ( "fire_warn.png" , 18 , 35 , 78 , 76 )
flt_cont_lite = img_add ( "flt_cont.png" , 210 , 29 , 94 , 29 )
elec_lite = img_add ( "elec.png" , 304 , 29 , 84 , 29 )
anti_ice_lite = img_add ( "anti_ice.png" , 421 , 28 , 100 , 30 )
eng_lite = img_add ( "eng.png" , 521 , 28 , 79 , 30 )
irs_lite = img_add ( "irs.png" , 210 , 58 , 89 , 30 )
apu_lite = img_add ( "apu.png" , 299 , 58 , 89 , 30 )
hyd_lite = img_add ( "hyd.png" , 421 , 58 , 75 , 30 )
overhead_lite = img_add ( "overhead.png" , 496 , 58 , 104 , 30 )
fuel_lite = img_add ( "fuel.png" , 210 , 88 , 79 , 28 )
ovht_det_lite = img_add ( "ovht_det.png" , 289 , 88 , 99 , 28 )
doors_lite = img_add ( "doors.png" , 421 , 88 , 80 , 29 )
air_cond_lite = img_add ( "air_cond.png" , 501 , 88 , 99 , 29 )
visible (fire_warn_lite, false)

function  press_twelve()
xpl_command ( "laminar/B738/push_button/capt_six_pack" , 1 )
end
function release_twelve()
xpl_command ( "laminar/B738/push_button/capt_six_pack"  , 0 )
end

twelve_pack = button_add (  nil   ,"twelve_test.png" , 210 , 29 , 389 , 88  , press_twelve, release_twelve )


function  click_MC()
xpl_command( "laminar/B738/push_button/master_caution1" , 1 )
end

function release_MC()
xpl_command( "laminar/B738/push_button/master_caution1" ,0 )
end

MC_prst = button_add ( nil  , nil ,108 , 35 , 77 , 76 , click_MC, release_MC )

-- Master Caution monitor
function set_MC (condition)
visible( MC_lite, condition > 0)
end

xpl_dataref_subscribe("laminar/B738/annunciator/master_caution_light", "FLOAT", set_MC)
--	MASTER FIRE button 

function new_fire ( state )

visible ( fire_warn_lite , state > 0 )
end	

xpl_dataref_subscribe( "laminar/B738/annunciator/fire_bell_annun" , "FLOAT" ,  new_fire )

function annunc_lite_status(FLT_CON_lite, IRS_lite,FUEL_lite, ELEC_lite, APU_lite, OVHT_DET_lite, ANTI_ICE_lite, HYD_lite, DOORS_lite, ENG_lite, OVERHEAD_lite, AIR_COND_lite,ap_red_lite_on, ap_amber_lite_on, at_red_lite_on, at_amber_lite_on, fmc_amber_lite_on, MC_lite_on )
visible ( flt_cont_lite , FLT_CON_lite == 1)
visible ( hyd_lite , HYD_lite == 1 )
visible ( air_cond_lite , AIR_COND_lite == 1 )
visible ( overhead_lite , OVERHEAD_lite == 1 )
visible ( eng_lite , ENG_lite == 1 )
visible ( doors_lite , DOORS_lite == 1 )
visible ( anti_ice_lite , ANTI_ICE_lite == 1 )
visible ( ovht_det_lite , OVHT_DET_lite == 1 )
visible ( apu_lite , APU_lite == 1 )
visible ( elec_lite , ELEC_lite == 1 )
visible ( fuel_lite , FUEL_lite == 1 )
visible ( irs_lite , IRS_lite == 1 )

end

xpl_dataref_subscribe( "laminar/B738/annunciator/six_pack_flt_cont" , "FLOAT" , 
"laminar/B738/annunciator/six_pack_irs" , "FLOAT" , 
"laminar/B738/annunciator/six_pack_fuel" , "FLOAT" ,
"laminar/B738/annunciator/six_pack_elec" , "FLOAT" ,
"laminar/B738/annunciator/six_pack_apu" , "FLOAT" ,
"laminar/B738/annunciator/six_pack_fire" , "FLOAT" , 
"laminar/B738/annunciator/six_pack_ice" , "FLOAT" ,
"laminar/B738/annunciator/six_pack_hyd" , "FLOAT" ,
"laminar/B738/annunciator/six_pack_doors" , "FLOAT" , 
"laminar/B738/annunciator/six_pack_eng" , "FLOAT" ,
"laminar/B738/annunciator/six_pack_overhead" , "FLOAT" , 
"laminar/B738/annunciator/six_pack_air_cond" , "FLOAT" , 
"laminar/B738/annunciator/master_caution_light" , "FLOAT", annunc_lite_status )


--FIRE WARNING RESET


function  press_fire_warn()
xpl_command("laminar/B738/push_button/fire_bell_light1", 1)
end

function  rls_fire_warn()
xpl_command("laminar/B738/push_button/fire_bell_light1", 0)
end

fire_reset_btn = button_add ( nil  , nil , 18 , 35 , 78 , 76 , press_fire_warn , rls_fire_warn)

