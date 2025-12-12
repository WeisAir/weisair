image_id = img_add_fullscreen ( "Annunciator_Panel_bkgnd.png" )

MC_lite = img_add ( "MC_lite.png" , 108 , 35 , 77 , 76 )
fire_warn_lite = img_add ( "fire_warn.png" , 18 , 35 , 78 , 76 )
AP_red_lite = img_add ( "AP_red.png" , 641 , 59 , 53 , 53 )
AT_red_lite = img_add ( "AT_red.png" , 712 , 59 , 54 , 53 )
AP_amber_lite = img_add ( "AP_amber.png" , 641 , 59 , 53 , 53 )
AT_amber_lite = img_add ( "AT_amber.png" , 712 , 59 , 54 , 53 )
FMC_amber_lite = img_add ( "FMC_amber.png" , 785 , 59 , 54 , 53 )
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
xpl_dataref_write ( "x737/cockpit/warningSys/sysAnn_capt" , "FLOAT" , 1 )
end
function release_twelve()
xpl_dataref_write ( "x737/cockpit/warningSys/sysAnn_capt" , "FLOAT" , 0 )
end

twelve_pack = button_add (  nil   ,"twelve_test.png" , 210 , 29 , 389 , 88  , press_twelve, release_twelve )


visible( AP_amber_lite,false)
visible( AT_amber_lite,false)
visible( AP_red_lite,false)
visible( AT_red_lite,false)
visible( FMC_amber_lite,false)


function  test_up_hold()
xpl_dataref_write ( "x737/systems/afds/alert/capt/autoflAnnLightTest" , "FLOAT" , 1 )
end

function test_off()
xpl_dataref_write ( "x737/systems/afds/alert/capt/autoflAnnLightTest" , "FLOAT" , 0 )
end

function  test_dn_hold()
xpl_dataref_write ( "x737/systems/afds/alert/capt/autoflAnnLightTest" , "FLOAT" , -1 )
end

up_sw=  button_add ("switchmid_1.png", "switchup_1.png", 852 , 43 , 46 , 54, test_up_hold, test_off)
dn_sw= button_add ( nil, "switchdn_1.png"  , 852 , 77 , 46 , 54, test_dn_hold, test_off)


function  click_MC()
xpl_dataref_write ( "x737/cockpit/warningSys/MASTER_CAUTION_capt" , "FLOAT" , 1 )
end

function release_MC()
xpl_dataref_write ( "x737/cockpit/warningSys/MASTER_CAUTION_capt" , "FLOAT" , 0 )
end

MC_prst = button_add ( nil  , nil ,108 , 35 , 77 , 76 , click_MC, release_MC )

--	x737/cockpit/warningSys/MASTER_CAUTION_capt	float	y	MASTER CAUTION button state - captain's side.Pass 1 to press and 0 to release.
function  reset_AP_pressed()
xpl_dataref_write ( "x737/systems/afds/alert/capt/AP_PRST_reset" , "FLOAT" , 1 )
end

function  reset_AP_released()
xpl_dataref_write ( "x737/systems/afds/alert/capt/AP_PRST_reset" , "FLOAT" , 0 )
end

AP_rst_btn = button_add ( nil , nil ,641 , 59 , 53 , 53 , reset_AP_pressed, reset_AP_released )

function  reset_AT_pressed()
xpl_dataref_write ( "x737/systems/afds/alert/capt/AT_PRST_reset" , "FLOAT" , 1 )
end

function  reset_AT_released()
xpl_dataref_write ( "x737/systems/afds/alert/capt/AT_PRST_reset" , "FLOAT" , 0 )
end

AT_rst_btn = button_add ( nil , nil ,712 , 59 , 54 , 53 , reset_AT_pressed, reset_AT_released )


function  reset_FMC_pressed()
xpl_dataref_write ( "x737/systems/afds/alert/capt/FMC_PRST_reset" , "FLOAT" , 1 )
end

function  reset_FMC_released()
xpl_dataref_write ( "x737/systems/afds/alert/capt/FMC_PRST_reset" , "FLOAT" , 0 )
end

FMC_rst_btn = button_add ( nil , nil ,785 , 59 , 54 , 53 , reset_FMC_pressed, reset_FMC_released )
--  MASTER CAUTION button 

--function new_MC ( state )
--if state >= 1 then
--visible ( MC_lite , true )
--mc_flagged=1
--else
--visible ( MC_lite , false )
--mc_flagged=0
--end
--end	
--
--xpl_dataref_subscribe( "sim/cockpit2/annunciators/master_caution" , "INT" ,  new_MC )
----xpl_dataref_subscribe( "x737/cockpit/warningSys/MASTER_CAUTION_capt_light" , "FLOAT" ,  new_MC )
--


--	MASTER FIRE button 

function new_fire ( state )

--visible ( fire_warn_lite , state > 0.1 )
end	

--xpl_dataref_subscribe( "x737/cockpit/warningSys/FIRE_WARN_capt_light" , "FLOAT" ,  new_fire )

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
visible ( AP_amber_lite , ap_amber_lite_on == 1 )
visible ( AP_red_lite , ap_red_lite_on == 1 )
visible ( AT_red_lite , at_red_lite_on == 1 )
visible ( AT_amber_lite , at_amber_lite_on == 1 )
visible ( FMC_amber_lite , fmc_amber_lite_on== 1 )--
visible ( MC_lite , MC_lite_on > .1 )
end

xpl_dataref_subscribe( "x737/cockpit/warningSys/sysAnnFLT_CONT" , "INT" , 
"x737/cockpit/warningSys/sysAnnIRS" , "INT" , 
"x737/cockpit/warningSys/sysAnnFUEL" , "INT" ,
"x737/cockpit/warningSys/sysAnnELEC" , "INT" ,
"x737/cockpit/warningSys/sysAnnAPU" , "INT" ,
"x737/cockpit/warningSys/sysAnnOVHT_DET" , "INT" , 
"x737/cockpit/warningSys/sysAnnANTI_ICE" , "INT" ,
"x737/cockpit/warningSys/sysAnnHYD" , "INT" ,
"x737/cockpit/warningSys/sysAnnDOORS" , "INT" , 
"x737/cockpit/warningSys/sysAnnENG" , "INT" ,
"x737/cockpit/warningSys/sysAnnOVERHEAD" , "INT" , 
"x737/cockpit/warningSys/sysAnnAIR_COND" , "INT" , 
"x737/systems/afds/alert/capt/AP_PRST_red" , "INT" ,
"x737/systems/afds/alert/capt/AP_PRST_amber" , "INT" ,
"x737/systems/afds/alert/capt/AT_PRST_red" , "INT" ,
"x737/systems/afds/alert/capt/AT_PRST_amber" , "INT" , 
"x737/systems/afds/alert/capt/FMC_PRST_amber" , "INT" ,
"x737/cockpit/warningSys/MASTER_CAUTION_capt_light" , "FLOAT",
annunc_lite_status )


--FIRE WARNING RESET


function  reset_fire_warn()
--visible (fire_warn_lite , false )
end

fire_reset_btn = button_add ( nil  , nil , 18 , 35 , 78 , 76 , reset_fire_warn )



--	x737/systems/afds/alert/capt/AP_PRST_red	int	n	Read the state of the red AP P/RST light (boolean), captain's side: 0: OFF, 1: red ON.
--	x737/systems/afds/alert/capt/AP_PRST_amber	int	n	Read the state of the amber AP P/RST light (boolean), captain's side: 0: OFF, 1: amber ON.
--	x737/systems/afds/alert/capt/AP_PRST_level	int	n	Read the level state of the amber AP P/RST alert, captain's side: 0: no alert, 1: amber on, 2: red intermittent, 3: red continuos.




--	x737/systems/afds/alert/capt/AT_PRST_red	int	n	Read the state of the red AT P/RST light (boolean), captain's side: 0: OFF, 1: red ON.
--	x737/systems/afds/alert/capt/AT_PRST_amber	int	n	Read the state of the amber AT P/RST light (boolean), captain's side: 0: OFF, 1: amber ON.

--  x737/systems/afds/alert/capt/FMC_PRST_amber	int	n	Read the state of the amber FMC P/RST light (boolean), captain's side: 0: OFF, 1: amber ON.
	
--	x737/cockpit/warningSys/MASTER_CAUTION_capt	float	y	MASTER CAUTION button state - captain's side.Pass 1 tp press and 0 to release.
--	x737/cockpit/warningSys/FIRE_WARN_capt	float	y	MASTER CAUTION button state - captain's side.Pass 1 tp press and 0 to release.
--	x737/cockpit/warningSys/sysAnn_capt	float	y	System warnings annunciator (sixpack) button state - captain's side.Pass 1 tp press and 0 to release.
--	x737/cockpit/warningSys/sysAnn_fo	float	y	System warnings annunciator (sixpack) - fo's side.Pass 1 tp press and 0 to release.
--  x737/cockpit/warningSys/FIRE_WARN_capt	float	rw	MASTER CAUTION button state - captain's side.Pass 1 tp press and 0 to release.
--


--	x737/systems/afds/alert/capt/AP_PRST_reset	float	y	Read and write the AP P/RST button state, captain's side: 0: released, 1: pressed.
--	x737/systems/afds/alert/capt/AT_PRST_reset
--	x737/systems/afds/alert/capt/FMC_PRST_reset
--	x737/systems/afds/alert/capt/autoflAnnLightTest	float	y	Read and write the autoflight switch state, captain's side: 0: released, 1: up to pos '1', 2: down to position 2.