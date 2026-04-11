SimVar("sim/cockpit2/gauges/indicators/wind_heading_deg_mag")
SimVar("sim/cockpit/autopilot/heading_mag")

function get_relative_wind_direction()

    local wind_dir = SimRead("sim/cockpit2/gauges/indicators/wind_heading_deg_mag")
    local aircraft_heading = SimRead("sim/cockpit/autopilot/heading_mag")

    return wind_dir + (360-aircraft_heading)
end