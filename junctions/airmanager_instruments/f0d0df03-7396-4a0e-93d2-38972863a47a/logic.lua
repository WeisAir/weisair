background_image = img_add_fullscreen ( "background.png" )
sb_extended_on = img_add ( "sb_extended_lite.png" , 116 , 84 , 133 , 60 )
sb_armed_on = img_add ( "sb_armed_lite.png" , 328 , 16 , 132 , 60 )
sb_do_not_arm_on = img_add ( "sb_do_not_arm_lite.png" , 328 , 81 , 132 , 60 )

function sb_functions ( sb_armed , sb_dn_arm , sb_extended)
visible ( sb_armed_on , sb_armed == 1 )
visible ( sb_do_not_arm_on , sb_dn_arm == 1 )
visible ( sb_extended_on , sb_extended == 1 )
end

xpl_dataref_subscribe( "x737/systems/speedbrake/spdbrkIsArmedLight" , "INT" ,  "x737/systems/speedbrake/spdbrkDoNotArmLight" , "INT" , "x737/systems/speedbrake/spdbrkExtendedLight" , "INT" ,  sb_functions )



--255	x737/systems/speedbrake/spdbrkIsArmedLight	int	r	Read x737 SPEEDBRAKE ARMED light (green, left main panel) state: '0': off, '1': on.
---256	x737/systems/speedbrake/spdbrkExtendedLight	int	r	Read x737 SPEEDBRAKE EXTENDED light (amber, right main panel) state: '0': off, '1': on.
--257	x737/systems/speedbrake/spdbrkDoNotArmLight	int	r	Read x737 SPEEDBRAKE DO NOT ARM light state: '0': off, '1': on.