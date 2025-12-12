--[[
*****************************************************************
************FSS ERJ - 1XX - Takeoff Button*********************
*****************************************************************
##Left To Do:
    - N/A
	
##Notes:
    - N/A
******************************************************************************************
--]]

img_add_fullscreen("background2.png")

--T/O Button--------------------------------------------------------------------
local TO_value = 0 

function TO_Engage()
        xpl_command("XCrafts/ERJ/takeoff","FLOAT")
end
TO_ENG = button_add(nil, "circle_pressed.png", 392, 122, 230, 230, TO_Engage) 