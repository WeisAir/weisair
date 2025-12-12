choice_prop = user_prop_add_enum("Time", "Zulu,Local", "Local", "Choose between Zulu or Local time")

txt_time = txt_add("00:00:00", "size:38px; color: white; halign: center;", -3, 4, 158, 48 )

function new_time(zulu_seconds, zulu_minutes, zulu_hours, local_seconds, local_minutes, local_hours)
    
    if user_prop_get(choice_prop) == "Zulu" then
        hours = zulu_hours
        minutes = zulu_minutes
        seconds = zulu_seconds
    elseif user_prop_get(choice_prop) == "Local" then
        hours = local_hours
        minutes = local_minutes
        seconds = local_seconds
    end

    -- print(seconds%60)
    vis_time = string.format("%02.0f:%02.0f:%02.0f", (hours - (hours%1)), (minutes - (minutes%1))%60, (seconds - (seconds%1))%60)
    txt_set(txt_time, vis_time)
end
                      
xpl_dataref_subscribe("sim/cockpit2/clock_timer/zulu_time_seconds", "INT",
                      "sim/cockpit2/clock_timer/zulu_time_minutes", "INT",
                      "sim/cockpit2/clock_timer/zulu_time_hours", "INT",
                      "sim/cockpit2/clock_timer/local_time_seconds", "INT",
                      "sim/cockpit2/clock_timer/local_time_minutes", "INT",
                      "sim/cockpit2/clock_timer/local_time_hours", "INT", new_time)