function give_balance(player,value,tip)
    if not player then return end
    if type(value) ~= "number" then return end
    if not tip then 
        if value < 0 then
            tip = "withdraw"
        else
            tip = "deposit"
        end
    else
        local state = true
        for k ,v in ipairs(information_img) do 
            if v[1] == tip then
                state = false 
                break 
            end
        end
        if state then 
            if value < 0 then
                tip = "withdraw"
            else
                tip = "deposit"
            end
        end
    end
    local account_name = getAccountName(getPlayerAccount(player))
    if account_name then 
        local player_values = global_player_balance[account_name]
        if player_values then 
            local _,balance,history,criptos = unpack(player_values)
            history = save_change_log(history,false,tip,value,true,false,account_name)
            set_balance_db(account_name,balance-value)
            global_player_balance[account_name] = {account_name,balance-value,history,criptos}
        end
    end
end
addEvent("give_balance_meta",true)
addEventHandler("give_balance_meta",root,give_balance)

function get_balance(player)
    if not player then return end
    local account_name = getAccountName(getPlayerAccount(player))
    local player_values = global_player_balance[account_name]
    local iban = "null"
    if player_values then 
        local _,balance,history,criptos = unpack(player_values)
        return balance
    else
        return false
    end
end

function transfer_iban(account_name,value,tip)
    if type(value) ~= "number" then return false end
    if not tip then 
        if value < 0 then
            tip = "withdraw"
        else
            tip = "deposit"
        end
    else
        local state = true
        for k ,v in ipairs(information_img) do 
            if v[1] == tip then
                state = false 
                break 
            end
        end
        if state then 
            if value < 0 then
                tip = "withdraw"
            else
                tip = "deposit"
            end
        end
    end
    if account_name then 
        local player_values = global_player_balance[account_name]
        if player_values then 
            local _,balance,history,criptos = unpack(player_values)
            history = save_change_log(history,false,tip,value,true,false,account_name)
            set_balance_db(account_name,balance-value)
            global_player_balance[account_name] = {account_name,balance-value,history,criptos}
            return true
        end
    end
end