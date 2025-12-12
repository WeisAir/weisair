axis = img_add("axis.png", 70, 115, 105, 466)
slider = img_add("slider.png", 80, 125, 82, 46)

-- slider 0% = 525
-- slider 100% = 125 

 -- This function will be called when new data is available from X-plane
 function callback(value)
     print("Array contains " .. #value .. " items. Data on 25th position is: " .. value[25])
 end    

 -- subscribe X-plane datarefs on the AirBus
 xpl_dataref_subscribe("sim/joystick/joystick_axis_values", "FLOAT[500]", callback)