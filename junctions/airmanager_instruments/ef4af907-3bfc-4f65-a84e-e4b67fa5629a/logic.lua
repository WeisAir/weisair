------------------------------------------
--       Copyright Sim Innovations      --
-- Boeing 737 NG Primary Flight Display --
------------------------------------------
-- TO DO TO DO TO DO TO DO TO DO TO DO  --
-- Expanded localizer indicator (PAGE 62)
-- Rising runway indicator (PAGE 65)
-- TO DO TO DO TO DO TO DO TO DO TO DO  --


--------------------- VERDER IN ALTITUDE LIBRARY!!!!!! -------------------

-- Images --
img_add_fullscreen("PFDmain.png")

-- img_fp_vector = img_add("flight_path_vector.png", 314, 354, nil, nil)
-- img_runway_ind = img_add("runway.png", 239, 376, nil, nil)
-- img_max_pitch = img_add("eyebrows.png", 244, 360, 210, 26)

-- Initialize the speed tape library
lib_speed_tape_init()

-- Initialize the altitude tape library
lib_altitude_tape_init()

-- Initialize the vertical speed library
lib_vertical_speed_init()

-- Initialize the heading items in the bottom
lib_heading_init()

-- Initialize the AOA indicator library
-- lib_aoa_init()

-- Initialize the autopilot library
lib_autopilot_init()

-- Initialize the flight director bars in the attitude indicator library
lib_fd_tape_init()

-- Initialize the HSI library
lib_hsi_init()