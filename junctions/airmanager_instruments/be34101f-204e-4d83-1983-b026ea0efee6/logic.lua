background_image = img_add_fullscreen ( "background.png" )
hdg_yellow_dot = img_add ( "yellow_dot.png" , 83 ,30 , 8 , 8 )
nav_yellow_dot = img_add ( "yellow_dot.png" , 245 ,30 , 8 , 8 )
appr_yellow_dot = img_add ( "yellow_dot.png" , 410 ,30 , 8 , 8 )
vs_yellow_dot = img_add ( "yellow_dot.png"  , 83 ,108 , 8 , 8 )
ias_yellow_dot = img_add ( "yellow_dot.png"  , 164 ,108 , 8 , 8 )
climb_yellow_dot = img_add ( "yellow_dot.png"  , 245 ,108 , 8 , 8 )
alt_yellow_dot = img_add ( "yellow_dot.png" , 410 ,108 , 8 , 8 )


function ap_modes (hdg, nav, appr, vs, ias, climb, alt)
visible ( hdg_yellow_dot , hdg >= 0.1 )
visible ( nav_yellow_dot , nav >= 0.1 )
visible ( appr_yellow_dot , appr >= 0.1 )
visible ( vs_yellow_dot , vs >= 0.1 )
visible ( ias_yellow_dot , ias >= 0.1 )
visible ( climb_yellow_dot , climb >= 0.1 )
visible ( alt_yellow_dot , alt >= 0.1 )

end

xpl_dataref_subscribe( 
"les/sf34a/acft/ltng/lit/msp_hdg_buttonlight" , "FLOAT" , 
"les/sf34a/acft/ltng/lit/msp_nav_buttonlight", "FLOAT", 
"les/sf34a/acft/ltng/lit/msp_appr_buttonlight", "FLOAT", 
"les/sf34a/acft/ltng/lit/msp_vs_buttonlight" , "FLOAT", 
"les/sf34a/acft/ltng/lit/msp_ias_buttonlight", "FLOAT",
"les/sf34a/acft/ltng/lit/msp_climb_buttonlight", "FLOAT",
"les/sf34a/acft/ltng/lit/msp_alt_buttonlight", "FLOAT",
ap_modes)
