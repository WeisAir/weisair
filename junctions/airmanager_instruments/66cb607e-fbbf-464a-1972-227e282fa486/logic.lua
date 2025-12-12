frame_prop = user_prop_add_boolean("Show display frame", true, "draw a frame around the display")

if user_prop_get(frame_prop) == true then
    background = img_add_fullscreen("display_frame.png")
    video_stream_id = video_stream_add("xpl/gauges[1]", 12, 15, 750-25, 1014-26, 770, 0, 750, 1014)
else
    video_stream_id = video_stream_add("xpl/gauges[1]", 0, 5, 750, 1014, 770, 0, 750, 1014)
end