local garmin = instrument_get("72b0d55c-e681-4373-91c2-dec09e6a8009")
visible(garmin,false)

local garmin_is_visible = false

function garmin_toggle_callback()
  
    if (garmin_is_visible == false) then 
          visible(garmin,true)
          garmin_is_visible = true
    else
          visible(garmin,false)
          garmin_is_visible = false
    end
end

garmin_toggle_button = button_add("garmin_toggle.png", "garmin_toggle.png", 1825, 0, 90 ,45, garmin_toggle_callback)