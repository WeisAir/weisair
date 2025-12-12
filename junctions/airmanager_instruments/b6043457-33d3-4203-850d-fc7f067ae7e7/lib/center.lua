--THIS LIBRARY IS MANAGING EVERYTHING IN THE MIDDLE OF THE PFD---------------------


function lib_center_init()

img_horizon = img_add("horizon.png", -357, -1036, 1500, 3000)
img_horizonscale = img_add("horizonscale.png", -350, -1036, 1500, 3000)
img_roll = img_add("roll.png", 167, 236, 452, 452)
img_slip2 = img_add("slip2.png", 167, 236, 452, 452)
--img_wings = img_add("wings.png", 208,448,380,70)
img_rising_runway = img_add("rising_runway.png",245, 600, 300, 90) --visible(img_rising_runway, false)
img_radio_alt_bg = img_add("radio_alt_back.png",345, 645, 100, 40) --visible(img_radio_alt_bg, false)

txt_radio_altitude = txt_add(" ","size:26px; font:BCG.ttf; color: white;  halign:center;", 352, 654, 80, 30)


viewport_rect(img_horizonscale, 0, 260, 800, 516)
-------------------------------------------------------------------------------------------------------------------

-- Attitude indicator --
function new_attitude(roll, pitch, slip)    

-- Roll outer ring
	rollind = var_cap(roll, -60, 60)
    img_rotate(img_roll, rollind *-1)
  
-- Roll horizon
    img_rotate(img_horizon, roll * -1)
	img_rotate(img_horizonscale, roll * -1)
    
-- Move horizon pitch
    pitch = var_cap(pitch,-55,55)
    radial = math.rad(roll * -1)
    x = -(math.sin(radial) * pitch * 12.7)
    y = (math.cos(radial) * pitch * 12.7)
    img_move(img_horizon, x - 357, y - 1036, nil, nil)
	img_move(img_horizonscale, x - 357, y - 1036, nil, nil)
    
-- Move slip ball
	slip = var_cap(slip * 2,-30,30)
    x = (math.cos(radial) * slip)
    y = (math.sin(radial) * slip)
	img_move(img_slip2, 167 - x, 236 - y, nil, nil) 
    img_rotate(img_slip2, rollind *-1)	
	
end 
--new_attitude(roll, pitch, slip) 
xpl_dataref_subscribe("sim/flightmodel/position/phi", "FLOAT",								--roll
					  "sim/flightmodel/position/theta", "FLOAT",							--pitch 
					  "sim/cockpit2/gauges/indicators/slip_deg", "FLOAT", new_attitude)		--slip
------------------------------------------------------------------------------------------------------------------------------


--*********RISING RUNWAY and RADIO ALTITUDE and GPWS**********************************************************
function rising_runway(agl_alt, onground, ra_chosen, localizer, flight_phase, hor_movement)

 local vertical = ((agl_alt/13.6)*12.5)+453				--rising from 200agl to 0----some tweaking to do
	   vertical = var_cap(vertical,460,600)
 local horizontal = 245 + (hor_movement *45)
	   horizontal = var_cap(horizontal,150,330)	

	if  var_round(agl_alt) < 2500 then										--visible below 2500
		if ra_chosen == 0 or ra_chosen == 1 then		--user has AoA or RA chosen  0=AoA   1=RA  2=Circular RA
			visible(img_radio_alt_bg,true)
			agl_alt = tonumber(agl_alt)
			--txt_set(txt_radio_altitude, string.format("%01d",agl_alt))
			agl_alt = var_round(agl_alt,0)
			txt_set(txt_radio_altitude,string.format("%.f",agl_alt-4))
		elseif ra_chosen == 2 then							--user has Circular RA chosen																--user has RA chosen
			visible(img_radio_alt_bg,false)
			txt_set(txt_radio_altitude,"")
		end	
		
		if localizer == 1 and flight_phase >= 7 then
			visible(img_rising_runway,true)
			img_move(img_rising_runway,(horizontal),nil,nil,nil)			--horizontal movement
				if var_round(agl_alt,0) <= 200 then							--runway moves when below 200 agl			
					img_move(img_rising_runway,nil,vertical,nil,nil)		--vertical movement
				else
					img_move(img_rising_runway,nil,600,nil,nil)
				end
		else
			visible(img_rising_runway,false)
		end
	else
		visible(img_rising_runway,false)
		visible(img_radio_alt_bg,false)
		txt_set(txt_radio_altitude, "")
	end
	
end
xpl_dataref_subscribe("laminar/B738/PFD/agl_pilot", "FLOAT",										--agl_alt
					  "sim/flightmodel2/gear/on_ground", "INT[10]",									--onground
					  "laminar/B738/aoa_ra", "FLOAT",												--ra_chosen  0=AoA  1=RA  2=CircularRA
					  "sim/cockpit2/radios/indicators/hsi_display_horizontal_pilot", "INT",			--localizer
					  "laminar/B738/FMS/flight_phase", "INT",										--flight_phase
					  "sim/cockpit2/radios/indicators/nav1_hdef_dots_pilot", "FLOAT", rising_runway)--hor_movement
-----------------------------------------------------------------------------------------------------------------------

end