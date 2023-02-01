profile_urls = {}
crypto_list = {}

-------------------------------------------
--get crypto
-------------------------------------------
fetchRemote(crypto_link,function(veri,err2)
    if err2 == 0 and veri ~= "ERROR" then 
        if  veri then 
            crypto_list = veri
        end
    end
end)

setTimer(function()
    fetchRemote(crypto_link,function(veri,err2)
        if err2 == 0 and veri ~= "ERROR" then 
            if  veri then 
                crypto_list = veri
            end
        end
    end)
    for k,v in ipairs(getElementsByType("player")) do 
        triggerClientEvent("refresh_crypto_list",v,crypto_list)
    end
end,crypto_change_timer,0)

-------------------------------------------
--player login
----------------------------------------------
function player_login(_,account)
    local account_name = getAccountName(account)
    local player_values = global_player_balance[account_name]
    local iban = "null"
    local player_url = profile_urls[account_name]
    for k,v in ipairs(getAccounts()) do 
        if v == account then 
            iban = k 
            break 
        end
    end
    if player_values then 
        triggerClientEvent("send_player_values",source,player_values,iban,player_url,crypto_list)
    else
        global_player_balance[account_name] = {account_name,0,toJSON({})}
        save_new_account_db(account_name)
        triggerClientEvent("send_player_values",source,{account_name,0,toJSON({})},iban,player_url,crypto_list)
    end
end
addEventHandler("onPlayerLogin",root,player_login)

---------------------------------------------------------------------
--on resource start 
--------------------------------------------------------------
function start_source()
    for s,p in ipairs(getElementsByType("player")) do 
        local account = getPlayerAccount(p)
        if account then 
            local account_name = getAccountName(account)
            local player_values = global_player_balance[account_name]
            local iban = "null"
            for k,v in ipairs(getAccounts()) do 
                if v == account then 
                    iban = k 
                    break 
                end
            end
            if player_values then 
                triggerClientEvent("send_player_values",p,player_values,iban,crypto_list)
            else
                global_player_balance[account_name] = {account_name,0,toJSON({})}
                save_new_account_db(account_name)
                triggerClientEvent("send_player_values",p,{account_name,0,toJSON({})},iban,crypto_list)
            end
        end
    end
end
setTimer(start_source,1000,1)

----------------------------------------------------
--sell crypto server
----------------------------------------------------
function sell_crypto(value,account_name,offer,crypto)
    local player_values = global_player_balance[account_name]
    if player_values then 
        offer = math.floor((offer-((offer*crypto_transaction_rate)/100)))
        local _,balance,history,criptos = unpack(player_values)
        history = save_change_log(history,crypto.."-"..value,"crypto2",offer,true,false,account_name)
        set_balance_db(account_name,balance+offer)
        triggerClientEvent("refresh_money_meta",source,balance+offer,true)
        criptos = save_cryptos(account_name,criptos,crypto,value,false)
        global_player_balance[account_name] = {account_name,balance-value,history,criptos}
    end
end
addEvent("sell_crypto_meta",true)
addEventHandler("sell_crypto_meta",root,sell_crypto)

----------------------------------------------------
--buy crypto server
----------------------------------------------------
function buy_crypto(value,account_name,offer,crypto)
    local player_values = global_player_balance[account_name]
    if player_values then 
        offer = math.floor((offer+((offer*crypto_transaction_rate)/100)))
        local _,balance,history,criptos = unpack(player_values)
        history = save_change_log(history,crypto.."-"..value,"crypto",offer,false,false,account_name)
        set_balance_db(account_name,balance-offer)
        triggerClientEvent("refresh_money_meta",source,balance-offer,false)
        criptos = save_cryptos(account_name,criptos,crypto,value,true)
        global_player_balance[account_name] = {account_name,balance-value,history,criptos}
    end
end
addEvent("buy_crypto_meta",true)
addEventHandler("buy_crypto_meta",root,buy_crypto)

function save_cryptos(account_name,criptos,crypto,value,state)
    criptos = fromJSON(criptos)
    local status = true
    for k,v in ipairs(criptos) do 
        if v[1] == crypto then 
            status = false
            if state then 
                v[2] = v[2] + value
            else
                v[2] = v[2] - value
            end
            break
        end
    end
    if status then 
        table.insert(criptos,{crypto,value})
    end
    criptos = toJSON(criptos)
    save_crypto_db(account_name,criptos)
    triggerClientEvent("refresh_crypto_meta",source,criptos)
    return criptos
end

----------------------------------------------------
--withdraw money server
----------------------------------------------------
function withdraw_money(value,account_name)
    local player_values = global_player_balance[account_name]
    if player_values then 
        local _,balance,history,criptos = unpack(player_values)
        history = save_change_log(history,false,"withdraw",value,false,false,account_name)
        set_balance_db(account_name,balance-value-money_transfer_fee)
        global_player_balance[account_name] = {account_name,balance-value,history,criptos}
        givePlayerMoney(source,value)
    end
end
addEvent("withdraw_meta_money",true)
addEventHandler("withdraw_meta_money",root,withdraw_money)

----------------------------------------------------
--deposit money server
----------------------------------------------------
function deposit_money(value,account_name)
    local player_values = global_player_balance[account_name]
    if player_values then 
        local _,balance,history,criptos = unpack(player_values)
        set_balance_db(account_name,balance+value-money_transfer_fee)
        history = save_change_log(history,false,"deposit",value,true,false,account_name)
        global_player_balance[account_name] = {account_name,balance+value,history,criptos}
        takePlayerMoney(source,value)
    end
end
addEvent("deposit_meta_money",true)
addEventHandler("deposit_meta_money",root,deposit_money)

----------------------------------------------------
--transfer money server
----------------------------------------------------
function transfer_money(value,account_name,iban_value)
    local player_values = global_player_balance[account_name]
    local transfer_account_name = false
    value = value - money_transfer_fee
    if player_values then 
        for k,v in ipairs(getAccounts()) do 
            if iban_value == tostring(iban_title..k) then 
                transfer_account_name = getAccountName(v)
                break 
            end
        end
        if not transfer_account_name then outputChatBox(language[language_section][11][1],source,255,0,0) return end
        local _,balance,history,criptos = unpack(player_values)
        local _,p2_balance,p2_history,p2_criptos = unpack(global_player_balance[transfer_account_name])
        local player_url = profile_urls[account_name]
        set_balance_db(transfer_account_name,p2_balance+value)
        history = save_change_log(history,false,"sent",value,false,false,account_name)
        p2_history = save_change_log(p2_history,account_name,"receive",value,true,player_url,transfer_account_name)
        set_balance_db(account_name,balance-value)
        global_player_balance[account_name] = {account_name,balance-value,history,criptos}
        global_player_balance[transfer_account_name] = {transfer_account_name,p2_balance+value,p2_history,p2_cripto}
        triggerClientEvent("refresh_money_meta",source,balance-value,false,true)
        local p2 = getAccountPlayer(getAccount(transfer_account_name))
        if p2 then 
            triggerClientEvent("refresh_money_meta",source,p2_balance+value,true,true)
        end
    else
        triggerClientEvent("send_anim",source,false)
    end
end
addEvent("transfer_meta_money",true)
addEventHandler("transfer_meta_money",root,transfer_money)

------------------------------------------------
-- save money change log
-------------------------------------------------
function save_change_log(t,account_name,information,amount,state,profile_url,player_account)
    local time= getRealTime()
    local min = time.minute
    local hour = time.hour
    local day = time.monthday
    local month = time.month+1
    local year = time.year+1900
    local time = day.."/"..month.."/"..year.."-"..hour..":"..min
    t = fromJSON(t)
    if type(t) == "string" then t = {} end
    table.insert(t,{account_name,information,amount,state,time,profile_url})
    save_history_db(player_account,toJSON(t))
    triggerClientEvent("refresh_history_meta",source,toJSON({account_name,information,amount,state,time,profile_url}),toJSON(t))
    return toJSON(t)
end

----------------------------
--load img 
------------------------------
function player_load_img(url,account_name)
    profile_urls[account_name] = url 
end
addEvent("load_img_meta",true)
addEventHandler("load_img_meta",root,player_load_img)
