----------------------------------------
-- RADAR ALTIMERE BENDIX KING KRA 10 A
-- J. ZAHAR 03/2017
----------------------------------------
----------------------------------------
--      CUSTOMIZATION SECTION
----------------------------------------
local display_dial = true -- Set this variable to false if you d'ont want the dial displayed

----------------------------------------------
--      END OF CUSTOMIZATION SECTION
-- DO NOT MODIFIY THE CODE BEYOND THIS POINT!
-----------------------------------------------

-- Load and display text and images
img_add_fullscreen("radaraltimeter3.png")
img_needle = img_add_fullscreen("radarneedle3.png")
img_bug = img_add_fullscreen("radarbug1.png")

img_add_fullscreen("radaraltcover3.png")
img_add_fullscreen("radaraltbezel2.png")
img_add_fullscreen("radaraltjoncblanc2.png")
DH_on=img_add_fullscreen("DH_on3.png")

visible(DH_on, false)
-- Callback functions (handles data received from X-plane)
sound_id = sound_add("DH_Tone.wav") 	--Loads a new sound 	AM 1.0 and up
DH_set=false
-- visible(img_flag, DH_set)
local first_time = false 
local current_alt = 0
local current_dh = 0

--sound_play(sound_id) 
function alt_to_degrees(altitude)
  if altitude <= 500 then
    degrees = altitude * (160 / 500)
  elseif altitude > 500 then
    degrees = 160 + ((altitude - 500) * (77 / 2000))
  end
  
  return degrees
end

 
function new_radioaltitude(radioaltitude)

    radioaltitude = var_cap(radioaltitude, 10,3000)
    current_alt=radioaltitude
    degrees = alt_to_degrees(radioaltitude)

    rotate(img_needle, degrees)
  
    if (current_alt<current_dh) then
        if first_time==true then 
            sound_play(sound_id)
            first_time=false
		end
        DH_set=true
	else
        first_time=true
        DH_set=false
	end

	visible(DH_on,DH_set)
end

function new_radiobug(radiobug)
    radiobug = var_cap(radiobug,0,2500)
    current_dh=radiobug  
    degrees_bug = alt_to_degrees(radiobug)
    rotate(img_bug, degrees_bug)
end

function new_powerflag(powerflag)

	if powerflag == 1 then
		visible(img_flag, false)
	else
		visible(img_flag, true)
	end

end

function new_dh(direction)

	if direction == -1 then
		xpl_command("sim/instruments/dh_ref_down")
		fsx_event("DECREASE_DECISION_HEIGHT")
		fs2020_event("DECREASE_DECISION_HEIGHT")
	elseif direction == 1 then
		xpl_command("sim/instruments/dh_ref_up")
		fsx_event("INCREASE_DECISION_HEIGHT")
		fs2020_event("INCREASE_DECISION_HEIGHT")
	end

end
-- DIALS ADD --
if display_dial then
	img_add("dhknobshadow.png", 4,388, 85, 85)
	dial_alt = dial_add("dhknob.png", 4, 388, 85, 85, new_dh)
	dial_click_rotate(dial_alt,10)
end  
-- subscribe functions on the AirBus
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot","FLOAT",
                      "sim/cockpit2/gauges/indicators/radio_altimeter_dh_lit_pilot","FLOAT", new_radioaltitude)
fsx_variable_subscribe("RADIO HEIGHT", "FEET", new_radioaltitude)
fsx_variable_subscribe("DECISION HEIGHT", "FEET", new_radiobug)
fs2020_variable_subscribe("RADIO HEIGHT", "FEET", new_radioaltitude)
fs2020_variable_subscribe("DECISION HEIGHT", "FEET", new_radiobug)