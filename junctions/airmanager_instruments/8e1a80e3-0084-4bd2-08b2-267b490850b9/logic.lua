-- This is a modification of Russ Barlow's EADT x737NG speedbrake panel that converts it for use with the ZIiboMod 737.
-- It uses ZIBO datarefs and will only work correctly with the ZIBO 737. 
-- Tested with ZIiboMod 737-800 v.3.40 and Air Manager 3.7.
-- GoodSim 5/28/20

-- LOAD PANEL
background_image = img_add_fullscreen ( "background.png" )
sb_extended_on   = img_add ( "sb_extended_lite.png" , 116 , 84 , 133 , 60, "visible:false" )
sb_armed_on      = img_add ( "sb_armed_lite.png" , 328 , 16 , 132 , 60, "visible:false" )
sb_do_not_arm_on = img_add ( "sb_do_not_arm_lite.png" , 328 , 81 , 132 , 60, "visible:false" )

function sb_functions ( sb_armed , sb_dn_arm , sb_extended)  
    visible ( sb_armed_on ,       sb_armed == 1 )
    visible ( sb_do_not_arm_on , sb_dn_arm == 1 )
    visible ( sb_extended_on , sb_extended == 1 )
end

xpl_dataref_subscribe ( "laminar/B738/annunciator/speedbrake_armed", "FLOAT", 
                        "laminar/B738/annunciator/spd_brk_not_arm", "FLOAT", 
                        "laminar/B738/annunciator/speedbrake_extend", "FLOAT", sb_functions )