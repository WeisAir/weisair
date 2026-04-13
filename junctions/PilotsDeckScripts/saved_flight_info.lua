SimVar("laminar/B738/fms/flight01")
SimVar("laminar/B738/fms/flight01b")

function get_info_saved_flight_1()

    local line1 = SimReadString("laminar/B738/fms/flight01")
    local line2 = SimReadString("laminar/B738/fms/flight01b")

    return line1
end