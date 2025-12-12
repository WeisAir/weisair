-- LOAD FLAPS AUTOBRAKE PANEL           
backgrouund_img      = img_add_fullscreen ( "background.png" )              -- FLAP POSITION DIAL REDRAWN
flap_pointer_img     = img_add ( "flap_pointer.png" , 29,29, 200 , 200 )  -- 135 , 33 , 104 , 104

rotate  ( flap_pointer_img ,0 )          
rotate  ( ab_knob_img ,0 )               

-- FLAPS & SLATS INDICATORS                                                                  
function flaps (flap_deploy_ratio)        
    rotate  ( flap_pointer_img , 262 * flap_deploy_ratio ) -- 0/0  1/.125  2/.25  5/.375  10/.5   15/.625 25/.75  30/.875  40/1   (Pos/Ratio)
end                                                    -- 0/0  1/34    2/67   5/101   10/134  15/168  25/201  30/235   40/268 (Pos/Deg)
 
xpl_dataref_subscribe ( "ixeg/733/flaps_deploy_ratio", "FLOAT", flaps )