-- Generic clock by flyatr
-- remove the bezel by clicking in the top left corner of the instrument

-- config storage 
clock_config = persist_add("show_bezel","INT",1)
clock_gmt = persist_add("gmt","INT",0)

-- global variables
local cfg_show_bezel = persist_get(clock_config)    -- Load the bezel setting
local timer_state    = 0                            -- 0: Stopped and reset 1:running 2:stopped
local timer_value    = 0
local show_gmt       = persist_get(clock_gmt)        -- Greenwich mean time selection

-- Fonts
font = "size:34px; color: #D62100; halign: right;"

-- Images
img_no_bezel = img_add_fullscreen("black.png")
img_bezel = img_add_fullscreen("background.png")

visible(img_bezel, cfg_show_bezel == 1)
visible(img_no_bezel, cfg_show_bezel == 0)

-- Texts
txt_clock = txt_add(" ", font, 45, 48, 100, 60)
txt_timer = txt_add(" ", font, 176,48, 100, 60)

-- Buttons
function button_pressed()
    if timer_state == 2 then
        timer_state = 0
        timer_value = 0
    else
        timer_state = timer_state + 1
    end
end
button_add("button.png", "button_press.png", 258,96,27,27,button_pressed)

function switch_moved(position, direction)
    show_gmt = fif(show_gmt == 0, 1, 0)
    switch_set_position(gmt_switch, show_gmt)
    persist_put(clock_gmt, show_gmt)
    request_callback(new_fsx_data)
    request_callback(new_xpl_data)
end
gmt_switch = switch_add("switch_left.png", "switch_right.png", 44,94,52,27,switch_moved)
switch_set_position(gmt_switch, math.floor(show_gmt))

function bezel_config()                -- Remove the bezel by clicking in the top left corner of the instrument
    if cfg_show_bezel == 1 then
        cfg_show_bezel = 0
        visible(img_bezel,false)
        visible(img_no_bezel, true)
    else
        cfg_show_bezel = 1
        visible(img_bezel, true)
        visible(img_no_bezel, false)
    end
    persist_put(clock_config, cfg_show_bezel)    -- Save setting
end
switch_add(nil,nil,0,0,80,50,bezel_config)

-- Timer
function timer_callback()

    if timer_state == 1 then
        timer_value = timer_value + 1
    end
    
    txt_set(txt_timer, string.format("%02.0f:%02.0f", math.floor((timer_value / 60) % 60), (timer_value % 60)) )
end

-- Data
function new_fsx_data(tZulu_hours, tZulu_minutes, tLocal_hours, tLocal_minutes, bus_volts)

    if show_gmt == 1 then
        txt_set(txt_clock, string.format("%02.0f:%02.0f", math.floor(tZulu_hours), math.floor(((tZulu_minutes/60)%1)*60)) )
    else
        txt_set(txt_clock, string.format("%02.0f:%02.0f", math.floor(tLocal_hours), math.floor(((tLocal_minutes/60)%1)*60)) )
    end

    visible(txt_clock, bus_volts > 10)
    visible(txt_timer, bus_volts > 10)
end

function new_xpl_data(tZulu_hours, tZulu_minutes, tLocal_hours, tLocal_minutes, bus_volts)
    
    new_fsx_data(tZulu_hours, tZulu_minutes, tLocal_hours, tLocal_minutes, bus_volts[1])
    
end

fsx_variable_subscribe("ZULU TIME", "Hours",
                       "ZULU TIME", "Minutes",
                       "LOCAL TIME", "Hours",
                       "LOCAL TIME", "Minutes",
                       "ELECTRICAL MAIN BUS VOLTAGE", "Volts", new_fsx_data)
fs2020_variable_subscribe("ZULU TIME", "Hours",
                          "ZULU TIME", "Minutes",
                          "LOCAL TIME", "Hours",
                          "LOCAL TIME", "Minutes",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", new_fsx_data)                       
xpl_dataref_subscribe("sim/cockpit2/clock_timer/zulu_time_hours", "INT", 
                      "sim/cockpit2/clock_timer/zulu_time_minutes", "INT",
                      "sim/cockpit2/clock_timer/local_time_hours", "INT",
                      "sim/cockpit2/clock_timer/local_time_minutes", "INT",
                      "sim/cockpit2/electrical/bus_volts", "FLOAT[6]", new_xpl_data) 
                        
timer_start(0,1000,timer_callback)                        