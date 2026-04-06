--XP12 screenshot dialogue -> hide data output in screenshots
set("sim/private/controls/dout/hide_in_screenshots", 1)


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

