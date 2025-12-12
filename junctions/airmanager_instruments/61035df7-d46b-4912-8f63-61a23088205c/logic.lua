txt_time = txt_add("00:00:00", "size:38px; color: white; halign: center;", 0, 4, 158, 48 )

function new_time(seconds, minutes, hours)
   
    timer_seconds = seconds[1]
    timer_minutes = minutes[1]
    timer_hours = timer_minutes/60
    
 --   print(timer_seconds)
    
    vis_time = string.format("%02.0f:%02.0f:%02.0f", (timer_hours - (timer_hours%1)), (timer_minutes - (timer_minutes%1))%60, (timer_seconds - (timer_seconds%1))%60)
    txt_set(txt_time, vis_time)
end
                      
xpl_dataref_subscribe("sim/cockpit2/clock_timer/chrono_timer_seconds", "INT[2]",
                      "sim/cockpit2/clock_timer/chrono_timer_minutes", "INT[2]",
                      "sim/cockpit2/clock_timer/elapsed_timer_hours", "INT"
, new_time)