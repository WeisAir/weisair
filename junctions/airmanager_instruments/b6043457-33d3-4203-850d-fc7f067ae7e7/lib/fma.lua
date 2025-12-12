--THIS LIBRARY IS MANAGING THE FMA AT THE TOP OF THE PFD****************************************************


function lib_fma_init()

--Flight Mode Annunciator

--Images for FMA
--img_squarebox1_white = img_add("alt_modes-white.png", 150, 30, 154, 32)
img_squarebox0_green = img_add("alt_modes-green.png", 150, 30, 154, 32)
img_squarebox1_green = img_add("alt_modes-green.png", 150, 30, 154, 32)
img_squarebox2_green = img_add("alt_modes-green.png", 306, 30, 176, 32)
img_squarebox3_green = img_add("alt_modes-green.png", 484, 30, 154, 32)

visible(img_squarebox0_green,false)
visible(img_squarebox1_green,false)
visible(img_squarebox2_green,false)
visible(img_squarebox3_green,false)

--Text for First Column(speed mode)
--------------------------------------------------------------------------------------------------------------------------
txt_fma1_at = txt_add("ARM", "size:24px; font:BCG.ttf; color: white; halign:left;", 200, 35, 100, 200)
txt_fma1_N1 = txt_add("N1", "font:BCG.ttf;size:24px; color: lime; halign:left;", 210, 35, 100, 110)
txt_fma1_mcpspd = txt_add("MCP SPD", "size:24px; font:BCG.ttf; color: lime; halign:left;", 173, 35, 200, 200)
txt_fma1_ga = txt_add("GA", "size:24px; font:BCG.ttf; color: lime; halign:left;", 215, 35, 100, 100)
txt_fma1_fmcspd = txt_add("FMC SPD", "size:24px; font:BCG.ttf; color: lime; halign:left;", 173, 35, 200, 200)
txt_fma1_thrhld = txt_add("THR HLD", "size:24px; font:BCG.ttf; color: lime; halign:left;", 175, 35, 110, 100)visible(txt_fma1_thrhld, false)
txt_fma1_retard = txt_add("RETARD", "size:24px; font:BCG.ttf; color: lime; halign:left;", 183, 35, 120, 100)

--Text for Second Column(roll mode)
-----------------------------------------------------------------------------------------------------------------------
txt_fma2_hdgsel = txt_add("HDG SEL", "size:24px; font:BCG.ttf; color:  lime;  halign:left;", 345, 35, 100, 100)
txt_fma2_vorlocg = txt_add("VOR/LOC", "size:24px; font:BCG.ttf; color:  lime;  halign:left;", 343, 35, 200, 200)
txt_fma2_lnavg = txt_add("LNAV", "size:24px; font:BCG.ttf; color:  lime;  halign:left;", 365, 35, 200, 200)
txt_fma2_vorlocw = txt_add("VOR/LOC", "size:20px; font:BCG.ttf; color:  white;  halign:left;", 353, 70, 100, 100)
txt_fma2_lnavw = txt_add("LNAV", "size:20px; font:BCG.ttf; color:  white;  halign:left;", 370, 65, 100, 100)
txt_fma2_rolloutw = txt_add("ROLOUT", "size:20px; font:BCG.ttf; color:  white;  halign:left;", 360, 65, 200, 200)
txt_fma2_rolloutg = txt_add("ROLLOUT", "size:24px; font:BCG.ttf; color:  lime;  halign:left;", 343, 35, 150, 150)
txt_fma2_facw = txt_add("FAC", "size:20px; font:BCG.ttf; color:  white;  halign:left;", 380, 65, 100, 100)
txt_fma2_facg = txt_add("FAC", "size:24px; font:BCG.ttf; color:  lime;  halign:left;", 370, 35, 100, 100)

--Text for Third Column(pitch mode)
------------------------------------------------------------------------------------------------------------------------
txt_fma3_apVnav_white = txt_add("VNAV", "size:20px; font:BCG.ttf; color: white ;  halign:right;", 485, 65, 100, 100)
txt_fma3_apToGa = txt_add("TO/GA", "size:24px; font:BCG.ttf; color: lime ;  halign:right;", 485, 35, 110, 100)
txt_fma3_apAltHld = txt_add("ALT HLD", "size:24px; font:BCG.ttf; color: lime ;  halign:right;", 500, 35, 110, 100)
txt_fma3_apVS_green = txt_add("V/S", "size:24px; font:BCG.ttf; color: lime ;  halign:right;", 470, 35, 110, 100)
txt_fma3_apMcpSpd = txt_add("MCP SPD", "size:24px; font:BCG.ttf; color: lime ;  halign:right;", 480, 35, 130, 100)
txt_fma3_apAltAcq = txt_add("ALT ACQ", "size:24px; font:BCG.ttf; color: lime ;  halign:right;", 460, 35, 150, 100)
txt_fma3_apGS_green = txt_add("G/S", "size:24px; font:BCG.ttf; color: lime ;  halign:right;", 375, 35, 210, 100)
txt_fma3_apFlare_white = txt_add("FLARE", "size:20px; font:BCG.ttf; color: white ;  halign:right;", 390, 65, 200, 100)
txt_fma3_apVnavSpd = txt_add("VNAV SPD", "size:24px; font:BCG.ttf; color: lime ;  halign:right;", 480, 35, 140, 100)
txt_fma3_apVnavPth = txt_add("VNAV PTH", "size:24px; font:BCG.ttf; color: lime ;  halign:right;", 430, 35, 190, 100)
txt_fma3_apVnavAlt = txt_add("VNAV ALT", "size:24px; font:BCG.ttf; color: lime ;  halign:right;", 480, 35, 140, 100) 
txt_fma3_apVS_white = txt_add("V/S", "size:20px; font:BCG.ttf; color: white ;  halign:right;", 380, 65, 200, 100)
txt_fma3_apGS_white = txt_add("G/S", "size:20px; font:BCG.ttf; color: white ;  halign:right;", 380, 65, 200, 100)
txt_fma3_apGP = txt_add("G/P", "size:24px; font:BCG.ttf; color: lime ;  halign:right;", 485, 35, 100, 100)
txt_fma3_apFlare_green = txt_add("FLARE", "size:24px; font:BCG.ttf; color: lime ;  halign:right;", 485, 35, 110, 100)
txt_fma3_apGP_white = txt_add("G/P", "size:20px; font:BCG.ttf; color: white ;  halign:right;", 380, 65, 200, 100)
----------------------------------------------------------------------------------------------------------------------------


--*************FMA -----FLIGHT MODE ANNUNCIATOR**********************************************	
--First Column FMA
function first_column_fma(pfd_spd_mode, square1g, square1w)

	--if square1w == 1 then visible(img_squarebox1_white,true) else visible(img_squarebox1_white,false) end
	if square1g == 1 then visible(img_squarebox1_green,true) else visible(img_squarebox1_green,false) end
	if square1w == 1 then visible(img_squarebox0_green,true) else visible(img_squarebox0_green,false) end
	
	if pfd_spd_mode == 1 then
		visible(txt_fma1_at, true)    		  --AT armed
	else
		visible(txt_fma1_at, false)
	end
	
	if pfd_spd_mode == 2 then                 --N1
		visible(txt_fma1_N1,true)
	else	
		visible(txt_fma1_N1,false)
	end

	if pfd_spd_mode == 3 then				   --mcp spd
		visible(txt_fma1_mcpspd, true)
	else
		visible(txt_fma1_mcpspd, false)
	end
	
	if pfd_spd_mode == 4 then					--fmc spd
		visible(txt_fma1_fmcspd,true)
	else
		visible(txt_fma1_fmcspd,false)
	end
	
	if pfd_spd_mode == 5 then					--GA
		visible(txt_fma1_ga,true)
	else
		visible(txt_fma1_ga,false)
	end
	
	if pfd_spd_mode == 6 then					--thr hld
		visible(txt_fma1_thrhld,true)
	else
		visible(txt_fma1_thrhld,false)
	end

	if pfd_spd_mode == 7 then					--retard
		visible(txt_fma1_retard,true)
	else
		visible(txt_fma1_retard,false)
	end
	
end
--first_column_fma(pfd_spd_mode, square1g, square1w)
xpl_dataref_subscribe("laminar/B738/autopilot/pfd_spd_mode", "INT",						--pfd_spd_mode    at=1  n1=2  mcp spd=3
					  "laminar/B738/autopilot/rec_thr2_modes", "INT",					--square1g
					  "laminar/B738/autopilot/rec_thr_modes", "INT", first_column_fma)	--square1w
-------------------------------------------------------------------------------------------------------------------
	
--Second Column FMA
function second_column_fma(pfd_hdg_mode, vorloc, pfd_hdg_mode_arm, alt, square2g)

	if square2g == 1 then visible(img_squarebox2_green,true) else visible(img_squarebox2_green,false) end
 	
	if vorloc == 1 and pfd_hdg_mode_arm == 1 then	--vor loc white
		visible(txt_fma2_vorlocw,true)
	else
		visible(txt_fma2_vorlocw,false)
	end
	
	if pfd_hdg_mode_arm == 2 then					--rollout white
		visible(txt_fma2_rolloutw,true)
	else
		visible(txt_fma2_rolloutw,false)
	end
	
	if pfd_hdg_mode_arm == 3 then					--lnav white
		visible(txt_fma2_lnavw,true)
	else
		visible(txt_fma2_lnavw,false)
	end
	
	if pfd_hdg_mode_arm == 4 then						--fac white
		visible(txt_fma2_facw,true)
	else
		visible(txt_fma2_facw,false)
	end
	
--*********************************************************************************************
	
	if  pfd_hdg_mode == 1 then							--hdg sel
		visible(txt_fma2_hdgsel,true)
	else
		visible(txt_fma2_hdgsel,false)
	end
	
	if pfd_hdg_mode == 2 then							--vor loc green
		visible(txt_fma2_vorlocg,true)
	else
		visible(txt_fma2_vorlocg,false)
	end
	
	if pfd_hdg_mode == 3 then							--lnav green
		visible(txt_fma2_lnavg,true)
	else
		visible(txt_fma2_lnavg,false)
	end

	if pfd_hdg_mode == 4 then							--rollout green
		visible(txt_fma2_rolloutg,true)
	else
		visible(txt_fma2_rolloutg,false)
	end
	
	if pfd_hdg_mode == 5 then							--fac green
		visible(txt_fma2_facg,true)
	else
		visible(txt_fma2_facg,false)
	end	
end
--function second_column_fma(pfd_hdg_mode, vorloc, pfd_hdg_mode_arm, alt, square2g)
xpl_dataref_subscribe("laminar/B738/autopilot/pfd_hdg_mode", "INT",        				--lnav=3
					  "laminar/B738/autopilot/vorloc_status", "INT",					--vorloc
					  "laminar/B738/autopilot/pfd_hdg_mode_arm", "INT",     			--lnav armed=3
					  "sim/cockpit2/gauges/indicators/altitude_ft_pilot", "FLOAT",		--alt
					  "laminar/B738/autopilot/rec_hdg_modes", "INT", second_column_fma)	--square2g
----------------------------------------------------------------------------------------------------------------

--Third Column FMA
function third_column_fma(pfd_alt_mode_arm, pfd_alt_mode, square3g)

	if square3g == 1 then visible(img_squarebox3_green,true) else visible(img_squarebox3_green,false) end
	
	if pfd_alt_mode_arm == 1 then					--g/s white
		visible(txt_fma3_apGS_white,true)
	else
		visible(txt_fma3_apGS_white,false)
	end

	if pfd_alt_mode_arm == 2 then					--v/s white
		visible(txt_fma3_apVS_white,true)
	else
		visible(txt_fma3_apVS_white,false)
	end
	
	if pfd_alt_mode_arm == 3 then					--flare white
		visible(txt_fma3_apFlare_white,true)
	else
		visible(txt_fma3_apFlare_white,false)
	end

	if pfd_alt_mode_arm == 4 then					--g/p white
		visible(txt_fma3_apGP_white,true)
	else
		visible(txt_fma3_apGP_white,false)
	end
	
	if pfd_alt_mode_arm == 5 then					--vnav white
		visible(txt_fma3_apVnav_white,true)
	else
		visible(txt_fma3_apVnav_white,false)
	end	
	
--*******************************************************************************************
	
	if pfd_alt_mode == 1 then					  		-- v/s
		visible(txt_fma3_apVS_green,true)
	else
		visible(txt_fma3_apVS_green,false)
	end
	
	if pfd_alt_mode == 2 then							--mcp spd
		visible(txt_fma3_apMcpSpd,true)
	else
		visible(txt_fma3_apMcpSpd,false)
	end
	
	
	if pfd_alt_mode == 3 then                          --alt acq
		visible(txt_fma3_apAltAcq,true)
	else
		visible(txt_fma3_apAltAcq,false)
	end
	
	if  pfd_alt_mode == 4 then							--alt hld
		visible(txt_fma3_apAltHld,true)
	else
		visible(txt_fma3_apAltHld,false)
	end
	
	if  pfd_alt_mode == 5 then							--G/S groen
		visible(txt_fma3_apGS_green,true)
	else
		visible(txt_fma3_apGS_green,false)
	end
	
	if  pfd_alt_mode == 6 then							--FLARE groen
		visible(txt_fma3_apFlare_green,true)
	else
		visible(txt_fma3_apFlare_green,false)
	end
	
	if  pfd_alt_mode == 7 then							--G/P groen
		visible(txt_fma3_apGP,true)
	else
		visible(txt_fma3_apGP,false)
	end
			
	if pfd_alt_mode == 8 then					  		-- vnav spd
		visible(txt_fma3_apVnavSpd,true)
	else
		visible(txt_fma3_apVnavSpd,false)
	end
	
	if pfd_alt_mode == 9 then							--vnav pth
		visible(txt_fma3_apVnavPth,true)
	else
		visible(txt_fma3_apVnavPth,false)
	end
	
	if pfd_alt_mode == 10 then							--vnav alt
		visible(txt_fma3_apVnavAlt,true)
	else
		visible(txt_fma3_apVnavAlt,false)
	end
	
	if pfd_alt_mode == 11 then
		visible(txt_fma3_apToGa,true)					--TO/GA
	else
		visible(txt_fma3_apToGa,false)
	end
	
end
--third_column_fma(pfd_alt_mode_arm, pfd_alt_mode, square3g)
xpl_dataref_subscribe("laminar/B738/autopilot/pfd_alt_mode_arm", "INT",     			--vanv armed=5
					  "laminar/B738/autopilot/pfd_alt_mode", "INT",     				--vnav spd=8 
					  "laminar/B738/autopilot/rec_alt_modes", "INT", third_column_fma) 	--square3g
					  
---------------------------------------------------------------------------------------
end