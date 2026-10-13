-- =========================================================================
-- WeisAIR Relative Wind Dataref Script (Optimized & Cleaned)
-- =========================================================================

-- 1. Link the existing X-Plane source datarefs to Lua variables
dataref("xp_wind_heading", "sim/cockpit2/gauges/indicators/wind_heading_deg_mag", "readonly")
dataref("xp_aircraft_heading", "sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_copilot", "readonly")

-- 2. Define and register your custom dataref
-- "WeisAIR/environment/wind_heading_relative_to_aircraft"
create_dataref("WeisAIR/environment/wind_heading_relative_to_aircraft", "number")

-- 3. Calculate and update function
function update_relative_wind_direction()

    local wind_dir_raw = xp_wind_heading

    -- Note: Your original shift logic to get the right vector calculation
    local wind_dir = 0
    if (wind_dir_raw < 180) then 
        wind_dir = wind_dir_raw + 180
    else 
        wind_dir = wind_dir_raw - 180
    end

    local aircraft_heading = xp_aircraft_heading
    local relative_wind_dir = 0

    -- Your original relative calculation logic
    if (wind_dir > aircraft_heading) then
        if ((aircraft_heading > 0 and wind_dir > 0) or (aircraft_heading < 0 and wind_dir < 0)) then 
            relative_wind_dir = wind_dir - aircraft_heading 
        end
        if (aircraft_heading < 0 and wind_dir > 0) then 
            relative_wind_dir = wind_dir + aircraft_heading + 360 
        end
    end

    if (wind_dir < aircraft_heading) then
        if ((aircraft_heading > 0 and wind_dir > 0) or (aircraft_heading < 0 and wind_dir < 0)) then 
            relative_wind_dir = wind_dir - aircraft_heading + 360 
        end
        if (aircraft_heading > 0 and wind_dir < 0) then 
            relative_wind_dir = wind_dir - aircraft_heading 
        end
    end

    -- Round the result to a clean integer to prevent decimal flickering
    local clean_integer_dir = math.floor(relative_wind_dir)

    -- Write the result to your custom dataref
    ["WeisAIR/environment/wind_heading_relative_to_aircraft"] = clean_integer_dir
end

-- 4. Run this calculation roughly once per second to conserve CPU performance
do_often("update_relative_wind_direction()")
