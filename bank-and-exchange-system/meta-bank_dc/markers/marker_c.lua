function marker_hit()
    bank_panel_open()
end

addEvent("open_meta_bank_panel",true)
addEventHandler("open_meta_bank_panel",localPlayer,marker_hit)