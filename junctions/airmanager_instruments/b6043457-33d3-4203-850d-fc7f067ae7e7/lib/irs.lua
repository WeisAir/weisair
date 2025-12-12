--THIS LIBRARY ONLY IS MANAGING THE IRS ALLIGNMENT*************************************************************

function lib_irs_init()

img_not_alligned = img_add("background_allign.png", 0,0,900,900)visible(img_not_alligned, false)
img_blackout = img_add("blackout.png", 0,0,900,900)visible(img_blackout, false)

--****************Power management*****************************************************************************
--If avionic is off or power is off, put a black image in front of all other objects
--If IRS is not alligned then put image not alligned on screen.
--The function below is developed and coded by SimPassion, thnx Gilles
				  					  
gbl_power			= false
local prev_volts1	= 0
local prev_volts2	= 0
img_blackout = img_add("PFD_OFF_black.png",0,0 ,900,900)visible(img_blackout,true)

function set_power_xpl(bus_volts,avionics_on,irs)

	if  bus_volts == nil or avionics_on == nil or irs == nil then		--in case there is no signeal at all
		visible(img_blackout,true)
		return
	end

	gbl_power = fif((bus_volts[1] > 10 or bus_volts[2] > 10) and avionics_on, true, false)

	volts1 = math.floor(bus_volts[1])
	volts2 = math.floor(bus_volts[2])
	
	if irs == 1 then				--1=not aligned, 0=aligned
		visible(img_not_alligned, true)
	else
		visible(img_not_alligned, false)
	end
	
	if gbl_power == false then
		visible(img_blackout,true)
	else
		visible(img_blackout,false)
	end

end
xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts", "FLOAT[4]",
					  "sim/cockpit/electrical/avionics_on", "INT",
					  "laminar/B738/irs/pfd_allign", "FLOAT", set_power_xpl)
					  
end