if panel_prop("LAYOUT_UUID") == "235c53a2-27d5-4ff6-9020-801d0719e5c0" then
    -- Black background for the top
    canvas_add(0, 0, 1920, 1080, function()
       _rect(0, 0, 1920, 150)
        _fill(0, 0, 0)
    end)
end