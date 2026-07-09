prop_time = user_prop_add_enum("Time", "Local,UTC", "Local", "Show local time or UTC")

img_add_fullscreen("watch_backdrop.png")
img_seconds = img_add_fullscreen("watch_second_hand.png")
img_small = img_add_fullscreen("watch_small_hand.png")
img_big = img_add_fullscreen("watch_big_hand.png")

function PT_time(s_l,m_l,h_l,s_z,m_z,h_z)
    
    if user_prop_get(prop_time) == "Local" then
        s = s_l
        m = m_l
        h = h_l
    else
        s = s_z
        m = m_z
        h = h_z
    end

    rotate(img_seconds, s*6)
    rotate(img_small, h*30 + m*6/12)
    rotate(img_big, m*6)

end

xpl_dataref_subscribe("sim/cockpit2/clock_timer/local_time_seconds", "INT",
                      "sim/cockpit2/clock_timer/local_time_minutes", "INT",
                      "sim/cockpit2/clock_timer/local_time_hours", "INT", 
                      "sim/cockpit2/clock_timer/zulu_time_seconds", "INT",
                      "sim/cockpit2/clock_timer/zulu_time_minutes", "INT",
                      "sim/cockpit2/clock_timer/zulu_time_hours", "INT", PT_time)
fsx_variable_subscribe("LOCAL TIME", "Seconds",
                       "LOCAL TIME", "Minutes",
                       "LOCAL TIME", "Hours", 
                       "ZULU TIME", "Seconds",
                       "ZULU TIME", "Minutes",
                       "ZULU TIME", "Hours", PT_time)
msfs_variable_subscribe("LOCAL TIME", "Seconds",
                          "LOCAL TIME", "Minutes",
                          "LOCAL TIME", "Hours", 
                          "ZULU TIME", "Seconds",
                          "ZULU TIME", "Minutes",
                          "ZULU TIME", "Hours", PT_time)                       