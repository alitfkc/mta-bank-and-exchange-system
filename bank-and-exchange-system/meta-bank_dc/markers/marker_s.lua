local function resource_start_marker()
    for k,v in ipairs(atms) do 
        local x,y,z,scale,type,r,g,b,a = unpack(v)
        local marker = createMarker(x,y,z,type,scale,r,g,b,a,root)
        addEventHandler("onMarkerHit",marker,marker_join)
    end
end

--------------------------------------------------------
-- Marker hit open bank panel ( - Markere girince banka paneli açılması - )
----------------------------------------------------------
function marker_join(hit)
    if getElementType(hit) ~= "player" then return end
    local state = triggerClientEvent("open_meta_bank_panel",hit)
end
addEventHandler("onResourceStart",resourceRoot,resource_start_marker)