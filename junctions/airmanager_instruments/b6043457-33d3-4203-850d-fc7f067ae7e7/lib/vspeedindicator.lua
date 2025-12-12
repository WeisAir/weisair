--THIS LIBRARY IS MANAGING THE VERTCAL SPEED NEEDLE AND VERTICAL SPEED BUG

--*************************************************************************************************************

function lib_vertical_speed_indicator_init()

--Variables-----------------------------------------
local vsiSpeedAngle	= {{-6001,-78},{-6000,-77.95},{-4000,-76.4},{-2000,-74.2},{-1500,-70},{-1000,-62.6},{-500,-40},{0,0},{500,39.5},{1000,62.5},{1500,70},{2000,74.3},{4000,76.4},{6000,77.95},{6001,78}}

--Text for the vertical speed indicator------------
txt_vsi = txt_add("", "size:22px; font:BCG.ttf; color: white;  halign:right;", 680, 225, 200, 100)
txt_vsiNeg = txt_add("", "size:22px; font:BCG.ttf; color: white;  halign:right;", 680, 680, 200, 100)

--Images for the vertical speed indicator----------
img_VS_needle = img_add("VS_Needle.png",530, 163, 800,  600)   --500,163,800,600
img_vsmarker = img_add("VS_Bug.png", 836, 456, 18, 12)

--viewports for the vertical speed indicator--------	
viewport_rect(img_VS_needle,857,168,100,800)
	
	function getVsiAngle(speed)
	angle =0
		for i=1,13 do					--13
			if speed >= vsiSpeedAngle[i][1] and speed <= vsiSpeedAngle[i+1][1] then
				angle = vsiSpeedAngle[i][2] +( (vsiSpeedAngle[i+1][2] - vsiSpeedAngle[i][2]) * (( speed  - vsiSpeedAngle[i][1])/ (vsiSpeedAngle[i+1][1]-vsiSpeedAngle[i][1])))
			end
		end 
		return angle
	end	
	
-- Vertical speed indicator and vertical speed bug--
	function new_vsi(vs, show_bug, apVs)
		
		vsi = var_round(vs / 100, 0) * 100

		if vs >= 400 then
			txt_set(txt_vsi, var_format(vsi,0))
			txt_set(txt_vsiNeg, "")
		elseif vs <= -400 then
			txt_set(txt_vsiNeg, var_format(-vsi,0))
			txt_set(txt_vsi, "")
		else
			txt_set(txt_vsiNeg, "")
			txt_set(txt_vsi, "")
		end
		
		verticalspeed = vs
		verticalspeed = var_cap(math.floor(verticalspeed), -6000, 6000)
	----CLIMB-------------------------------------------------------------------
		if verticalspeed > 0 and verticalspeed < 500 then
			needleAngle = 0 + (27 - 0)*(verticalspeed - 0)/(500 - 0)
			img_rotate(img_VS_needle, needleAngle)
		elseif verticalspeed > 500 and verticalspeed < 1000 then
			needleAngle = 27 + (49 - 27)*(verticalspeed - 500)/(1000 - 500)
			img_rotate(img_VS_needle, needleAngle)
		elseif verticalspeed > 1000 and verticalspeed < 2000 then
			needleAngle = 49 + (64 - 49)*(verticalspeed - 1000)/(2000 - 1000)
			img_rotate(img_VS_needle, needleAngle)
		elseif verticalspeed > 2000 and verticalspeed < 6000 then
			needleAngle = 64 + (70 - 64)*(verticalspeed - 2000)/(6000 - 2000)
			img_rotate(img_VS_needle, needleAngle)
		end
	----DECENT------------------------------------------------------------		
		if verticalspeed < 0 and verticalspeed > -500 then
			needleAngle = 0 + (-27 - 0)*(verticalspeed - 0)/(-500 - 0)
			img_rotate(img_VS_needle, needleAngle)
		elseif verticalspeed < -500 and verticalspeed > -1000 then
			needleAngle = -27 + (-49 - -27)*(verticalspeed - -500)/(-1000 - -500)
			img_rotate(img_VS_needle, needleAngle)
		elseif verticalspeed < -1000 and verticalspeed > -2000 then
			needleAngle = -49 + (-64 - -49)*(verticalspeed - -1000)/(-2000 - -1000)
			img_rotate(img_VS_needle, needleAngle)
		elseif verticalspeed < -2000 and verticalspeed > -6000 then
			needleAngle = -64 + (-70 - -64)*(verticalspeed - -2000)/(-6000 - -2000)
			img_rotate(img_VS_needle, needleAngle)
		end
		
		-- Autopilot vertical speed bug
		apVs = var_cap(apVs,-6000,6000)
		if (apVs > 0 or apVs < 0) and show_bug == 1 then
			visible(img_vsmarker, true)
			move(img_vsmarker,nil,456-(42.55*math.tan(math.rad(getVsiAngle(apVs)))),nil,nil)
		else
			visible(img_vsmarker, false)
		end

	end

xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/vvi_fpm_pilot", "FLOAT",			--vs
					  "laminar/B738/autopilot/vs_status", "FLOAT",						--show_bug
					  "laminar/B738/autopilot/ap_vvi_pos", "FLOAT", new_vsi)			--apVs

end
--******************************************************************************************************************
