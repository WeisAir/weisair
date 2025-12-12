--THIS LIBRARY IS MANAGING ALL THE INFO AT THE TOP OF THE PFD EXCEPT THE FMA***************

--*****************************************************************************************
local var_blink_ra_500 = false

function lib_infobar_top_init()

img_course_strikeout = img_add("disagree.png",210, 125, 90, 20)


txt_apspd = txt_add(" ", "size:30px; font:BCG.ttf; color: magenta; halign:left;", 30, 70, 80, 50)--30, 75, 57, 40
txt_apalt1 = txt_add(" ", "size:34px; font:BCG.ttf; color: magenta ; halign:left;", 695, 65, 70, 100)--695, 65, 70, 100---685, 65, 70, 100
txt_apalt = txt_add(" ", "size:24px; font:BCG.ttf; color: magenta ; halign:left;", 745, 75, 150, 100)--745, 75, 150, 100---745, 73, 150, 100
txt_apFd = txt_add("FD", "size:28px; font:BCG.ttf; color: lime ; halign:left;", 375, 185, 200, 200)
txt_apCmd = txt_add("CMD", "size:28px; font:BCG.ttf; color: lime ; halign:left;", 368, 185, 200, 200)
txt_apLand3 = txt_add("LAND 3", "size:28px; font:BCG.ttf; color: lime ; halign:left;", 350, 180, 200, 200)
txt_apSingleChan1 = txt_add("SINGLE", "size:22px; font:BCG.ttf; color: yellow ; halign:left;", 355, 165, 100, 100)
txt_apSingleChan2 = txt_add("CH", "size:22px; font:BCG.ttf; color: yellow ; halign:left;", 380, 190, 100, 100)
txt_apCwsr = txt_add("CWS R", "size:20px; font:BCG.ttf; color: yellow ; halign:left;", 320, 100, 100, 100)
txt_apCwsp = txt_add("CWS P", "size:20px; font:BCG.ttf; color: yellow ; halign:left;", 410, 100, 100, 100)
--txt_angleAttack = txt_add(" ", "size:28px; font:Arimo-Bold.ttf; color: white ; halign:right;", 350, 170, 200, 200)
--txt_apILS = txt_add("ILS", "size:22px; font:BCG.ttf; color: white ; halign:right;", 95, 190, 100, 100)visible(txt_apILS, false)
txt_apICAO = txt_add(" ", "size:20px; font:BCG.ttf; color: white ; halign:left;", 155, 125, 200, 100)
txt_apICAO_amber = txt_add(" ", "size:20px; font:BCG.ttf; color: yellow ; halign:left;", 155, 125, 200, 100)
txt_apDME_distance = txt_add(" ", "size:20px; font:BCG.ttf; color: white ; halign:left;", 155, 155, 150, 100)
txt_apILS_course = txt_add(" ", "size:20px; font:BCG.ttf; color: white ; halign:left;", 235, 125, 100, 100)
txt_lnav_vnav = txt_add(" ", "size:18px; font:BCG.ttf; color: white ; halign:left;", 155, 190, 200, 200) visible(txt_lnav_vnav,false)
--txt_radio_alt_white = txt_add("","size:26px; font:BCG.ttf; color: white;  halign:center;", 545, 147, 80, 30)
--txt_radio_alt_amber = txt_add("","size:26px; font:BCG.ttf; color: #edbf38;  halign:center;", 545, 147, 80, 30)

amber_box_cwsp = canvas_add(0,0,900,900)
amber_box_cwsr = canvas_add(0,0,900,900)
greenbox_cmd = canvas_add(0,0,900,900)
greenbox_fd = canvas_add(0,0,900,900)


-- Information bar top --
function new_infobartop(apspeed,apalt,airspeed,fd,cmda,cmdb,greenbox_center,flare_status,singlechan,cwsp,cwsr,cwsp_box,cwsr_box)

-- Autopilot airspeed setting
	if apspeed > 0 then
		txt_set(txt_apspd,string.format("%.f", apspeed))
	else
		txt_set(txt_apspd, " ")
	end
	
-- Autopilot altitude setting
		if apalt >= 10000 then
			local first2 = string.sub(apalt,1,2)					--only thousends
			txt_set(txt_apalt1, first2)
			move(txt_apalt1, 695, 67, nil, nil)
			local my_str = tostring(apalt)
				if string.sub(my_str,-2) == ".0" then
					local last3 = string.sub(my_str,-5,-3)
					txt_set(txt_apalt, last3)						--last 3 digits
				end
		elseif apalt < 10000 and apalt >= 1000 then
			local first2 = string.sub(apalt,1,1)					--only hundreds
			txt_set(txt_apalt1, "  " .. first2)
			move(txt_apalt1, 683, 67,nil,nil)
			local my_str = tostring(apalt)
				if string.sub(my_str,-2) == ".0" then
					local last3 = string.sub(my_str,-5,-3)
					txt_set(txt_apalt, last3)						--last 2 digits
				end
		elseif apalt > 99 and apalt <= 900 then
			local first2 = "  0"
			txt_set(txt_apalt1, first2)
			txt_set(txt_apalt, string.format("%.f", apalt))
		elseif apalt == 0 then
			local first2 = "  0"
			txt_set(txt_apalt1, first2)
			local last3 = "000"
			txt_set(txt_apalt, last3)
		end


--FD and CMD flag
	if  fd == 1 then
		visible(txt_apFd, true)
		if greenbox_center == 1 then
			canvas_draw(greenbox_fd, function()
			_rect(315, 175, 154, 40)
			_stroke("lime", 3)
			end)
		else
			canvas_draw(greenbox_fd, function() end)
		end
	else
		visible(txt_apFd, false)
		canvas_draw(greenbox_fd, function() end)
	end
	
	if cmda == 1 or cmdb == 1 and flare_status == 0 then
		visible(txt_apCmd, true)
		visible(txt_apFd, false)
		if greenbox_center == 1 then 
			canvas_draw(greenbox_cmd, function()
			_rect(315, 175, 154, 40)
			_stroke("lime", 3)
			end)
		else
			canvas_draw(greenbox_cmd, function() end)
		end
	else
		visible(txt_apCmd, false)
		canvas_draw(greenbox_cmd, function() end)
	end
	
	if flare_status == 1 then
		visible(txt_apLand3, true)
		visible(txt_apCmd, false)
	else
		visible(txt_apLand3, false)
	end
	
	if singlechan == 1 then
		visible(txt_apSingleChan1, true)
		visible(txt_apSingleChan2, true)
		visible(txt_apCmd, false)
	else
		visible(txt_apSingleChan1, false)
		visible(txt_apSingleChan2, false)
	end
	
	if cwsp == 1 then
		visible(txt_apCwsp, true)
		if cwsp_box == 1 then
			canvas_draw(amber_box_cwsp, function()
			_rect(402, 98, 75, 25)
			_stroke("yellow", 3)
			end)
		else
			canvas_draw(amber_box_cwsp, function() end)
		end
	else
		visible(txt_apCwsp, false)
		canvas_draw(amber_box_cwsp, function() end)
	end
		
	if cwsr == 1 then
		visible(txt_apCwsr, true)
		if cwsr_box == 1 then
			canvas_draw(amber_box_cwsr, function()
			_rect(312, 98, 75, 25)
			_stroke("yellow", 3)
			end)
		else
			canvas_draw(amber_box_cwsr, function() end)
		end
	else
		visible(txt_apCwsr, false)
		canvas_draw(amber_box_cwsr, function() end)
	end
end
----------------------------------------------------------------------------------------------------------------------
xpl_dataref_subscribe("sim/cockpit/autopilot/airspeed", "FLOAT",						--apspeed 
					  --"sim/cockpit/autopilot/altitude", "FLOAT",						--apalt
					  "laminar/B738/autopilot/mcp_alt_dial", "FLOAT",					--apalt
					  "sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT",		--airspeed
					  "laminar/B738/autopilot/master_capt_status","INT",				--fd
					  "laminar/B738/autopilot/cmd_a_status", "INT",						--cmda 
					  "laminar/B738/autopilot/cmd_b_status", "INT",						--cmdb  
					  "laminar/B738/autopilot/rec_cmd_modes", "INT",					--greenbox_center
					  "laminar/B738/autopilot/flare_status", "INT",						--flare_status
					  "laminar/B738/autopilot/single_ch_status", "INT",					--singlechan
					  "laminar/B738/autopilot/cws_p_status", "FLOAT",					--cwsp
					  "laminar/B738/autopilot/cws_r_status", "FLOAT",					--cwsr
					  "laminar/B738/autopilot/rec_cwr_p_mode", "FLOAT",					--cwsp_box
					  "laminar/B738/autopilot/rec_cwr_r_mode", "FLOAT", new_infobartop)	--cwsr_box	

--***********************************************************************************************************************
					  
					  
--*******************ILS INFORMATION LEFT UPPER CORNER PFD****************************************************	
function ils_info(freq_hz_cap, freq_hz_fo, pfd_mode, text1, text2, ils_icao, nav_type, course_pilot, course_fo,
 ils_cap_show, loc_gp_engaged, fac_engaged, vnav_status)

local freq_cap = (string.sub(freq_hz_cap, 1,3)).."."..(string.sub(freq_hz_cap, 4))
local freq_fo = (string.sub(freq_hz_fo, 1,3)).."."..(string.sub(freq_hz_fo, 4))

	--if ils_icao ~= "" and (pfd_mode == 1 or pfd_mode == 2 or pfd_mode == 3 or pfd_mode == 4) then--as long there is no identification
	if text1 ~= "" and (pfd_mode == 1 or pfd_mode == 2 or pfd_mode == 3 or pfd_mode == 4) then--as long there is no identification
		if course_pilot ~= course_fo then										 				-- courses diagree
			txt_set(txt_apICAO, ils_icao .. "                ")         						--first textline
			txt_set(txt_apICAO_amber, "     / " .. string.format("%.f",course_pilot) .. " ° ")  --show text in yellow
			visible(img_course_strikeout, true)									 				--show strikeout
			txt_set(txt_apDME_distance, text2)			 										--second textline
		elseif freq_cap ~= freq_fo then															--frequency disagree		
			txt_set(txt_apICAO, freq_cap .. " / " .. string.format("%.f",course_pilot) .. " ° ")--first textline
			visible(img_course_strikeout,true)
			txt_set(txt_apICAO_amber, freq_cap)
			move(img_course_strikeout,150, 125, 90, 20)
			txt_set(txt_apDME_distance, text2)													--second textline
		else																					--normal white textlines
			txt_set(txt_apICAO, ils_icao .. " / " .. string.format("%.f",course_pilot) .. " ° ")--first textline			
			visible(img_course_strikeout,false)
			txt_set(txt_apICAO_amber,"")
			txt_set(txt_apDME_distance, text2)													--second textline
		end
	else																						--normal display without textlines
		txt_set(txt_apDME_distance,"")
		txt_set(txt_apICAO_amber,"")
		txt_set(txt_apICAO,"")
		visible(img_course_strikeout,false)
	end	

-----LNAV/VNAV MODE---------------------------------------------------------------------------
	--if ils_cap_show == 1 then
	if pfd_mode == 1 and (nav_type == 8 or nav_type == 40) then
		--visible(txt_apILS, true)												--third textline
		visible(txt_lnav_vnav,true)
		txt_set(txt_lnav_vnav,"ILS")
	elseif pfd_mode == 2  then													--LNAV/VNAV mode
		visible(txt_lnav_vnav,true)
		txt_set(txt_lnav_vnav,"LNAV/VNAV")
	elseif pfd_mode == 3 then
		visible(txt_lnav_vnav,true)
		txt_set(txt_lnav_vnav,"LOC/VNAV")
	elseif pfd_mode == 4 and fac_engaged == 1 then
		visible(txt_lnav_vnav,true)
		txt_set(txt_lnav_vnav,"FAC/GP")
	elseif pfd_mode == 3 and loc_gp_engaged == 1 then
		visible(txt_lnav_vnav,true)
		txt_set(txt_lnav_vnav,"LOC/GP")		
	elseif pfd_mode == 0 then
		visible(txt_lnav_vnav,false)
		txt_set(txt_lnav_vnav,"")
	end

end
--function ils_info(freq_hz_cap, freq_hz_fo, pfd_mode, text1, text2, ils_icao, nav_type, course_pilot, course_fo,
 --ils_cap_show, loc_gp_engaged, fac_engaged, vnav_status)
xpl_dataref_subscribe("sim/cockpit/radios/nav1_freq_hz", "INT",								--freq_hz_cap
					  "sim/cockpit/radios/nav2_freq_hz", "INT",								--freq_hz_fo
					  "laminar/B738/autopilot/pfd_mode", "INT",								--pfd_mode
					  "laminar/B738/pfd/cpt_nav_txt1", "STRING",							--text1
					  "laminar/B738/pfd/cpt_nav_txt2", "STRING",							--text2
					  "laminar/radios/pilot/nav_nav_id", "STRING",  			 			--ils_icao
					  "laminar/radios/pilot/nav_type", "INT",								--nav_type
					  "laminar/B738/autopilot/course_pilot", "FLOAT",     					--course_pilot
					  "laminar/B738/autopilot/course_copilot", "FLOAT",						--course_fo
					  "laminar/B738/pfd/ils_show", "FLOAT",									--ils_cap_show
					  "laminar/B738/ap/loc_gp_engaged", "INT",								--loc_gp_engaged
					  "laminar/B738/ap/fac_engaged", "INT",									--fac_engaged
					  "laminar/B738/autopilot/vnav_status1", "FLOAT", ils_info)			    --vnav_status
					  
--laminar/B738/pfd/cpt_nav_txt1
--laminar/B738/pfd/cpt_nav_txt2
--laminar/radios/pilot/nav_type
--laminar/B738/ap/loc_gp_engaged
--laminar/B738/ap/fac_engaged
--laminar/B738/pfd/pfd_vert_path------deze nog implementeren in center_navigation...is voor verticale ANP scale
--laminar/radios/pilot/nav_vert_dsp ---is voor ANP vertical display ???
--********************************************************************************************************************

end