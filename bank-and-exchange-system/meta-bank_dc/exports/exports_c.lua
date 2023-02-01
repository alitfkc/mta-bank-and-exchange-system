function give_balance(value,type)
    triggerServerEvent("give_balance_meta",localPlayer,localPlayer,value,type)
end
function get_balance()
    return player_balance
end