--THIS LIBRARY IS MANAGING THE COMPASSROSE AT THE BOTTOM OF THE PFD----------------------------

function lib_compasrose_init()


img_compasrose = img_add("compass_rose.png", 90, 790, 610, 610)
img_ground_track = img_add("ground_track_ind.png",375, 795, 40, 610)
img_headind = img_add("headingbug.png", 365, 770, 40, 25)	--365, 735,61, 680
img_add("heading_triangle.png", 370, 755, 50, 40)

txt_hdg = txt_add(" ", "size:22px; font:BCG.ttf; color: magenta;  halign:right;", 160, 865, 200, 100)
txt_add("MAG", "size:22px; font:BCG.ttf; color: lime;  halign:right;", 290, 865, 200, 100)

local heading_angle = 0
local x = 0
local y = 0
local my_track = 0

function new_heading(elecheading, ground_track, mag_var, mcpheading)

	--Rotate compass
		img_rotate(img_compasrose, elecheading * -1)
--print(elecheading)		
	--Rotate ground track indicator
		--my_track = (math.rad(ground_track*-1))
		--my_mag_var = math.rad(mag_var)
		--img_rotate(img_ground_track, my_track + mag_var)
		--img_rotate(img_ground_track, my_track)
		my_track = (ground_track - elecheading )
		img_rotate(img_ground_track, my_track)
--print(my_track)		
	--Heading text and true heading, etc...
	txt_set(txt_hdg, string.format("%03d" .. " H", var_round(mcpheading,0)))
	--AP heading dialled in
	heading_angle = (elecheading - mcpheading)*-1
	x, y = geo_rotate_coordinates(heading_angle, 320)
	move(img_headind, x+375, y+1090, nil,nil)
	img_rotate(img_headind, heading_angle)
		
end
xpl_dataref_subscribe("sim/cockpit/gyros/psi_ind_degm3", "FLOAT",								--elecheading
					  "laminar/B738/pfd/track_line", "FLOAT",									--ground_track
					  "sim/flightmodel/position/magnetic_variation", "FLOAT",					--mag_var
					  "laminar/B738/autopilot/mcp_hdg_dial", "FLOAT", new_heading)				--mcpheading
--laminar/B738/FMS/v2_15
--laminar/B738/FMS/v2_bugs

----------------------------------------------------------------------------------------------------------------------
end