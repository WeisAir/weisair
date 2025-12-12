--THIS LIBRARY IS MANAGING THE EXTRA INFO AT THE LEFT SIDE OF THE PFD****************************
--LIKE: min and max maneuverspeeds and airspeedbug
--***********************************************************************************************

function lib_extra_info_left_init()

img_speedmarker = img_add("speedmarker.png", 90,142, 49, 23)					--90,142, 49, 23
img_max_maneuver_amber = img_add("max_maneuver_amber.png", 120, 100, 20, 650)
img_warning_speed_high= img_add("warning_marker_high.png", 122, -400, 15, 550)--122, -400, 15, 550
img_min_maneuver_amber = img_add("min_maneuver_amber.png", 120, 800, 20, 650)--120, 800, 20, 650
img_warning_speed_low = img_add("warning_marker_high.png", 122,435, 15, 550)--122,405, 15, 400

txt_mach= txt_add(" ", "size:24px; font:BCG.ttf; color:  white;  halign:left;",  20, 825, 100, 40)
txt_gs= txt_add(" ", "size:24px; font:BCG.ttf; color:  white;  halign:left;",  5, 825, 120, 40)


viewport_rect(img_speedmarker,80,115,137,695)
viewport_rect(img_warning_speed_high,80,115,100,375)--80,115,100,346
viewport_rect(img_max_maneuver_amber, 120, 120, 20, 655)
viewport_rect(img_warning_speed_low,80,455,100,355)--80,455,100,355
viewport_rect(img_min_maneuver_amber, 120, 460, 20, 350)

function extra_info_left(apspeed, ismach, mach, airspeed, on_ground, max_maneuver_speed_show, min_maneuver_speed_show, min_speed_show,
min_speed, min_maneuver, max_maneuver, max_speed)

-- Autopilot airspeed bug
	if ismach == 1 then
		local apspeed2 = (apspeed * 387.5)
		y_speedmarker = ((apspeed2 - airspeed) * -5.5) + 448
		y_speedmarker = var_cap(y_speedmarker, 100, 800)
	else
		if on_ground[1] == 1 and on_ground[2] == 1 and on_ground[3] == 1 and apspeed < 101 then 
			y_speedmarker = ((apspeed - airspeed) * -5.5) + 448			
			y_speedmarker = var_cap(y_speedmarker, -35, 800)			
			move(img_speedmarker,nil,y_speedmarker+180,nil,nil)
		else																--in the air
			y_speedmarker = ((apspeed - airspeed) * -5.5) + 448
			y_speedmarker = var_cap(y_speedmarker, -35, 800)
			move(img_speedmarker,nil,y_speedmarker,nil,nil)
		end
	end	
	
	--if airspeed < 99 then
		--move(img_speedmarker,nil,-8,nil,nil)   			--bug not visible
	--end

	
-- Warning speed high and max maneuver high
	if max_maneuver_speed_show == 0 then
		local y_warning_speed_marker_high = ((max_speed - airspeed) * -5.5) - 50
		move(img_warning_speed_high,nil,y_warning_speed_marker_high,nil,nil)
		visible(img_max_maneuver_amber,false)
	else
		--y_warning_speed_marker_high = (30+(max_speed - 250)*(400 - 30)/(340 - 250))*-1
		local y_warning_speed_marker_high = ((max_speed - airspeed) * -5.5) - 50
		move(img_warning_speed_high,nil,y_warning_speed_marker_high,nil,nil)
		--local y_maneuver_speed_high = (505+(max_maneuver - 330)*(120 - 505)/(190 - 330))
		visible(img_max_maneuver_amber,true)
		local y_maneuver_speed_high = ((max_maneuver - airspeed) * -5.5) - 170
		move(img_max_maneuver_amber,nil,y_maneuver_speed_high,nil,nil)
	end

	if min_speed_show == 1 then
		visible(img_warning_speed_low,true)
		local y_warning_speed_marker_low = ((min_speed - airspeed) * -5.5) + 405
		move(img_warning_speed_low,nil,y_warning_speed_marker_low,nil,nil)
	else
		visible(img_warning_speed_low,false)
	end
	
	if min_maneuver_speed_show == 1 then
		visible(img_min_maneuver_amber,true)
		local y_maneuver_speed_low = ((min_speed - airspeed) * -5.5) + 370		
		move(img_min_maneuver_amber,nil,y_maneuver_speed_low,nil,nil)
	else
		visible(img_min_maneuver_amber,false)
	end
	
----mach setting
	if mach > 0.4 then
		visible(txt_mach, true)
		local my_mach = var_round(mach,3)
		my_mach = string.sub(mach,3,5)
		txt_set(txt_mach, "." .. my_mach)
		txt_set(txt_gs,"")
		visible(txt_gs, false)
	else	
		visible(txt_mach, false)
	end
		
end
--function extra_info_left(apspeed, ismach, mach, airspeed, on_ground, max_maneuver_speed_show, min_maneuver_speed_show, min_speed_show,
--min_speed, min_maneuver, max_maneuver, max_speed)
xpl_dataref_subscribe("laminar/B738/autopilot/mcp_speed_dial_kts", "FLOAT",				--apspeed
					  "sim/cockpit/autopilot/airspeed_is_mach", "INT", 					--ismach
					  "sim/flightmodel/misc/machno", "FLOAT",							--mach
					  "laminar/B738/autopilot/airspeed", "FLOAT",						--airspeed
					  "sim/flightmodel2/gear/on_ground", "INT[10]",					  	--on_ground
					  "laminar/B738/pfd/max_maneuver_speed_show", "INT",				--max_maneuver_speed_show
					  "laminar/B738/pfd/min_maneuver_speed_show", "INT",				--min_maneuver_speed_show
					  "laminar/B738/pfd/min_speed_show", "INT",							--min_speed_show
					  "laminar/B738/pfd/min_speed", "FLOAT",							--min_speed
					  "laminar/B738/pfd/min_maneuver_speed", "FLOAT",					--min_maneuver
					  "laminar/B738/pfd/max_maneuver_speed", "FLOAT",					--max_maneuver
					  "laminar/B738/pfd/max_speed", "FLOAT", extra_info_left)			--max_speed

end