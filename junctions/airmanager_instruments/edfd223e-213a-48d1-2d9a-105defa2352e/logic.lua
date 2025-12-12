prop_engine_sel = user_prop_add_enum("Engine side", "L,R", "L","Choose the engine side")

-- IMAGES
img_add_fullscreen("eng_rpm_bg.png")
img_needle = img_add("eng_rpm_needle.png", -55, -50, 600,600)
	
prop_engine_sel = user_prop_get(prop_engine_sel)

function eng_rpms(rpm_l, rpm_r)
    
	if prop_engine_sel == "L" then rotate(img_needle, (239 / 110 * rpm_l) - 1) end	
	if prop_engine_sel == "R" then rotate(img_needle, (239 / 110 * rpm_r) - 1) end	
    
end

xpl_dataref_subscribe( 
"LES/saab/engine_pct_rpm_L" , "FLOAT", 
"LES/saab/engine_pct_rpm_R", "FLOAT",
eng_rpms)

