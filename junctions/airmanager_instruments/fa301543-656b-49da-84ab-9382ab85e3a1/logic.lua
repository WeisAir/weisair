-- This is a modification of GoodSim (5/28/20) and Russ Barlow's EADT x737NG annunciator panel that converts it for use with the ZiboMod 737.
-- It uses ZIBO datarefs and commands and will only work correctly with the ZIBO 737. 
-- It was strictly reduced to the sixpack only different from the original version
-- WeisAir 01/13/2025

my_image = img_add_fullscreen("background_rect.png")
local add_frame = user_prop_add_boolean("Add Frame to Annunciator", true, "Shows a tiny frame around the annunciator on demand.")

if user_prop_get(add_frame) == true then
    annunciator_inactive = img_add("ann_inactive.png",3,3,120,60) 

else
    annunciator_inactive = img_add_fullscreen("ann_inactive.png")
end 

flt_cont_lite  = img_add ( "flt_cont.png" , 3 , 3 , 62   , 20, "visible:false" )
elec_lite      = img_add ( "elec.png" ,     65 , 3 , 60  , 20, "visible:false" )
irs_lite       = img_add ( "irs.png" ,      3 , 23 , 60  , 20, "visible:false" )
apu_lite       = img_add ( "apu.png" ,      63 , 23 , 60 , 20, "visible:false" )
fuel_lite      = img_add ( "fuel.png" ,     3 , 44 , 53  , 18, "visible:false" )
ovht_det_lite  = img_add ( "ovht_det.png" , 57 , 43 , 65 , 20, "visible:false" )

function press_six()                                    
    xpl_command ( "WeisAIR/b733/mcp/sixpack_pilot_recall_push") 
end
function release_six()                                 
    xpl_command ( "WeisAIR/b733/mcp/sixpack_pilot_recall_release") 
end  
six_pack = button_add ( nil  ,"six_test_cpt.png" , 3,3,120,60  , press_six, release_six )  

function annunc_lite_status(FLT_CON_lite, IRS_lite, FUEL_lite, ELEC_lite, APU_lite, OVHT_DET_lite, ANTI_ICE_lite, HYD_lite, DOORS_lite, ENG_lite, OVERHEAD_lite, AIR_COND_lite) 
visible ( flt_cont_lite , FLT_CON_lite       > 0.0 ) 
visible ( irs_lite , IRS_lite                > 0.0 )                                                                                                                                                                           
visible ( fuel_lite , FUEL_lite              > 0.0 )                                                                                                                                                           
visible ( elec_lite , ELEC_lite              > 0.0 )
visible ( apu_lite , APU_lite                > 0.0 )
visible ( ovht_det_lite , OVHT_DET_lite      > 0.0 )         
end

xpl_dataref_subscribe("ixeg/733/caution/caution_fltcont_ann", "FLOAT",
"ixeg/733/caution/caution_irs_ann", "FLOAT",
"ixeg/733/caution/caution_fuel_ann", "FLOAT",                                        
"ixeg/733/caution/caution_elec_ann", "FLOAT",
"ixeg/733/caution/caution_apu_ann", "FLOAT",
"ixeg/733/caution/caution_ovhtdet_ann", "FLOAT",
annunc_lite_status )