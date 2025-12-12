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

anti_ice_lite  = img_add ( "anti_ice.png" 	, 3,	3,65, 20, "visible:false" )
eng_lite       = img_add ( "eng.png" 		, 69, 	3,55, 20, "visible:false" )
hyd_lite       = img_add ( "hyd.png" 		, 3, 	23 ,50, 20, "visible:false" )
overhead_lite  = img_add ( "overhead.png" 	, 53, 	23 ,70 , 20, "visible:false" )
doors_lite     = img_add ( "doors.png" 		, 3, 	44 ,53  , 18, "visible:false" )
air_cond_lite  = img_add ( "air_cond.png" 	, 58, 	43 ,65 , 20, "visible:false" )

function press_six()                                    
    xpl_command ( "WeisAIR/b733/mcp/sixpack_copilot_recall_push") 
end
function release_six()                                 
    xpl_command ( "WeisAIR/b733/mcp/sixpack_copilot_recall_release") 
end  
six_pack = button_add ( nil  ,"six_test_fo.png" , 3,3,120,60  , press_six, release_six )  

function annunc_lite_status(ANTI_ICE_lite, HYD_lite, DOORS_lite, ENG_lite, OVERHEAD_lite, AIR_COND_lite) 
visible ( anti_ice_lite , ANTI_ICE_lite      > 0.0 )
visible ( hyd_lite , HYD_lite                > 0.0 )
visible ( doors_lite , DOORS_lite            > 0.0 )
visible ( eng_lite , ENG_lite                > 0.0 )                  
visible ( overhead_lite , OVERHEAD_lite      > 0.0 )        
visible ( air_cond_lite , AIR_COND_lite      > 0.0 )          
end

xpl_dataref_subscribe(
"ixeg/733/caution/caution_antiice_ann", "FLOAT",
"ixeg/733/caution/caution_hyd_ann", "FLOAT",
"ixeg/733/caution/caution_doors_ann", "FLOAT",
"ixeg/733/caution/caution_eng_ann", "FLOAT",        
"ixeg/733/caution/caution_overhead_ann", "FLOAT",    
"ixeg/733/caution/caution_aircond_ann", "FLOAT",
annunc_lite_status )