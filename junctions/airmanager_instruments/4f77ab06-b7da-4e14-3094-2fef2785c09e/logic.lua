frame_prop = user_prop_add_boolean("Show display frame", true, "draw a frame around the display")

--video_stream_id = video_stream_add(key, x, y, width, height, tex_x, tex_y, tex_width, tex_height)

if user_prop_get(frame_prop) == true then
    background = img_add_fullscreen("display_frame.png")
    video_stream_id = video_stream_add("xpl/gauges[1]", 13, 13, 816, 816, 0, 1244, 629, 629)
else
    video_stream_id = video_stream_add("xpl/gauges[1]", 0, 0, 843, 843, 0, 1244, 629, 629)
end