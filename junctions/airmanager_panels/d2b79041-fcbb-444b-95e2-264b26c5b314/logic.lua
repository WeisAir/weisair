local garmin = instrument_get("72b0d55c-e681-4373-91c2-dec09e6a8009")
local xpdr = instrument_get("327e70b2-c68a-425b-b687-17ec00fea6f3")

visible(garmin,false)
visible(xpdr,false)

local garmin_is_visible = false
local xpdr_is_visible = false

function garmin_toggle_callback()
  
    if (garmin_is_visible == false) then 
          visible(garmin,true)
          garmin_is_visible = true
    else
          visible(garmin,false)
          garmin_is_visible = false
    end
end

function xpdr_toggle_callback()
  
    if (xpdr_is_visible == false) then 
          visible(xpdr,true)
          xpdr_is_visible = true
    else
          visible(xpdr,false)
          xpdr_is_visible = false
    end
end

garmin_toggle_button = button_add("panel_button_G530.png", "panel_button_G530.png", 1745, 0, 170 ,85, garmin_toggle_callback)
xpdr_toggle_button = button_add("panel_button_XPDR.png", "panel_button_XPDR.png", 1745, 100, 170 ,85, xpdr_toggle_callback)