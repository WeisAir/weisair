frame_prop = user_prop_add_boolean("Show display frame", true, "draw a frame around the display")

if user_prop_get(frame_prop) == true then
    background = img_add_fullscreen("display_frame.png")
    video_stream_id = video_stream_add("xpl/gauges[1]", 6, 5, 400-13+70, 300-10+70, 30, 260, 400, 300)
else
    video_stream_id = video_stream_add("xpl/gauges[1]", 0, 0, 400+70, 300+70, 30, 260, 400, 300)

end