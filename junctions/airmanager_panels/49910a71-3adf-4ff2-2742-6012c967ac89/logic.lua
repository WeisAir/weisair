local z2dxpefb_id = instrument_get("cc8ae7fa-eaf1-4228-88c6-05f22630939c")
function compute_efb_show(tablet_state) -- HIDE/UNHIDE Z2DXP EFB Tablet
    if tablet_state == 0 then
        visible(z2dxpefb_id,false)
    else
        visible(z2dxpefb_id,true)
    end
end

xpl_dataref_subscribe("Z2DXP/EFB/ext2dxpefb/show_z2dxp_efb","INT", compute_efb_show)
compute_efb_show(1)