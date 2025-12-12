my_image = img_add_fullscreen("background_rect.png")
local add_frame = user_prop_add_boolean("Add Frame to Annunciator", true, "Shows a tiny frame around the annunciator on demand.")

if user_prop_get(add_frame) == true then
    annunciator_inactive = img_add("ann_inactive.png",3,3,100,79) 
    annunciator_active = img_add("ann_active.png",3,3,100,79) 
else
    annunciator_inactive = img_add_fullscreen("ann_inactive.png") 
    annunciator_active = img_add_fullscreen("ann_active.png")
end 

visible(annunciator_active,false)

function ann_value (condition)
    visible( annunciator_active, condition > 0)
end

function  press_callback()
    xpl_command( "les/sf34a/acft/avio/mnp/alt_selector_canx_button")
end

function release_callback()
    xpl_command( "les/sf34a/acft/avio/mnp/alt_selector_canx_button",0)
end

btn = button_add(nil,nil,0,0,136,65, press_callback)

-- Simulator data subscription
xpl_dataref_subscribe("les/sf34a/acft/ltng/lit/alt_alert_annun", "FLOAT", ann_value)