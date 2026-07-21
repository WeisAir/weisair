--------------------------------------------------------------------------------
-- I created this while trying to better undertand how the standard X-Plane autopilot functions.
-- This simple instrument demonstrates how to check the bit fields of the autopilot_state dataref to
-- determine the lateral, vertical , thrust, and FMC modes.  To fully understand the meanings of the
-- bit flags see:  http://www.xsquawkbox.net/xpsdk/mediawiki/Sim/cockpit/autopilot/autopilot_state
-- I find it is interesting to look at this to monitor what is happening while flying the sim on autopilot
-- There are deprecated autopilot datarefs but these are the latest and should be good in the future
------------------------------------------------------------------------------------------

--  Changing these variables can move all the graphics for the annunciator lights at once
delta_x=11
delta_y=110

panel_img = img_add_fullscreen ( "background.png" )
--  these are the graphics that make up the annunciator panel

at_on = img_add ( "at_on.png" , delta_x + 0 , delta_y + 0 , 138 , 22 )
hh_on = img_add ( "hh_on.png" , delta_x + 140 , delta_y + 0 , 138 , 22 )
wl_on = img_add ( "wl_on.png" , delta_x + 140 , delta_y + 22 , 138 , 22 )
hn_on = img_add ( "hn_on.png" , delta_x + 140 , delta_y + 44 , 138 , 22 )
hn_arm = img_add ( "hn_arm.png" , delta_x + 140 , delta_y + 44 , 138 , 22 )
ht_on = img_add ( "ht_on.png" , delta_x + 140 , delta_y + 66 , 138 , 22 )
as_on = img_add ( "as_on.png" , delta_x + 280 , delta_y + 0 , 138 , 22 )
vs_on = img_add ( "vs_on.png" , delta_x + 280 , delta_y + 22 , 138 , 22 )
ah_on = img_add ( "ah_on.png" , delta_x + 280 , delta_y + 44 , 138 , 22 )
ah_arm = img_add ( "ah_arm.png" , delta_x + 280 , delta_y + 44 , 138 , 22 )
lc_on = img_add ( "lc_on.png" , delta_x + 280 , delta_y + 66 , 138 , 22 )
ps_on = img_add ( "ps_on.png" , delta_x + 420 , delta_y + 0, 138 , 22 )
gs_on = img_add ( "gs_on.png" , delta_x + 420 , delta_y + 22 , 138 , 22 )
gs_arm = img_add ( "gs_arm.png" , delta_x + 420 , delta_y + 22 , 138 , 22 )
fm_on = img_add ( "fm_on.png" , delta_x + 560 , delta_y + 0 , 138 , 22 )
fm_arm = img_add ( "fm_arm.png" , delta_x + 560 , delta_y + 0 , 138 , 22 )
vn_on = img_add ( "vn_on.png" , delta_x + 420 , delta_y + 44 , 138 , 22 )
vn_arm = img_add ( "vn_arm.png" , delta_x + 420 , delta_y + 44 , 138 , 22 )
vt_on = img_add ( "vt_on.png" , delta_x + 420 , delta_y + 66 , 138 , 22 )

-- groups to turn on and off all green and yellow annunciations
annunc_green = group_add (at_on,hh_on,wl_on, hn_on, ht_on, as_on,vs_on,ah_on,lc_on, ps_on,gs_on,fm_on,vn_on, vt_on)
annunc_yellow = group_add (hn_arm, ah_arm,gs_arm,fm_arm, vn_arm)

-- turn them all off to start
visible( annunc_green, false)
visible( annunc_yellow, false)



-- this turns all lights on when test button is pressed
function  test_all()
visible( annunc_green, true)
visible( annunc_yellow, true)
end
-- this turns all lights off when test button is released
function  test_off()
visible( annunc_green, false)
visible( annunc_yellow, false)
end

test_button = button_add ( "button_out.png"  , "button_in.png" , 513 , 37 , 40 , 40 , test_all , test_off )

-- function shows respective annunciation if the corresponding bit field is on ( == 1) or hides if not 1 (0)
function ap_flags( ap_state )
visible ( at_on,  (ap_state >> 0) & 1)
visible ( hh_on,  (ap_state >> 1) & 1)
visible ( wl_on,  (ap_state >> 2) & 1)
visible ( as_on,  (ap_state >> 3) & 1)
visible ( vs_on,  (ap_state >> 4) & 1)
visible ( ah_arm, (ap_state >> 5) & 1)
visible ( lc_on,  (ap_state >> 6) & 1)
visible ( ps_on,  (ap_state >> 7) & 1)
visible ( hn_arm, (ap_state >> 8) & 1)
visible ( hn_on,  (ap_state >> 9) & 1)
visible ( gs_arm, (ap_state >> 10) & 1)
visible ( gs_on,  (ap_state >> 11) & 1)
visible ( fm_arm, (ap_state >> 12) & 1)
visible ( fm_on,  (ap_state >> 13) & 1)
visible ( ah_on,  (ap_state >> 14) & 1)
visible ( ht_on,  (ap_state >> 15) & 1)
visible ( vt_on,  (ap_state >> 16) & 1)
visible ( vn_arm, (ap_state >> 17) & 1)
visible ( vn_on,  (ap_state >> 18) & 1)
end

--  single dataref tells us us the complete autopilot state via respective bit fields

xpl_dataref_subscribe( "sim/cockpit/autopilot/autopilot_state", "INT",ap_flags )