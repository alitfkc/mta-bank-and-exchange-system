local last_opened_tab = 0
player_balance = 0
player_iban = "null" 
player_history_table = {}
player_criptos = {}
player_account_name = ""
panel2_value = ""
crypto_list = {}
local history_img_table = {}
start_timer = false
history = {}
timers_hist = {}
local panel_state = false
dx_table  = {}



function bank_panel_open()
    if not dgsGetVisible(bank_main_panel) then
        dgsSetPosition(bank_main_panel,0.17,-0.6,true)
        dgsMoveTo(bank_main_panel,0.17,0.16,true,"OutElastic",1500)
        dgsSetVisible(bank_main_panel,true)
        panel_state = true
        dgsSetVisible(dgs.main_tab,true)
        dgsSetVisible(dgs.deposit_tab,false)
        dgsSetVisible(dgs.send_tab,false)
        dgsSetVisible(dgs.cripto_tab,false)
        last_opened_tab = 1
        showCursor(true)
        for k,v in pairs(dgs) do
            addEventHandler("onDgsMouseClick",v,dgs_click)
        end
        for k,v in ipairs(profile_img_table) do 
            addEventHandler("onDgsMouseClick",v,dgs_click)
        end
        --addEventHandler("onDgsTextChange",dgs.withdraw_edit,search_vehicles)
        addEventHandler("onClientPlayerWasted",localPlayer,close_panel)
        local a = 500
        for k,v in ipairs(history_img_table) do 
            start_timer = setTimer(function(elm)
                if dgsGetVisible(bank_main_panel) then 
                    dgsSetVisible(elm,true)
                else
                    if isTimer(start_timer) then 
                        killTimer(start_timer)
                        start_timer = false
                    end
                end
            end,a,0,v)
            a = a + 500
            if not dgsGetVisible(bank_main_panel) then break end
        end
        set_history_list()
    end
end

---------------------------------------------------
--close panel
---------------------------------------------------
function close_panel()
    dgsGridListClear(hist_list)
    dgsMoveTo(bank_main_panel,0.17,-0.6,true,"OutElastic",1500)
    dgsSetVisible(panel2,false)
    panel2_value = ""
    panel_state = false
    setTimer(function()
        dgsSetVisible(bank_main_panel,false)
    end,1500,1)
    showCursor(false)
    for k,v in pairs(dgs) do
        removeEventHandler("onDgsMouseClick",v,dgs_click)
    end
    for k,v in ipairs(profile_img_table) do 
        removeEventHandler("onDgsMouseClick",v,dgs_click)
    end
    for k,v in ipairs(timers_hist) do 
        if isTimer(v) then 
            killTimer(v) 
        end
    end
    for k,v in ipairs(dx_table) do 
        destroyElement(v)
    end
    timers_hist = {}
    for k,v in ipairs(history) do 
        destroyElement(v)
    end
    dx_table = {}
    history_img_table = {}
    history = {}
    --removeEventHandler("onDgsTextChange",dgs.withdraw_edit,search_vehicles)
    removeEventHandler("onClientPlayerWasted",localPlayer,close_panel)
end
----------------------------------------------------
-- select tab  button
-----------------------------------------------------
function select_tab(tab_id)
    if tab_id == last_opened_tab then return end
    if last_opened_tab == 1 then 
        dgsSetVisible(dgs.main_tab,false)
    elseif last_opened_tab == 2 then 
        dgsSetVisible(dgs.deposit_tab,false)
    elseif last_opened_tab == 3 then 
        dgsSetVisible(dgs.send_tab,false)
    elseif last_opened_tab == 4 then
        dgsSetVisible(dgs.cripto_tab,false) 
    end 
    if tab_id == 1 then 
        dgsSetVisible(dgs.main_tab,true)
        dgsSetPosition(dgs.main_tab,0.16,-0.6,true)
        dgsMoveTo(dgs.main_tab,0.16,0.28,true,"OutElastic",1500)
    elseif tab_id == 2 then 
        dgsSetVisible(dgs.deposit_tab,true)
        dgsSetPosition(dgs.deposit_tab,0.16,-0.6,true)
        dgsMoveTo(dgs.deposit_tab,0.16,0.28,true,"OutElastic",1500)
    elseif tab_id == 3 then 
        dgsSetVisible(dgs.send_tab,true)
        dgsSetPosition(dgs.send_tab,0.16,-0.6,true)
        dgsMoveTo(dgs.send_tab,0.16,0.28,true,"OutElastic",1500)
    elseif tab_id == 4 then
        dgsSetVisible(dgs.cripto_tab,true) 
        dgsSetPosition(dgs.cripto_tab,0.16,-0.6,true)
        dgsMoveTo(dgs.cripto_tab,0.16,0.28,true,"OutElastic",1500)
    end 
    last_opened_tab = tab_id
end
------------------------------------------------------
--dgs click
-------------------------------------------------------
local tick_count = 0
function dgs_click()
    if (getTickCount()-tick_count) <= 1000 then return end
    if source ==  dgs.server_logo_pane then 
        dgsMoveToBack( dgs.server_logo_pane)
    elseif source == dgs.exit_btn then 
        close_panel()
    elseif source == dgs.main_tab_btn then 
        select_tab(1)
    elseif source == dgs.deposit_tab_btn then 
        select_tab(2)
    elseif source == dgs.send_tab_btn then 
        select_tab(3)
    elseif source == dgs.cripto_tab_btn then 
        select_tab(4)
    elseif source == dgs.withdraw_btn then 
        withdraw_money()
    elseif source == dgs.deposit_btn then 
        deposit_money()
    elseif source == dgs.send_btn then
        transfer_money()
    elseif source == dgs.profile_border then 
        dgsSetVisible(panel2,true)
        dgsBringToFront(panel2)
        panel2_value = "profile"
    elseif source == dgs.close_panel2_btn then 
        dgsSetVisible(panel2,false)
        panel2_value = ""
    elseif source == dgs.buy_cypto_btn  then
        buy_crypto()
    elseif source == dgs.sell_cypto_btn  then
        sell_crypto()
    else
        for k,v in ipairs(profile_img_table) do 
            if v == source then 
                panel2_func(k)
                break
            end
        end
    end
    tick_count = getTickCount()
end

-----------------------------------------------------
-- sell crypto
-----------------------------------------------------
function sell_crypto()
    local value = dgsGetText(dgs.sell_crypto_edit)
    value = tonumber(value)
    if value <= 0 then 
        dgsAlertAnim(bank_main_panel,true)
        return 
    end
    if type(value) ~= "number" then return end
    local Selected = dgsGridListGetSelectedItem(crypto_wallet_list)
    if Selected ~=-1 then 
        local crypto_selected= dgsGridListGetItemText(crypto_wallet_list,Selected,crypto_wallet_list_column_1)
        local piece = dgsGridListGetItemText(crypto_wallet_list,Selected,crypto_wallet_list_column_2)
        local price = 0 
        piece = tonumber(piece)
        local t = fromJSON(crypto_list)
        for k,v in ipairs(t["crypto"]) do 
            if v[1] == crypto_selected then 
                price = v[2]
                break
            end
        end
        local offer = value * tonumber(price)
        if value and value <= piece then 
            triggerServerEvent("sell_crypto_meta",localPlayer,value,player_account_name,offer,crypto_selected)
        else
            outputChatBox(language[language_section][9][1],255,0,0)
            dgsAlertAnim(bank_main_panel,true)
            dgsAlertAnim(dgs.sell_crypto_edit,true)
        end
    else
        outputChatBox(language[language_section][20][1],255,0,0)
        dgsAlertAnim(bank_main_panel,true)
        dgsAlertAnim(crypto_wallet_list,true)
    end
end
-----------------------------------------------------
-- buy crypto
-----------------------------------------------------
function buy_crypto()
    local value = dgsGetText(dgs.buy_crypto_edit)
    value = tonumber(value)
    if value <= 0 then 
        dgsAlertAnim(bank_main_panel,true)
        return 
    end
    if type(value) ~= "number" then return end
    local Selected = dgsGridListGetSelectedItem(crypto_glist)
    if Selected ~=-1 then 
        local crypto_selected= dgsGridListGetItemText(crypto_glist,Selected,crypto_list_column_1)
        local price = dgsGridListGetItemText(crypto_glist,Selected,crypto_list_column_2)
        local offer = value * tonumber(price)
        local temporary_offer = math.floor((offer+((offer*crypto_transaction_rate)/100)))
        if value and  player_balance >= temporary_offer then 
            triggerServerEvent("buy_crypto_meta",localPlayer,value,player_account_name,offer,crypto_selected)
        else
            outputChatBox(language[language_section][9][1],255,0,0)
            dgsAlertAnim(bank_main_panel,true)
            dgsAlertAnim(dgs.buy_crypto_edit,true)
        end
    else
        outputChatBox(language[language_section][20][1],255,0,0)
        dgsAlertAnim(bank_main_panel,true)
        dgsAlertAnim(crypto_glist,true)
    end
end
-----------------------------------------------------
--refresh money
----------------------------------------------------
function refresh_cryptos(t)
    player_criptos = t
    set_player_cryptos()
end
addEvent("refresh_crypto_meta",true)
addEventHandler("refresh_crypto_meta",localPlayer,refresh_cryptos)
----------------------------------------------------
--panel 2 function
----------------------------------------------------
function panel2_func(id)
    if panel2_value == "profile" then
        for k,v in ipairs(profile_img) do 
            if k == id then
                dgsImageSetImage(dgs.profile_img,v)
                triggerServerEvent("load_img_meta",localPlayer,v,player_account_name)
                break
            end
        end 
    end
end
-----------------------------------------------------
-- withdraw money
-----------------------------------------------------
function withdraw_money()
    local value = dgsGetText(dgs.withdraw_edit)
    value = tonumber(value)
    if value <= 0 then 
        dgsAlertAnim(bank_main_panel,true)
        return 
    end
    if value <= money_transfer_fee then
        dgsAlertAnim(bank_main_panel,true)
        return 
    end
    if value and value <= player_balance -money_transfer_fee then 
        player_balance = player_balance - value - money_transfer_fee
        money_change_anim(player_balance+value+money_transfer_fee,player_balance,false)
        triggerServerEvent("withdraw_meta_money",localPlayer,value,player_account_name)
    else
        outputChatBox(language[language_section][9][1],255,0,0)
        dgsAlertAnim(bank_main_panel,true)
        dgsAlertAnim(dgs.withdraw_edit,true)
    end
end

-----------------------------------------------------
-- transfer money
-----------------------------------------------------
function transfer_money()
    local iban_value = dgsGetText(dgs.send_iban_edit)
    if iban_value == "" then 
        outputChatBox(language[language_section][10][1],255,0,0) 
        dgsAlertAnim(bank_main_panel,true)
        dgsAlertAnim(dgs.send_iban_edit,true)
        anim_send(false)
        return 
    end
    if iban_value == tostring(iban_title..player_iban) then 
        outputChatBox(language[language_section][11][1],255,0,0) 
        dgsAlertAnim(bank_main_panel,true)
        dgsAlertAnim(dgs.send_iban_edit,true)
        anim_send(false)
        return 
    end
    local amount_value = dgsGetText(dgs.send_amount_edit)
    amount_value = tonumber(amount_value)
    if amount_value <= 0 then 
        dgsAlertAnim(bank_main_panel,true)
        return 
    end
    if amount_value <= money_transfer_fee then
        dgsAlertAnim(bank_main_panel,true)
        return 
    end
    if amount_value and amount_value<= player_balance  then 
        triggerServerEvent("transfer_meta_money",localPlayer,amount_value,player_account_name,iban_value)
    else
        outputChatBox(language[language_section][9][1],255,0,0)
        dgsAlertAnim(bank_main_panel,true)
        dgsAlertAnim(dgs.send_iban_edit,true)
        anim_send(false)
    end
end


-----------------------------------------------------
-- deposit money
-----------------------------------------------------
function deposit_money()
    local value = dgsGetText(dgs.deposit_edit)
    value = tonumber(value)
    if value <= 0 then 
        dgsAlertAnim(bank_main_panel,true)
        return 
    end
    if value <= money_transfer_fee then
        dgsAlertAnim(bank_main_panel,true)
        return 
    end
    if value and value <= getPlayerMoney(localPlayer)  then 
        player_balance = player_balance + value
        money_change_anim(player_balance-value+money_transfer_fee,player_balance,true)
        anim_deposit(true)
        triggerServerEvent("deposit_meta_money",localPlayer,value,player_account_name)
    else
        outputChatBox(language[language_section][9][1],255,0,0)
        dgsAlertAnim(bank_main_panel,true)
        dgsAlertAnim(dgs.deposit_edit,true)
        anim_deposit(false)
    end
end


-----------------------------------------------------
--refresh money
----------------------------------------------------
function refresh_money(new_balance,state,anim)
    anim_send(anim)
    money_change_anim(player_balance,new_balance,state)
    player_balance = new_balance
end
addEvent("refresh_money_meta",true)
addEventHandler("refresh_money_meta",localPlayer,refresh_money)



------------------------------------------------------
--money change animation
-------------------------------------------------------
local chg_timer = false
local chg_anim_val1 = 0
local chg_anim_val2 = 0
function money_change_anim(oldvalue,newvalue,direction)
    if money_change_anim_access then 
        if isTimer(chg_timer) then 
            killTimer(chg_timer)
            dgsSetText(balance_label,newvalue..currency)
        else
            chg_anim_val1 = oldvalue
            chg_anim_val2 = newvalue
            chg_timer = setTimer(function(direction)
                if direction then 
                    chg_anim_val1 = chg_anim_val1 + 1
                    dgsSetText(balance_label,chg_anim_val1..currency)
                    if chg_anim_val1 == chg_anim_val2 then 
                        killTimer(chg_timer)
                    end
                else
                    chg_anim_val1 = chg_anim_val1 - 1
                    dgsSetText(balance_label,chg_anim_val1..currency)
                    if chg_anim_val1 == chg_anim_val2 then 
                        killTimer(chg_timer)
                    end
                end
            end,5,0,direction)
        end
    else
        dgsSetText(balance_label,newvalue..currency)
    end
end


-------------------------------------------------------
-- get player information
-------------------------------------------------------
function set_player_information(t,iban,c_t)
    player_iban = iban
    local account_name,balance,history,criptos = unpack(t)
    player_balance = balance
    player_history_table = history
    player_criptos = criptos
    player_account_name = account_name
    crypto_list = c_t
    dgsSetText(iban_adress,iban_title..iban)
    dgsSetText(balance_label,balance..currency)
    set_crypto_list()
    set_player_cryptos()
end
addEvent("send_player_values",true)
addEventHandler("send_player_values",localPlayer,set_player_information)

-------------------------------------------------------
-- set player crypto
--------------------------------------------------------
function set_player_cryptos()
    dgsGridListClear(crypto_wallet_list)
    local t = fromJSON(player_criptos)
    for k,v in ipairs(t) do 
        dgsGridListAddRow(crypto_wallet_list,1,v[1],v[2])
    end
end
--------------------------------------------------------
--set crypto list
---------------------------------------------------------
function set_crypto_list()
    if not crypto_list then return end
    dgsGridListClear(crypto_glist)
    local t = fromJSON(crypto_list)
    if not t then return end
    for k,v in ipairs(t["crypto"]) do 
        dgsGridListAddRow(crypto_glist,1,v[1],v[2])
    end
end

-------------------------------
--- Table reverse
-------------------------------
function table.reverse(t) 
    local reversedTable = {} 
    local itemCount = #t  
    for k, v in ipairs(t) do 
        reversedTable[itemCount + 1 - k] = v  
    end 
    return reversedTable  
end 
---------------------------------------------------------
--set history list
----------------------------------------------------------
local hiss_timers = {}
function set_history_list()
    local t = fromJSON(player_history_table)
    t = table.reverse(t)
    local timer = 0
    for k,v in ipairs(t) do 
        timer = timer + 400
        timer_h = setTimer(function(v)
            if not dgsGetVisible(bank_main_panel) then return end
            local account_name,information,amount,state,time,profile_url = unpack(v)
            if account_name then
                for i,t in ipairs(information_img) do 
                    if t[1] == information then 
                        local row = dgsGridListAddRow(hist_list,"","",amount..currency,t[2].." "..account_name,time)
                        if profile_url then 
                            local dx = dxCreateTexture(profile_url)
                            table.insert(dx_table,dx)
                            dgsGridListSetItemImage(hist_list,row,column_1,dx,false,0,0.08,0.7,0.8,true)
                        else
                            if t[3] then 
                                local dx = dxCreateTexture(t[3])
                                table.insert(dx_table,dx)
                                dgsGridListSetItemImage(hist_list,row,column_1,dx,t[4],0,0.08,0.7,0.8,true)
                            end
                        end
                    end
                end
            else
                for i,t in ipairs(information_img) do 
                    if t[1] == information then 
                        local row = dgsGridListAddRow(hist_list,"","",amount..currency,t[2],time)
                        if t[3] then 
                            local dx = dxCreateTexture(t[3])
                            table.insert(dx_table,dx)
                            dgsGridListSetItemImage(hist_list,row,column_1,dx,t[4],0,0.08,0.7,0.8,true)
                        end
                    end
                end
            end
        end,timer,1,v)
        table.insert(timers_hist,timer_h)
    end

end

-----------------------------------------------------
--history money
----------------------------------------------------
function history_money(t,history_t)
    for k,v in ipairs(timers_hist) do 
        if isTimer(v) then 
            killTimer(v) 
        end
    end
    for k,v in ipairs(dx_table) do 
        destroyElement(v)
    end
    timers_hist = {}
    dx_table = {}


    player_history_table = history_t
    dgsGridListClear(hist_list)
    set_history_list()
end
addEvent("refresh_history_meta",true)
addEventHandler("refresh_history_meta",localPlayer,history_money)


-----------------------------------------------
--refresh crypto list 
------------------------------------------------
function refresh_crypto_list_s(t)
    crypto_list = t
    set_crypto_list()
end
addEvent("refresh_crypto_list",true)
addEventHandler("refresh_crypto_list",localPlayer,refresh_crypto_list_s)



--------------------------------------------------
--dgs Alert Animation ( - dgs uyarı animasyonu - )
---------------------------------------------------
function dgsAlertAnim(element,relative)
    if not element then return end
    local elm_x,elm_y = dgsGetPosition(element,relative)
    local elm_w,elm_h = dgsGetSize(element,relative)
    local move_result = 0
    if relative then 
        move_result =  0.01
    else
        move_result = 10
    end
    local r,g,b = 255,0,0


    dgsMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500)
    dgsMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,50)
    dgsMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,100)
    dgsMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,150)
    dgsMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,200)
    dgsMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,250)
    dgsMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,300)
    dgsMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,350)
    dgsMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,400)
    setTimer(function(element,elm_x,elm_y,relative)
        dgsStopAniming(element)
        dgsSetPosition(element,elm_x,elm_y,relative)
    end,500,1,element,elm_x,elm_y,relative)
end


----------------------------
--anim deposit
---------------------------
function anim_deposit(state)
    if state then 
        dgsMoveTo(dgs.deposit_img,0.37,-0.25,true,"CosineCurve",500)
        dgsMoveTo(dgs.deposit_img,0.37,0.05,true,"CosineCurve",500,600)
        setTimer(function()
            dgsSetPosition(dgs.deposit_img,0.37,0.05,true)
        end,1001,1)
    else
        dgsSetProperty(dgs.deposit_img,"color",tocolor(255,0,0,255))
        setTimer(function()
            dgsSetProperty(dgs.deposit_img,"color",tocolor(133,187,101,255))
        end,1000,1)
    end
end


---------------------------------------------------
--anim send 
---------------------------------------------------
function anim_send(state) 
    if state then 
        dgsMoveTo(dgs.send_img,0.37,-0.35,true,"OutElastic",900)
        dgsAlphaTo(dgs.send_img,0,"Linear",900)
        dgsMoveTo(dgs.send_img,0.37,0.35,true,"OutElastic",1,900)
        dgsMoveTo(dgs.send_img,0.37,0.05,true,"OutElastic",900,1000)
        dgsAlphaTo(dgs.send_img,1,"OutElastic",900,1000)
    else
        dgsSetProperty(dgs.send_img,"color",tocolor(255,0,0,255))
        setTimer(function()
            dgsSetProperty(dgs.send_img,"color",tocolor(255,127,0,255))
        end,1000,1)
    end
end
addEvent("send_anim",true)
addEventHandler("send_anim",localPlayer,anim_send)

