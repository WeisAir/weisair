my_image = img_add_fullscreen("background_square.png")
local add_frame = user_prop_add_boolean("Add Frame to Annunciator", true, "Shows a tiny frame around the annunciator on demand.")
local annun_value_last = 0


if user_prop_get(add_frame) == true then
    annunciator_inactive = img_add("generic_annun_BAR_inactive.png",3,3,82,82) 
    annunciator_active = img_add("generic_annun_BAR_active.png",3,3,82,82) 
else
    annunciator_inactive = img_add_fullscreen("generic_annun_BAR_inactive.png") 
    annunciator_active = img_add_fullscreen("generic_annun_BAR_active.png")
end 

visible(annunciator_active,false)

function annun_value (condition)
    visible( annunciator_active, condition > 0)
end

function  press_callback()
    if annun_value_last == 0 then
        xpl_dataref_write("XCrafts/EICAS/EICAS_full_toggle", "INT", 1)
        annun_value_last = 1
    else
        xpl_dataref_write("XCrafts/EICAS/EICAS_full_toggle", "INT", 0)
        annun_value_last = 0
    end
end

btn = button_add(nil,nil,0,0,136,65, press_callback, "")

-- Simulator data subscription
xpl_dataref_subscribe("XCrafts/EICAS/EICAS_full_toggle", "INT", annun_value)