--XP12 screenshot dialogue -> hide data output in screenshots
set("sim/private/controls/dout/hide_in_screenshots", 1)


-- overall weather presets

function set_weather_cavok()
	set("sim/weather/region/weather_preset", 0)
end
create_command("WeisAIR/ops_weather/set_weather_cavok", "set_weather_cavok", "set_weather_cavok()", "", "")

function set_weather_vfr_few()
	set("sim/weather/region/weather_preset", 1)
end
create_command("WeisAIR/ops_weather/set_weather_vfr_few", "set_weather_vfr_few", "set_weather_vfr_few()", "", "")

function set_weather_vfr_scattered()
	set("sim/weather/region/weather_preset", 2)
end
create_command("WeisAIR/ops_weather/set_weather_vfr_scattered", "set_weather_vfr_scattered", "set_weather_vfr_scattered()", "", "")

function set_weather_vfr_broken()
	set("sim/weather/region/weather_preset", 3)
end
create_command("WeisAIR/ops_weather/set_weather_vfr_broken", "set_weather_vfr_broken", "set_weather_vfr_broken()", "", "")

function set_weather_vfr_marginal()
	set("sim/weather/region/weather_preset", 4)
end
create_command("WeisAIR/ops_weather/set_weather_vfr_marginal", "set_weather_vfr_marginal", "set_weather_vfr_marginal()", "", "")

function set_weather_ifr_nonprecision()
	set("sim/weather/region/weather_preset", 5)
end
create_command("WeisAIR/ops_weather/set_weather_ifr_nonprecision", "set_weather_ifr_nonprecision", "set_weather_ifr_nonprecision()", "", "")

function set_weather_ifr_precision()
	set("sim/weather/region/weather_preset", 6)
end
create_command("WeisAIR/ops_weather/set_weather_ifr_precision", "set_weather_ifr_precision", "set_weather_ifr_precision()", "", "")

function set_weather_convective()
	set("sim/weather/region/weather_preset", 7)
end
create_command("WeisAIR/ops_weather/set_weather_convective", "set_weather_convective", "set_weather_convective()", "", "")

function set_weather_largecellthunderstorms()
	set("sim/weather/region/weather_preset", 8)
end
create_command("WeisAIR/ops_weather/set_weather_largecellthunderstorms", "set_weather_largecellthunderstorms", "set_weather_largecellthunderstorms()", "", "")

function toggle_weather_presets()
	
	dataref("wxr_preset", "sim/weather/region/weather_preset", writable)
	new_state = wxr_preset + 1
	
	if (new_state < 9) then set("sim/weather/region/weather_preset", new_state)
		else set("sim/weather/region/weather_preset", 0)
	end

end
create_command("WeisAIR/ops_weather/toggle_weather_presets", "toggle_weather_presets", "toggle_weather_presets()", "", "")


-- RUNWAY FRICTION

function set_weather_rwy_friction_dry()
	set("sim/weather/region/runway_friction", 0)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_dry", "set_weather_rwy_friction_dry", "set_weather_rwy_friction_dry()", "", "")

function set_weather_rwy_friction_wet1()
	set("sim/weather/region/runway_friction", 1)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_wet1", "set_weather_rwy_friction_wet1", "set_weather_rwy_friction_wet1()", "", "")

function set_weather_rwy_friction_wet2()
	set("sim/weather/region/runway_friction", 2)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_wet2", "set_weather_rwy_friction_wet2", "set_weather_rwy_friction_wet2()", "", "")

function set_weather_rwy_friction_wet3()
	set("sim/weather/region/runway_friction", 3)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_wet3", "set_weather_rwy_friction_wet3", "set_weather_rwy_friction_wet3()", "", "")

function set_weather_rwy_friction_puddly1()
	set("sim/weather/region/runway_friction", 4)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_puddly1", "set_weather_rwy_friction_puddly1", "set_weather_rwy_friction_puddly1()", "", "")

function set_weather_rwy_friction_puddly2()
	set("sim/weather/region/runway_friction", 5)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_puddly2", "set_weather_rwy_friction_puddly2", "set_weather_rwy_friction_puddly2()", "", "")

function set_weather_rwy_friction_puddly3()
	set("sim/weather/region/runway_friction", 6)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_puddly3", "set_weather_rwy_friction_puddly3", "set_weather_rwy_friction_puddly3()", "", "")

function set_weather_rwy_friction_snowy1()
	set("sim/weather/region/runway_friction", 7)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_snowy1", "set_weather_rwy_friction_snowy1", "set_weather_rwy_friction_snowy1()", "", "")

function set_weather_rwy_friction_snowy2()
	set("sim/weather/region/runway_friction", 8)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_snowy2", "set_weather_rwy_friction_snowy2", "set_weather_rwy_friction_snowy2()", "", "")

function set_weather_rwy_friction_snowy3()
	set("sim/weather/region/runway_friction", 9)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_snowy3", "set_weather_rwy_friction_snowy3", "set_weather_rwy_friction_snowy3()", "", "")

function set_weather_rwy_friction_icy1()
	set("sim/weather/region/runway_friction", 10)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_icy1", "set_weather_rwy_friction_icy1", "set_weather_rwy_friction_icy1()", "", "")

function set_weather_rwy_friction_icy2()
	set("sim/weather/region/runway_friction", 11)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_icy2", "set_weather_rwy_friction_icy2", "set_weather_rwy_friction_icy2()", "", "")

function set_weather_rwy_friction_icy3()
	set("sim/weather/region/runway_friction", 12)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_icy3", "set_weather_rwy_friction_icy3", "set_weather_rwy_friction_icy3()", "", "")

function set_weather_rwy_friction_snowyicy1()
	set("sim/weather/region/runway_friction", 13)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_snowyicy1", "set_weather_rwy_friction_snowyicy1", "set_weather_rwy_friction_snowyicy1()", "", "")

function set_weather_rwy_friction_snowyicy2()
	set("sim/weather/region/runway_friction", 14)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_snowyicy2", "set_weather_rwy_friction_snowyicy2", "set_weather_rwy_friction_snowyicy2()", "", "")

function set_weather_rwy_friction_snowyicy3()
	set("sim/weather/region/runway_friction", 15)
end
create_command("WeisAIR/ops_weather/set_weather_rwy_friction_snowyicy3", "set_weather_rwy_friction_snowyicy3", "set_weather_rwy_friction_snowyicy3()", "", "")

function toggle_weather_rwy_friction()
	
	dataref("rwy_friction", "sim/weather/region/runway_friction", writable)
	
	current_state = rwy_friction
	new_state = current_state + 1.0
	
	if (new_state < 16.0) then set("sim/weather/region/runway_friction", new_state)
		else set("sim/weather/region/runway_friction", 0.0)
	end

end
create_command("WeisAIR/ops_weather/toggle_weather_rwy_friction", "toggle_weather_rwy_friction", "toggle_weather_rwy_friction()", "", "")


-- TEMP

function inc_sealevel_temp_10degr()
	
	dataref("sealvl_temperature", "sim/weather/region/sealevel_temperature_c", writable)
	
	new_temp = sealvl_temperature + 10
	set("sim/weather/region/sealevel_temperature_c",new_temp)

end
create_command("WeisAIR/ops_weather/inc_sealevel_temp_10degr", "inc_sealevel_temp_10degr", "inc_sealevel_temp_10degr()", "", "")

function dec_sealevel_temp_10degr()
	
	dataref("sealvl_temperature", "sim/weather/region/sealevel_temperature_c", writable)
	
	new_temp = sealvl_temperature - 10
	set("sim/weather/region/sealevel_temperature_c",new_temp)

end
create_command("WeisAIR/ops_weather/dec_sealevel_temp_10degr", "dec_sealevel_temp_10degr", "dec_sealevel_temp_10degr()", "", "")




-- WIND


function inc_wind_10kts()
	set("sim/weather/region/update_immediately",1)
	
	dataref("wind_speed", "sim/weather/region/wind_speed_msc", writable,0)
	current_speed = wind_speed
	new_speed = current_speed + (10/1.94384)
	set_array("sim/weather/region/wind_speed_msc",0, new_speed)
end
create_command("WeisAIR/ops_weather/inc_wind_10kts", "inc_wind_10kts", "inc_wind_10kts()", "", "")

function dec_wind_10kts()
	set("sim/weather/region/update_immediately",1)
	
	dataref("wind_speed", "sim/weather/region/wind_speed_msc", writable,0)
	current_speed = wind_speed
	new_speed = current_speed - (10/1.94384)
	if (new_speed >=0) then set_array("sim/weather/region/wind_speed_msc",0, new_speed) 
		else set_array("sim/weather/region/wind_speed_msc",0, 0) 
	end
end
create_command("WeisAIR/ops_weather/dec_wind_10kts", "dec_wind_10kts", "dec_wind_10kts()", "", "")

function inc_wind_direction_10degr()
	set("sim/weather/region/update_immediately",1)
	
	dataref("wind_direction", "sim/weather/region/wind_direction_degt", writable,0)
	current_direction = wind_direction
	new_direction = current_direction + 10
	if (new_direction < 360) then set_array("sim/weather/region/wind_direction_degt",0, new_direction)
		else set_array("sim/weather/region/wind_direction_degt",0, 0) 
	end
end
create_command("WeisAIR/ops_weather/inc_wind_direction_10degr", "inc_wind_direction_10degr", "inc_wind_direction_10degr()", "", "")

function dec_wind_direction_10degr()
	set("sim/weather/region/update_immediately",1)
	
	dataref("wind_direction", "sim/weather/region/wind_direction_degt", writable,0)
	current_direction = wind_direction
	new_direction = current_direction - 10
	if (new_direction > 0) then set_array("sim/weather/region/wind_direction_degt",0, new_direction)
		else set_array("sim/weather/region/wind_direction_degt",0, 359) 
	end
end
create_command("WeisAIR/ops_weather/dec_wind_direction_10degr", "dec_wind_direction_10degr", "dec_wind_direction_10degr()", "", "")

function set_weather_wind_20kts_N()
	set("sim/weather/region/update_immediately",1)
	set_array("sim/weather/region/wind_direction_degt",0, 0.0)
	set_array("sim/weather/region/wind_speed_msc",0, 20.0 * 1.94384)
end
create_command("WeisAIR/ops_weather/set_weather_wind_20kts_N", "set_weather_wind_20kts_N", "set_weather_wind_20kts_N()", "", "")

-- Simulation Time

function set_zulutime_midnight()
	set("sim/time/zulu_time_sec", 0)
end
create_command("WeisAIR/ops_time/set_zulutime_midnight", "set_zulutime_midnight", "set_zulutime_midnight()", "", "")

function set_zulutime_3am()
	set("sim/time/zulu_time_sec", 10800)
end
create_command("WeisAIR/ops_time/set_zulutime_3am", "set_zulutime_3am", "set_zulutime_3am()", "", "")

function set_zulutime_6am()
	set("sim/time/zulu_time_sec", 21600)
end
create_command("WeisAIR/ops_time/set_zulutime_6am", "set_zulutime_6am", "set_zulutime_6am()", "", "")

function set_zulutime_9am()
	set("sim/time/zulu_time_sec", 32400)
end
create_command("WeisAIR/ops_time/set_zulutime_9am", "set_zulutime_9am", "set_zulutime_9am()", "", "")

function set_zulutime_12am()
	set("sim/time/zulu_time_sec", 43200)
end
create_command("WeisAIR/ops_time/set_zulutime_12am", "set_zulutime_12am", "set_zulutime_12am()", "", "")

function set_zulutime_3pm()
	set("sim/time/zulu_time_sec", 54000)
end
create_command("WeisAIR/ops_time/set_zulutime_3pm", "set_zulutime_3pm", "set_zulutime_3pm()", "", "")

function set_zulutime_6pm()
	set("sim/time/zulu_time_sec", 64800)
end
create_command("WeisAIR/ops_time/set_zulutime_6pm", "set_zulutime_6pm", "set_zulutime_6pm()", "", "")

function set_zulutime_9pm()
	set("sim/time/zulu_time_sec", 75600)
end
create_command("WeisAIR/ops_time/set_zulutime_9pm", "set_zulutime_9pm", "set_zulutime_9pm()", "", "")

function set_zulutime_next_hour()
	
	dataref("zulu_time", "sim/time/zulu_time_sec", writable)
	
	current_state = zulu_time
	new_state = current_state + 3600
	
	if (new_state < 86400) then set("sim/time/zulu_time_sec", new_state)
		else set("sim/time/zulu_time_sec", 0)
	end

end
create_command("WeisAIR/ops_time/set_zulutime_next_hour", "set_zulutime_next_hour", "set_zulutime_next_hour()", "", "")

function set_zulutime_prev_hour()
	
	dataref("zulu_time", "sim/time/zulu_time_sec", writable)
	
	current_state = zulu_time
	new_state = current_state - 3600
	
	if (new_state > 0) then set("sim/time/zulu_time_sec", new_state)
		else set("sim/time/zulu_time_sec", 82800)
	end

end
create_command("WeisAIR/ops_time/set_zulutime_prev_hour", "set_zulutime_prev_hour", "set_zulutime_prev_hour()", "", "")