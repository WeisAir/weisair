--- PFD DEV
	
	-- Captain
	local vor_tuned = 0
	if B738DR_nav_type == 4 then								--laminar/radios/pilot/nav_type
		vor_tuned = 1
	end

--show horizontal ANP scale or hide 	
	local horz_active = 0
	-- if B738DR_nav_horz_dsp == 1 and B738DR_nav_flag_ft == 1 and vor_tuned == 0 then
	if B738DR_nav_horz_dsp == 1 and vor_tuned == 0 then		--laminar/radios/pilot/nav_horz_dsp / is voor horizontale bolletjes scale
		horz_active = 1
		B738DR_nd_fac_horizontal = 0	--laminar/B738/fms/pfd_fac_horizontal / hide horizontale ANP scale ???
	else
		B738DR_nd_fac_horizontal = 1	--laminar/B738/fms/pfd_fac_horizontal / laat horizontale ANP scale zien
	end
	
--show verticale ANP scale or hide	DOET NIET MEER MEE 
	--local vert_active = 0
	--if B738DR_nav_flag_gs == 0 and B738DR_nav_vert_dsp == 1 then --laminar/radios/pilot/nav_flag_gs and laminar/radios/pilot/nav_vert_dsp
		--vert_active = 1
	--end
	
	if B738DR_fms_ils_disable == 0 then							--laminar/B738/FMS/ils_disable
		--if vert_active == 0 then 
		if horz_active == 0 then 							--horizontale ANP scale niet aktief
			if B738DR_nd_vert_path == 1 then					--laminar/B738/pfd/nd_vert_path
				B738DR_autopilot_pfd_mode = 2 	-- LNAV/VNAV
				B738DR_pfd_vert_path = 1						--laminar/B738/pfd/pfd_vert_path / is voor verticale ANP scale???  
				pfd_rnav()									--hier wordt textregel 1 gevuld
			else
				B738DR_pfd_vert_path = 0					--verticale ANP scale
				if B738DR_autopilot_vnav_status == 0 then
					B738DR_autopilot_pfd_mode = 0	-- none			--geen tekst als pfd_mode = 0 
				else
					B738DR_autopilot_pfd_mode = 2 	-- LNAV/VNAV
					pfd_cpt_nav_txt1 = ""
					pfd_cpt_nav_txt2 = ""
				end
			end
		else
			if B738DR_nav_type == 4 then
				B738DR_autopilot_pfd_mode = 0	-- none
				pfd_cpt_nav_txt1 = ""
				pfd_cpt_nav_txt2 = ""
			else
				B738DR_autopilot_pfd_mode = 1 	-- ILS
				B738DR_pfd_vert_path = 0
				pfd_ils()
			end
		end
	else
		if B738DR_gp_active == 0 then
			if B738DR_nd_vert_path == 0 then					--is verticale deviation scale op ND
				B738DR_pfd_vert_path = 0
				if B738DR_autopilot_vnav_status == 0 then		--is VNAV op MCP ingeschakeld of niet
					B738DR_autopilot_pfd_mode = 0	-- none
				else
					B738DR_autopilot_pfd_mode = 2 	-- LNAV/VNAV
					pfd_cpt_nav_txt1 = ""
					pfd_cpt_nav_txt2 = ""
				end
			else
				if horz_active == 1 then
					if B738DR_nav_type == 4 then
						B738DR_autopilot_pfd_mode = 0	-- none
						pfd_cpt_nav_txt1 = ""
						pfd_cpt_nav_txt2 = ""
					else
						B738DR_autopilot_pfd_mode = 3 	-- LOC/VNAV
						pfd_loc()
					end
				else
					B738DR_autopilot_pfd_mode = 2 	-- LNAV/VNAV
					pfd_rnav()
				end
				B738DR_pfd_vert_path = 1
			end
		elseif B738DR_gp_active == 1 then
			if horz_active == 0 then
				if fac_engaged == 0 then								--laminar/B738/ap/fac_engaged
					if B738DR_nd_vert_path == 0 then
					B738DR_autopilot_pfd_mode = 0	-- none
					else
						B738DR_autopilot_pfd_mode = 2 	-- LNAV/VNAV
						pfd_cpt_nav_txt1 = ""
						pfd_cpt_nav_txt2 = ""
					end
				else
					B738DR_autopilot_pfd_mode = 4 	-- FMC -> FAC/GP
					pfd_rnav()
					B738DR_pfd_vert_path = 0
				end
			else
				if fac_engaged == 1 then								--laminar/B738/ap/fac_engaged
					B738DR_autopilot_pfd_mode = 4 	-- FMC -> FAC/GP
					pfd_rnav()
					B738DR_pfd_vert_path = 0
				elseif loc_gp_engaged == 1 then								--laminar/B738/ap/loc_gp_engaged
					if B738DR_nav_type == 4 then
						B738DR_autopilot_pfd_mode = 0	-- none
						pfd_cpt_nav_txt1 = ""
						pfd_cpt_nav_txt2 = ""
					else
						B738DR_autopilot_pfd_mode = 3 	-- LOC/GP
						pfd_loc()
						B738DR_pfd_vert_path = 0
					end
				else
					if B738DR_nav_type == 4 then
						B738DR_autopilot_pfd_mode = 0	-- none
						pfd_cpt_nav_txt1 = ""
						pfd_cpt_nav_txt2 = ""
					else
						B738DR_autopilot_pfd_mode = 3 	-- LOC/VNAV (GP)
						pfd_loc()
					end
				end
			end
		end
	end
	if B738DR_autopilot_pfd_mode == 0 then
		pfd_cpt_nav_txt1 = ""
		pfd_cpt_nav_txt2 = ""
	end