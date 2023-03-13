global_player_balance = {}
----------------------------------
-- DEBUGS WRİTER function --SERVER
----------------------------------
function debug(msg,type,r,g,b)
    outputDebugString(getResourceName(getThisResource()).." : - "..msg,type,r,g,b)
end
db = dbConnect( "sqlite", "database/players_balances.db")
if  db then 
    debug("players_balances.db connected ( - players_balances.db database bağlantısı başarılı - ).",3)
else
    debug("players_balances.db is not connected ( - players_balances.db database bağlantısı yok! - ).",1)
end
-------------------------------------------------
--Pull the vehicle chart (Araba tablosunu çekme)
-------------------------------------------------
function get_balances_table()
    if db then 
        local balance = dbPoll(dbQuery(db, "SELECT * FROM balances"),-1)
        return balance
    else
        debug("players_balances.db is not connected ( - players_balances.db database bağlantısı yok! - ).",1)
    end
end
---------------------------------------------
--resource  opened and attached  db table to global table ( - script çalışınca db araç tablosunu global tabloya ekler - )
----------------------------------------------
function resource_start_db()
    local list = get_balances_table()
    for k,v in ipairs(list) do
        global_player_balance[v.account_name] = {v.account_name,v.balance,v.history,v.cryptos}
     end
end
addEventHandler("onResourceStart",resourceRoot,resource_start_db)


---------------------------------------
-- save new player balance
----------------------------------------
function save_new_account_db(account_name)
    local t = {}
    local status = dbExec(db,"INSERT INTO balances (account_name,balance,history,cryptos) VALUES(?,?,?,?)",account_name,0,toJSON(t),toJSON(t))
    return status
end

-----------------------------------------
-- set account balance
-----------------------------------------
function  set_balance_db(account_name,balance)
    local status = dbExec(db,"UPDATE balances SET balance = ? WHERE account_name = ?",balance,account_name)
    return status
end

--------------------------------------------
-- set account history
---------------------------------------------
function save_history_db(account_name,history)
    local status = dbExec(db,"UPDATE balances SET history = ? WHERE account_name = ?",history,account_name)
    return
end

--------------------------------------------
-- set account crypto
---------------------------------------------
function save_crypto_db(account_name,crypto)
    local status = dbExec(db,"UPDATE balances SET cryptos = ? WHERE account_name = ?",crypto,account_name)
    return
end
