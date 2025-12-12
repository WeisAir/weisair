frame_prop = user_prop_add_boolean("Show display frame", true, "draw a frame around the display")

if user_prop_get(frame_prop) == true then
    background = img_add_fullscreen("display_frame.png")
    video_stream_id = video_stream_add("xpl/gauges[1]", 13, 13, 816, 816, 13, 1031, 500, 500)
else
    video_stream_id = video_stream_add("xpl/gauges[1]", 0, 0, 843, 843, 13, 1031, 500, 500)
end