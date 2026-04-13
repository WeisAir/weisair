SimVar("sim/cockpit2/gauges/indicators/wind_heading_deg_mag")
SimVar("sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_copilot")

function get_relative_wind_direction()

    local wind_dir_raw = SimRead("sim/cockpit2/gauges/indicators/wind_heading_deg_mag")

    --note: wind_dir_raw is the wind blowing FROM a direction and not TO, that is why the following shift by 180 degr is necessary to get the right vector calculation
    local wind_dir = 0

    if (wind_dir_raw < 180) then wind_dir = wind_dir_raw + 180
    else wind_dir = wind_dir_raw - 180
    end

    local aircraft_heading = SimRead("sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_copilot")
    local relative_wind_dir = 0

    if (wind_dir > aircraft_heading) then
        if ((aircraft_heading > 0 and wind_dir > 0) or (aircraft_heading < 0 and wind_dir < 0)) then relative_wind_dir = wind_dir - aircraft_heading end
        if (aircraft_heading < 0 and wind_dir > 0) then relative_wind_dir = wind_dir + aircraft_heading + 360 end
    end

    if (wind_dir < aircraft_heading) then
        if ((aircraft_heading > 0 and wind_dir > 0) or (aircraft_heading < 0 and wind_dir < 0)) then relative_wind_dir = wind_dir - aircraft_heading + 360 end
        if (aircraft_heading > 0 and wind_dir < 0) then relative_wind_dir = wind_dir - aircraft_heading end
    end

    return relative_wind_dir
end