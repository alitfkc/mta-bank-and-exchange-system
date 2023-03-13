local function resource_start_map()
    setTimer(function()
        for k,v in ipairs(maps_object) do 
            object=createObject(maps_object[k][1],maps_object[k][2],maps_object[k][3],maps_object[k][4],maps_object[k][5],maps_object[k][6],maps_object[k][7])
            setElementInterior(object,maps_object[k][8])
            setElementDimension(object,maps_object[k][9])
            setObjectScale(object,maps_object[k][10])
            setElementAlpha(object,maps_object[k][11])
        end
    end,2000,1)
    setTimer(function()
        for k,v in ipairs(peds) do
            ped=createPed(peds[k][1],peds[k][2],peds[k][3],peds[k][4],peds[k][5])
            setElementDimension(ped,peds[k][6])
            setElementInterior(ped,peds[k][7])
            setElementFrozen(ped,true)
            setTimer(add_anim,4000,1,ped,peds[k][8],peds[k][9])
        end
    end,4000,1)

end
function add_anim(ped,block,anim) 
    setPedAnimation(ped,block,anim, -1,true, false, false )
end
addEventHandler("onResourceStart",resourceRoot,resource_start_map)