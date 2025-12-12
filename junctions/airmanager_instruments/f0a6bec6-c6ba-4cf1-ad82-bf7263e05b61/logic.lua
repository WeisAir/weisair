-------------------------------------
-- Generic Three Needle Altimeter
-- with Kohlsmann button and Barber Pole
-- J. ZAHAR 03/2017 based on original 
-- Work by Felipe Bessa
-- version 1.20
-- Modified face with real fonts MILSPEC 33558
-- Modified Needle size to match the original
--------------------------------------

---------------------------------------------------------
--
--              CUSTOMIZATION SECTION
--
--  You can modify the variables in this section
--
---------------------------------------------------------

display_dial=true -- Set this variable to false if you don't want the kohlsmann button to be displayed
display_altalerter=true -- Set this variable to true if you want the manual alerter to be displayed
 
---------------------------------------------------------
--         END OF CUSTOMIZATION SECTION
-- DO NOT MODIFIY THE CODE BEYOND THIS POINT !!!!      --
---------------------------------------------------------



--img_add_fullscreen("background.png")
if display_dial then img_add_fullscreen("dial_background.png") end
setdisk = img_add("setdisk.png", 12,1, 500, 500)
img_add_fullscreen("altimeterback.png")
needle_10000 =img_add_fullscreen("altimetercap.png")
needle_1000 = img_add_fullscreen("needle1000.png")
needle_100 = img_add_fullscreen("needle100.png")
--img_cap = img_add_fullscreen("ring.png")


------------------------------
-- Alt alerter bezel        --
-------------------------------

-- Adds a dial, The callback function will be called when the dial is being turned
-- The size of the dial should be the same as the instrument overall size
-- modify it if needed

--usage:
--Rotate the bezel right or left so you place the red Arrow in front of the altitude to be reached.
--The green arrows places automatically 500ft before the target alt, and the yellow Arrow warns you that you are less than 100 ft from target altitude.
rot=0
size=500
function callback(direction)
  -- Direction will have the value
  --  1: When the dial is being turned clockwise
  -- -1: When the dial is being turned anti-clockwise
--  no function since this dial has to be turned manually
if direction==-1 then 
	rot=rot - 3
		rotate(alt_alerter, rot)
		rotate(dial_id, rot)
	else
		rot=rot+3
		rotate(alt_alerter,rot)
		rotate(dial_id, rot)
	end
end

if display_altalerter then
	alt_alerter=img_add("alt_alerter.png", 0,0,size,size)
	dial_id = dial_add("altknob.png", 420, 388, 85, 85,callback)	 
--	dial_id = dial_add("alt_alerter.png", 0,0,size,size,callback)
	dial_click_rotate(dial_id, 3)
end
--------------------------
--KOHLSMAN DIAL FUNCTIONS --
function new_alt(alt)

	if alt == -1 then
		xpl_command("sim/instruments/barometer_down")
		fsx_event("KOHLSMAN_DEC")
		fs2020_event("KOHLSMAN_DEC")
	elseif alt == 1 then
		xpl_command("sim/instruments/barometer_up")
		fsx_event("KOHLSMAN_INC")
		fs2020_event("KOHLSMAN_INC")
	end

end

function new_altitude(altitude, pressure)
    
	k = (altitude/10000)*36
    h = ( (altitude - math.floor(altitude/10000)*10000)/1000 )*36
    t = ( altitude - math.floor(altitude/10000)*10000 )*0.36
    
    rotate(needle_10000, k)
    rotate(needle_1000, h)    
    rotate(needle_100, t) 
    
    kk = k/3.6
    hh = h/36
    tt = t/0.36-hh*1000
    
	barset = var_cap(pressure, 29.1, 30.7)
	
	rotate(setdisk, (((barset - 29.1) * 160 / 1.6) * -1)+80)
end 
	
-- DIALS ADD --
if display_dial then
	img_add("altknobshadow.png", 4,388, 85, 85)
	dial_alt = dial_add("altknob.png", 4, 388, 85, 85, new_alt)
	dial_click_rotate(dial_alt,1)
end  

------ DATAREF SUBSCRIPTION -----
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/altitude_ft_pilot", "FLOAT",
					  "sim/cockpit/misc/barometer_setting", "FLOAT", new_altitude)
fsx_variable_subscribe("INDICATED ALTITUDE", "Feet",
					   "KOHLSMAN SETTING HG", "inHg", new_altitude)
fs2020_variable_subscribe("INDICATED ALTITUDE", "Feet",
					      "KOHLSMAN SETTING HG", "inHg", new_altitude)					   