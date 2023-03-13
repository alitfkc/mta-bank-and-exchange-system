language = {
    {"EN",
        {"Meta Bank"},
        {"Balance"},
        {"IBAN"},
        {"Withdraw"},
        {"Deposit"},
        {"Transfer"},
        {"Amount of Money"},
        {"Insufficient balance!"},
        {"Please type IBAN!"},
        {"Invalid IBAN"},
        {"Approval"},
        {"Close"},
        {"Cryto"},
        {"Price"},
        {"Purchase"},
        {"Wallet of Crypto"},
        {"Balance"},
        {"Sell"},
        {"Please Select Crypto"},--20

    },
    {"TR",
        {"Meta Banka"},
        {"Bakiye"},
        {"IBAN"},
        {"Para Çek"},
        {"Para Yatır"},
        {"Gönder"},
        {"Para miktarı"},
        {"Yetersiz bakiye!"},
        {"Lütfen bir iban yazın!"},
        {"Geçersiz IBAN"},
        {"Onayla"},
        {"Kapat"},
        {"Kripto"},
        {"Fiyat"},
        {"Satın Al"},
        {"Kripto Cüzdanı"},
        {"Bakiye"},
        {"Sat"},
        {"Lütfen bir kripto seç"},
    },
}
language_section =  1 -- language selection ( - dil seçimi - )


information_img = {
    {"receive","Sent from","panel/panel_img/send.png",tocolor(255,127,0,255)},
    {"sent","Sent to","panel/panel_img/send.png",tocolor(255,127,0,255)},
    {"deposit","Deposit from bank","panel/panel_img/plus.png",tocolor(133,187,101,255)},
    {"crypto","Buyed from","panel/panel_img/cripto.png",tocolor(246,190,0,255)},
    {"crypto2","Sell from","panel/panel_img/cripto.png",tocolor(246,190,0,255)},
    {"withdraw","Withdraw from Bank","panel/panel_img/negative.png",tocolor(255,0,0,255)},
}


currency = "₺"

iban_title = "META-00"

-----------------standart profile url
standart_profile = "settings/profiles/pr1.png" 

-------------------------
--- ATM'S
atms = {
    --{marker_x,marker_y,marker_z,marker_scale,marker_type,r,g,b,a}
    --{-1954, 301, 34.5,1,"cylinder",r,g,b,a},{-1975.54626, 303.13275, 35.17188,180},
    {-2423.92041, -587.82086, 131.8587,1,"cylinder",255,0,0,255},
}

maps_object={
    --    {object_id(if false, closed object),x,y,z,rx,ry,rz,interior,dimens,scale,alpha} 
    {2942,-2424.43701, -586.87866, 132.40793,0,0,30,0,0,1,255}
}
peds={ 
    --{skin_id,x,y,z,rz,dimension,interior,"block",anim}
    --{163,-1951.94556, 302.54166, 35.46875,150,0,0,"DEALER", "DEALER_IDLE"},

} 

crypto_transaction_rate = 8 -- % crypto transaction interruption rate ( kripto işlem kesinti oranı)
money_change_anim_access = false
money_transfer_fee = 5 --money transfer fee ( para transferi ücreti)


crypto_link = "https://raw.githubusercontent.com/alitfkc/mta-server-crypto/main/crypto.json"

crypto_change_timer = 60000


------------------------------------------
-- add profiles
------------------------------------------
profile_img = {
    "settings/profiles/pr1.png",
    "settings/profiles/pr2.png",
    "settings/profiles/pr3.png",
    "settings/profiles/pr4.png",
    "settings/profiles/pr5.png",
    "settings/profiles/pr6.png",
    "settings/profiles/pr7.png",
    "settings/profiles/pr1.png",
    "settings/profiles/pr2.png",
    "settings/profiles/pr3.png",
    "settings/profiles/pr4.png",
    "settings/profiles/pr5.png",
    "settings/profiles/pr6.png",
    "settings/profiles/pr7.png",
}