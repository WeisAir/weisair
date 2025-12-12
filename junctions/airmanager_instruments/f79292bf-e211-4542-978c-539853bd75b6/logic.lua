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

function annunc_lite_status(FLT_CON_lite, IRS_lite,FUEL_lite, ELEC_lite, APU_lite, OVHT_DET_lite, ANTI_ICE_lite, HYD_lite, DOORS_lite, ENG_lite, OVERHEAD_lite, AIR_COND_lite,MC_lite_on, FW_lite_on,ap_red_lite_on, ap_amber_lite_on, at_red_lite_on, at_amber_lite_on, fmc_amber_lite_on)
visible ( flt_cont_lite , FLT_CON_lite > 0.5)
visible ( hyd_lite , HYD_lite > 0.5 )
visible ( air_cond_lite , AIR_COND_lite > 0.5 )
visible ( overhead_lite , OVERHEAD_lite > 0.5 )
visible ( eng_lite , ENG_lite > 0.5 )
visible ( doors_lite , DOORS_lite > 0.5 )
visible ( anti_ice_lite , ANTI_ICE_lite > 0.5 )
visible ( ovht_det_lite , OVHT_DET_lite > 0.5 )
visible ( apu_lite , APU_lite > 0.5 )
visible ( elec_lite , ELEC_lite > 0.5 )
visible ( fuel_lite , FUEL_lite > 0.5 )
visible ( irs_lite , IRS_lite > 0.5 )
visible ( MC_lite, MC_lite_on > 0.5)
visible ( fire_warn_lite, FW_lite_on > 0.5)

end

xpl_dataref_subscribe( "ixeg/733/caution/caution_fltcont_ann" , "FLOAT" , 
"ixeg/733/caution/caution_irs_ann" , "FLOAT" , 
"ixeg/733/caution/caution_fuel_ann" , "FLOAT" ,
"ixeg/733/caution/caution_elec_ann" , "FLOAT" ,
"ixeg/733/caution/caution_apu_ann" , "FLOAT" ,
"ixeg/733/caution/caution_ovhtdet_ann" , "FLOAT" , 
"ixeg/733/caution/caution_antiice_ann" , "FLOAT" ,
"ixeg/733/caution/caution_hyd_ann" , "FLOAT" ,
"ixeg/733/caution/caution_doors_ann" , "FLOAT" , 
"ixeg/733/caution/caution_eng_ann" , "FLOAT" ,
"ixeg/733/caution/caution_overhead_ann" , "FLOAT" , 
"ixeg/733/caution/caution_aircond_ann" , "FLOAT" , 
"ixeg/733/bleedair/caution_master_ann" , "FLOAT",
"ixeg/733/firewarning/fire_warning_ann" , "FLOAT", annunc_lite_status )
