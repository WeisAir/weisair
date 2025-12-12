-- Boeing B47 Eng Oil press panel

img_add_fullscreen("background.png")
needle1L= img_add("needle.png",20, 20, 260, 260)
needle2L= img_add("needle.png",300, 20, 260, 260)
needle3L= img_add("needle.png",580, 20, 260, 260)
needle4L= img_add("needle.png",860, 20, 260, 260)
needle5L= img_add("needle.png",1140, 20, 260, 260)
needle6L= img_add("needle.png",1420, 20, 260, 260)
img_add_fullscreen("bezel.png")


	function OILP(press)
	rotate(needle1L,press[1]*6.55)	
	
	rotate(needle2L,press[2]*6.55)	
	
	rotate(needle3L,press[3]*6.55)	
	
	rotate(needle4L,press[4]*6.55)	
	
	rotate(needle5L,press[5]*6.55)
	
	rotate(needle6L,press[6]*6.55)
	
	end


xpl_dataref_subscribe("sim/cockpit2/engine/indicators/oil_pressure_psi", "FLOAT[8]", OILP)