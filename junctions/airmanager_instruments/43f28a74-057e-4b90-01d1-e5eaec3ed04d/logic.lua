frame_prop = user_prop_add_boolean("Show display frame", true, "draw a frame around the display")

if user_prop_get(frame_prop) == true then
    --background = img_add_fullscreen("display_frame.png")
    --video_stream_id = video_stream_add("xpl/gauges[1]", 6, 7, 400-12, 470-15, 0, 546, 400, 470)
    video_stream_id = video_stream_add("xpl/gauges[1]", 6, 7, 400-12, 470-15, 0, 546, 400, 470)
else
    --video_stream_id = video_stream_add("xpl/gauges[1]", 0, 0, 400, 470, 0, 546, 400, 470)
end