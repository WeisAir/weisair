--THIS LIBRARY MANAGE STUFF THAT COULD NOT BEEN PLACED IN OTHER LIBS**********************************



function lib_other_stuff()

img_green_alt_marker = img_add("green_marker.png", 722, 449, 20, 30)visible(img_green_alt_marker, false)

	function green_marker(level)
	--green altitude block marker in the altitude box	
	visible(img_green_alt_marker, level < 9999)
	end
	
xpl_dataref_subscribe("laminar/B738/autopilot/altitude", "FLOAT", green_marker)

end