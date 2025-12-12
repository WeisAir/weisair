local torque1 				= instrument_get("a88ca16b-ebac-461a-ae14-44b1bf04049c",0)
local torque2 				= instrument_get("a88ca16b-ebac-461a-ae14-44b1bf04049c",1)
local eng_rpm1			= instrument_get("dcc37713-581f-478b-21b7-240100ad986a",0)
local eng_rpm2			= instrument_get("dcc37713-581f-478b-21b7-240100ad986a",1)
local prop_rpm1			= instrument_get("43fdf6a7-5988-4ed8-9594-c9401c2c89e4",0)
local prop_rpm2			= instrument_get("43fdf6a7-5988-4ed8-9594-c9401c2c89e4",1)
--local flaps 				= instrument_get("3f0396e9-6545-4a19-3d29-680d52ca1a16")
local eng_oil_temp1 		= instrument_get("74d86c80-dec5-444f-0a5f-17a22658d3dc",0)
local eng_oil_temp2		= instrument_get("74d86c80-dec5-444f-0a5f-17a22658d3dc",1)
local prop_oil_temp1		= instrument_get("e5a27d53-1bb3-49b4-892a-7061a09069d6",0)
local prop_oil_temp2		= instrument_get("e5a27d53-1bb3-49b4-892a-7061a09069d6",1)
local annuns				= instrument_get("7f066bed-2f9e-4b59-846b-6302f10116c9")
local fuel_flow1			= instrument_get("fbb038ed-18f3-4b78-09ee-4a5feab9b338",0)
local fuel_flow2			= instrument_get("fbb038ed-18f3-4b78-09ee-4a5feab9b338",1)
local fuel_gauge1			= instrument_get("6b5aeb9b-d227-4fbb-3c6d-3896d0d7adc9",0)
local fuel_gauge2			= instrument_get("6b5aeb9b-d227-4fbb-3c6d-3896d0d7adc9",1)
																	  																	  
local garmin				= instrument_get("72b0d55c-e681-4373-91c2-dec09e6a8009")
gauges_annuns = group_add(torque1, torque2, eng_rpm1, eng_rpm2, prop_rpm1, prop_rpm2, eng_oil_temp1, eng_oil_temp2, prop_oil_temp1, prop_oil_temp2, annuns, fuel_flow1, fuel_flow2, fuel_gauge1, fuel_gauge2)

visible(garmin,false)
visible(gauges_annuns,true)

local garmin_is_visible = false

function garmin_toggle_callback()
  
    if (garmin_is_visible == false) then 
          visible(garmin,true)
          visible(gauges_annuns,false)
          garmin_is_visible = true
    else
          visible(garmin,false)
          visible(gauges_annuns,true)
          garmin_is_visible = false
    end
end

garmin_toggle_button = button_add("garmin_toggle.png", "garmin_toggle.png", 1760, 290, 120 , 68, garmin_toggle_callback)
z_order(garmin_toggle_button,100000000000000000)
