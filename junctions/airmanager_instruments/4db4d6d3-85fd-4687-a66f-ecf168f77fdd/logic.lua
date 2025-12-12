background = img_add_fullscreen("background.png")

----instrument properties
local prop_screws = user_prop_add_boolean("Show screws", true, "Show the screws")

----local params
local instrument_height = 520    
local instrument_width = 520
local screw_width = 30  
local screw_height = 30
local screw_border_offset = 45

----screws
screw_ul = img_add("screw.png", screw_border_offset, screw_border_offset, screw_width, screw_height)
screw_ll = img_add("screw.png", screw_border_offset, instrument_height - screw_border_offset - screw_height , screw_width, screw_height)
screw_ur = img_add("screw.png", instrument_width - screw_border_offset - screw_width, screw_border_offset, screw_width, screw_height)
screw_lr = img_add("screw.png", instrument_width - screw_border_offset - screw_width, instrument_height - screw_border_offset - screw_height, screw_width, screw_height)


ias_marker = img_add_fullscreen("ias_marker.png")
speed_bug = img_add_fullscreen("speed_bug.png")
vmo_marker = img_add_fullscreen("vmo_marker.png")
speed_marker = img_add_fullscreen("speed_marker.png")

function rotate_bug_knob(direction)
  if (direction == 1) then xpl_command("sim/autopilot/airspeed_up") end
  if (direction == -1) then xpl_command("sim/autopilot/airspeed_down") end
end

function set_speed_markers(direction)
--speedmarkers t.b.d.
--ixeg/733/airspeed/IAS_pilot_bug1_ind (bug1 bis bug5) in Grad
 end

--bug knob dial
bug_knob = dial_add("bug_knob.png", 15,405,88,88,rotate_bug_knob)
--speed_marker_fake_knob = dial_add("", 0,0,520,520,set_speed_markers)

-- speeds callback function
 function speed_vals(airspeed_deg, targetspeed_deg, vmo_deg)
 
             rotate(ias_marker,airspeed_deg)
             rotate(vmo_marker, vmo_deg)
             rotate(speed_bug,targetspeed_deg)
 end

 -- subscribe X-plane datarefs on the AirBus
 xpl_dataref_subscribe(
     "ixeg/733/airspeed/IAS_pilot_knots_ind", "FLOAT", -- current airspeed pilot side in deg
     "ixeg/733/airspeed/IAS_pilot_vtgt_bug_ind", "FLOAT", -- bug position in degrees
     "ixeg/733/airspeed/IAS_pilot_vmo_ind", "FLOAT", -- vmo indicator position in degrees   
     
 speed_vals)