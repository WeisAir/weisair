--**************************************--
------------------------------------------
-- This is a Boeing 737 primary flight display (PFD) compatible with the B737-800X aka ZiboMod--
-- Script partialy adapted by Yves Levesque from Aspen EFD1000 Made by Ralph   -- 
-- Some images are copied from the PFD x737-800 made by Ralph
-- Made by Derk Nijweide aka Jedeen  --

------------------------------------------
--**************************************--

--Init the middle section of the PFD
lib_center_init()

img_add("background2_vorige.png",0,0 ,900,900)

--Init the flight directors
lib_flight_directors_init()

-- Init speedtape lib
lib_speedtape_init()

-- Init vertical speed indicator
lib_vertical_speed_indicator_init()

--Init extra info for right side of PFD
lib_extra_info_right_init()	

-- Init alttape lib
lib_alttape_init()

-- Init info at the top of PFD
lib_infobar_top_init()

--Init AoA and RA lib
lib_aoa_ra_init()

-- Init extra info at the left side of the PFD
lib_extra_info_left_init()

--Additional info for left side of PFD, like min maneuver, max maneuver, Vspeeds and bugs
lib_new_info_left_init()

--Only the FMA function
lib_fma_init()

--Init the compasrose at the bottom of the pfd
lib_compasrose_init()

--Init center navigation library
lib_center_navigation_init()

--Init lybrary with other stuff
lib_other_stuff()

--Init irs library
lib_irs_init()

