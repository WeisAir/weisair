SimVar("sim/cockpit2/gauges/indicators/wind_heading_deg_mag")
SimVar("sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_copilot")

function get_relative_wind_direction()

    local wind_dir = SimRead("sim/cockpit2/gauges/indicators/wind_heading_deg_mag")
    local aircraft_heading = SimRead("sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_copilot")
    local relative_wind_dir = 0

    -- relative_wind_dir = wind_dir - aircraft_heading


    --seems to be logical error, in theory my calc seems to be right but compared to zibi it is shifted by 180 degr
    --if (relative_wind_dir <0) then return 360+relative_wind_dir
    --   else return relative_wind_dir
    --   end

    -- if (relative_wind_dir <0) then 
    --    if (180+relative_wind_dir > 0) then return 180+relative_wind_dir
    --        else return 360+relative_wind_dir
    --    end
    -- else return relative_wind_dir + 180
    -- end

    --if (relative_wind_dir > 0) then return relative_wind_dir
    --    else
    --        local new_relative_wind_dir = 180 + relative_wind_dir
    --        if (new_relative_wind_dir < 0) then return 360 + relative_wind_dir
    --            else return new_relative_wind_dir
    --        end
    --    end        
    --end

    if (wind_dir > aircraft_heading) then
        if ((aircraft_heading > 0 and wind_dir > 0) or (aircraft_heading <0 and wind_dir <0)) then relative_wind_dir = wind_dir - aircraft_heading end
        if (aircraft_heading < 0 and wind_dir > 0) then relative_wind_dir = wind_dir + aircraft_heading + 360 end
    end

    if (wind_dir < aircraft_heading) then
        if ((aircraft_heading > 0 and wind_dir > 0) or (aircraft_heading <0 and wind_dir <0)) then relative_wind_dir = wind_dir - aircraft_heading + 360 end
        if (aircraft_heading > 0 and wind_dir < 0) then relative_wind_dir = wind_dir - aircraft_heading end
    end

    return relative_wind_dir
end