--THIS LIBRARY IS MANAGING ONLY THE FLIGHT DIRECTORS IN THE MIDDLE OF THE PFD---------------------


function lib_flight_directors_init()


img_fd_vertical = img_add("FD_vertical.png",392,303,3,300)
img_fd_horizontal = img_add("FD_horizontal.png",245,450,300,3)


-- Autopilot flight director ------------------------------------------------
	function new_flight_director(fd_pitch, fd_roll, fd_show_pitch, fd_show_roll, roll, pitch)
		
		--Autopilot Flight director crossbars
		if fd_show_pitch ==  1 then
			visible(img_fd_horizontal, true)						--pitch
		else
			visible(img_fd_horizontal, false)
		end
		
		if fd_show_roll == 1 then
			visible(img_fd_vertical, true)							--roll
		else
			visible(img_fd_vertical, false)
		end

		img_move (img_fd_horizontal,nil, -((fd_pitch - pitch) *12.7) + 463,nil,nil)		--was 463/460
		img_move (img_fd_vertical, (((fd_roll-roll)*12.7)/4)+393,nil,nil,nil)           

	end
xpl_dataref_subscribe("sim/cockpit/autopilot/flight_director_pitch", "FLOAT",				--fd_pitch
					  "sim/cockpit/autopilot/flight_director_roll",	"FLOAT",				--fd_roll
					  "laminar/B738/autopilot/fd_pitch_pilot_show", "INT",					--fd_show_pitch
					  "laminar/B738/autopilot/fd_roll_pilot_show", "INT",					--fd_show_roll
					  "sim/flightmodel/position/phi", "FLOAT",								--roll
					  "sim/flightmodel/position/theta", "FLOAT",  new_flight_director)		--pitch
					  
end
---------------------------------------------------------------------------------------------------------------