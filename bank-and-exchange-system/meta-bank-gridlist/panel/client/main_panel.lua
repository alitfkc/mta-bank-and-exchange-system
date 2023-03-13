loadstring(exports.dgs:dgsImportFunction())()
dgs = {}
local function resource_start()
    roboto_font = dgsCreateFont("panel/panel_img/roboto.ttf",22)
    roboto_m = dgsCreateFont("panel/panel_img/roboto.ttf",18)
    ------------------------------------------------
    -- Main Car Shop Window
    ------------------------------------------------ Window
    local gradient_title = dgsCreateGradient(tocolor(0,0,0,255),tocolor(0,0,0,225),90)
    dgsGradientSetColorOverwritten(gradient_title,false)
   local panel_rect = dgsCreateRoundRect({
                                        {15,false},
                                        {15,false},
                                        {15,false},
                                        {15,false},
                                    })
                                    
    local canvas_title = dgsCreateCanvas(gradient_title,100,50)
    dgsRoundRectSetTexture(panel_rect, canvas_title)

    
    bank_main_panel = dgsCreateWindow(0.17,0.16,0.6,0.6,language[language_section][2][1],true,tocolor(255,255,255),0,false,false,panel_rect,tocolor(255,255,255,255),false,true)
    dgsWindowSetSizable(bank_main_panel,false)
    dgsWindowSetMovable(bank_main_panel,false)
    dgsSetProperty(bank_main_panel, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(bank_main_panel, "renderCanvas", canvas_title)
    dgsSetFont(bank_main_panel, "default-bold")
    
    ----------------------------------------------------------                               
    --Server logo
    ---------------------------------------------------------------------------
    dgs.server_logo_pane = dgsCreateScrollPane(0,0,1,1,true,bank_main_panel)
    dgsMoveToBack(dgs.server_logo_pane)
    dgsSetProperty(dgs.server_logo_pane,"scrollBarThick",0)
    local effect3d2 = dgsCreateEffect3D(30)
    dgsEffect3DApplyToScrollPane(effect3d2,dgs.server_logo_pane)
    local server_logo = dgsCreateImage(0.7,0.66,0.25,0.25,"panel/panel_img/server_logo.png",true,dgs.server_logo_pane)
    
    --------------------------------------
    --Meta Bank Label
    --------------------------------------
    local main_title_shadow = dgsCreateLabel(0.003,0.052,1,0.3,language[language_section][2][1],true,bank_main_panel,tocolor(0,0,0,200),4,4,50,50,tocolor(1,1,1,255),"center")
    local main_title = dgsCreateLabel(0,0.05,1,0.3,language[language_section][2][1],true,bank_main_panel,tocolor(88,101,242,255),4,4,50,50,tocolor(1,1,1,255),"center")
    dgsSetFont(main_title,"default-bold")
    dgsSetFont(main_title_shadow,"default-bold")
    -----------------------------------------
    --Profile IMG 
    -----------------------------------------
    dgs.profile_img = dgsCreateImage(0.027,0.097,0.12,0.13,standart_profile,true,bank_main_panel)
    local pp_circle = dgsCreateCircle(0.5,0.42,360,tocolor(88,101,242,255))
    dgs.profile_border = dgsCreateImage(0.02,0.04,0.13,0.2,pp_circle,true,bank_main_panel)
    -----------------------------------------------------------------------------
    ----------------------------------
    -- home main button
    -----------------------------------
    local home_icon_tex = dxCreateTexture("panel/panel_img/home.png")
    dgs.main_tab_backimg = createImage(0.05,0.31,0.07,0.1,_,true,bank_main_panel)
    dgsSetEnabled(dgs.main_tab_backimg,false)
    dgs.main_tab_btn = dgsCreateButton(0.06,0.32,0.05,0.08,"",true,bank_main_panel,tocolor(255,255,255),1,1,home_icon_tex,home_icon_tex,home_icon_tex,tocolor(192,192,192,255),tocolor(192,192,192,155),tocolor(192,192,192,255))
    ----------------------------------
    -- deposit button
    -----------------------------------
    local deposit_icon_tex = dxCreateTexture("panel/panel_img/plus.png")
    dgs.deposit_tab_backimg = createImage(0.05,0.43,0.07,0.1,_,true,bank_main_panel)
    dgsSetEnabled(dgs.deposit_tab_backimg,false)
    dgs.deposit_tab_btn = dgsCreateButton(0.06,0.44,0.05,0.08,"",true,bank_main_panel,tocolor(255,255,255),1,1,deposit_icon_tex,deposit_icon_tex,deposit_icon_tex,tocolor(133,187,101,255),tocolor(133,187,101,155),tocolor(133,187,101,255))
    ----------------------------------
    -- send button
    -----------------------------------
    local send_icon_tex = dxCreateTexture("panel/panel_img/send.png")
    dgs.send_tab_backimg = createImage(0.05,0.55,0.07,0.1,_,true,bank_main_panel)
    dgsSetEnabled(dgs.send_tab_backimg,false)
    dgs.send_tab_btn = dgsCreateButton(0.06,0.56,0.05,0.08,"",true,bank_main_panel,tocolor(255,255,255),1,1,send_icon_tex,send_icon_tex,send_icon_tex,tocolor(255,127,0,255),tocolor(255,127,0,155),tocolor(255,127,0,255))
    ----------------------------------
    -- cripto button
    -----------------------------------
    local cripto_icon_tex = dxCreateTexture("panel/panel_img/cripto.png")
    dgs.cripto_tab_backimg = createImage(0.05,0.67,0.07,0.1,_,true,bank_main_panel)
    dgsSetEnabled(dgs.cripto_tab_backimg,false)
    dgs.cripto_tab_btn = dgsCreateButton(0.06,0.68,0.05,0.08,"",true,bank_main_panel,tocolor(255,255,255),1,1,cripto_icon_tex,cripto_icon_tex,cripto_icon_tex,tocolor(246,190,0,255),tocolor(246,190,0,155),tocolor(246,190,0,255))
    ----------------------------------
    -- exit button
    -----------------------------------
    local exit_icon_tex = dxCreateTexture("panel/panel_img/exit.png")
    dgs.exit_tab_backimg = createImage(0.05,0.79,0.07,0.1,_,true,bank_main_panel)
    dgsSetEnabled(dgs.exit_tab_backimg,false)
    dgs.exit_btn = dgsCreateButton(0.059,0.80,0.05,0.08,"",true,bank_main_panel,tocolor(255,255,255),1,1,exit_icon_tex,exit_icon_tex,exit_icon_tex,tocolor(255,0,0,255),tocolor(255,0,0,155),tocolor(255,0,0,255))


    --------------------------------------
    --Balance title Label
    --------------------------------------
    local balance_title_shadow = dgsCreateLabel(0.701,0.201,0.3,0.3,language[language_section][3][1],true,bank_main_panel,tocolor(0,0,0,200),1,1,50,50,tocolor(1,1,1,255),"center")
    local balance_title = dgsCreateLabel(0.7,0.2,0.3,0.3,language[language_section][3][1],true,bank_main_panel,tocolor(88,101,242,255),1,1,50,50,tocolor(1,1,1,255),"center")
    dgsSetFont(balance_title,roboto_font)
    dgsSetFont(balance_title_shadow,roboto_font)
    --------------------------------------
    --Balance Label
    --------------------------------------
    balance_label= dgsCreateLabel(0.7,0.28,0.3,0.3,"0"..currency,true,bank_main_panel,tocolor(133,187,101,255),1,1,50,50,tocolor(1,1,1,255),"center")
    dgsSetFont(balance_label,roboto_m)
    --------------------------------------
    --iban Label
    --------------------------------------
    iban_label= dgsCreateLabel(0.6,0.38,0.2,0.3,language[language_section][4][1].." : ",true,bank_main_panel,tocolor(255,255,255,205),1,1,50,50,tocolor(1,1,1,255),"right")
    dgsSetFont(iban_label,dgsCreateFont("panel/panel_img/roboto.ttf",14))
    iban_adress= dgsCreateLabel(0.805,0.38,0.3,0.3,iban_title.."1967",true,bank_main_panel,tocolor(255,255,255,205),1,1,50,50,tocolor(1,1,1,255),"left")
    dgsSetFont(iban_adress,dgsCreateFont("panel/panel_img/roboto.ttf",14))

    ------------------------------------------------
    --withdraw buton and edit
    ------------------------------------------------
    dgs.withdraw_edit = createEditbox(0.72,0.48,0.25,0.07,"",true,bank_main_panel)
    dgs.withdraw_btn = createButton(0.72,0.56,0.25,0.07,language[language_section][5][1],true,bank_main_panel)

    ----------------------------------------------------------
    --main tab 
    -----------------------------------------------------------
    dgs.main_tab = dgsCreateTabPanel(0.16,0.28,0.55,0.6,true,bank_main_panel,20,false,tocolor(128,0,128,0))
    --dgsSetVisible(dgs.main_tab,false)
    ------------------------------------
    --transfer history
    ------------------------------------
    history_scroll_pane = dgsCreateScrollPane(0,0,1,1,true, dgs.main_tab)
    dgsSetProperty(history_scroll_pane,"scrollBarThick",0)
    local effect3d = dgsCreateEffect3D(15)
    dgsEffect3DApplyToScrollPane(effect3d,history_scroll_pane)

    --------------------------------------------------
    --history List
    --------------------------------------------------
    hist_list = dgsCreateGridList(0,0,1,0.9,true,history_scroll_pane,20,tocolor(0,0,0,0),false,tocolor(0,0,0,0),tocolor(0,0,0,0),tocolor(88,101,242,170),tocolor(88,101,242,255))
    column_1 =dgsGridListAddColumn( hist_list,"1" , 0.17)
    column_2 =dgsGridListAddColumn( hist_list,"2", 0.15 )
    column_3 =dgsGridListAddColumn( hist_list,"3" , 0.35 )
    column_4 =dgsGridListAddColumn( hist_list,"4" , 0.3 )


    dgsSetProperty(hist_list,"rowHeight",50)       
    dgsSetProperty(hist_list,"scrollBarThick",0) 





    ----------------------------------------------------------
    --deposit tab 
    -----------------------------------------------------------
    dgs.deposit_tab = dgsCreateTabPanel(0.16,0.28,0.55,0.6,true,bank_main_panel,20,false,tocolor(128,0,128,0))
    dgsSetVisible(dgs.deposit_tab,false)

    dgs.deposit_edit = createEditbox(0.2,0.4,0.6,0.13,"",true,dgs.deposit_tab)
    dgs.deposit_btn = createButton(0.2,0.56,0.6,0.13,language[language_section][6][1],true,dgs.deposit_tab)
    dgs.deposit_img = dgsCreateImage(0.37,0.05,0.28,0.35,"panel/panel_img/plus.png",true,dgs.deposit_tab,tocolor(133,187,101,255))
    ----------------------------------------------------------
    --send tab 
    -----------------------------------------------------------
    dgs.send_tab = dgsCreateTabPanel(0.16,0.28,0.55,0.6,true,bank_main_panel,20,false,tocolor(128,0,128,0))
    dgsSetVisible(dgs.send_tab,false)
    local send_iban_label = dgsCreateLabel(0.2,0.32,0.28,0.13,language[language_section][4][1],true,dgs.send_tab,tocolor(88,101,242,205),1,1,50,50,tocolor(1,1,1,255),"center")
    dgsSetFont(send_iban_label,"default-bold")
    dgs.send_iban_edit = createEditbox(0.2,0.4,0.28,0.13,"",true,dgs.send_tab)
    local send_amount_label = dgsCreateLabel(0.5,0.32,0.3,0.13,language[language_section][8][1],true,dgs.send_tab,tocolor(133,187,101,205),1,1,50,50,tocolor(1,1,1,255),"center")
    dgsSetFont(send_amount_label,"default-bold")
    dgs.send_amount_edit = createEditbox(0.5,0.4,0.3,0.13,"",true,dgs.send_tab)
    dgs.send_btn = createButton(0.2,0.56,0.6,0.13,language[language_section][7][1],true,dgs.send_tab)
    dgs.send_img = dgsCreateImage(0.37,0.05,0.28,0.28,"panel/panel_img/send.png",true,dgs.send_tab,tocolor(255,127,0,255))

    ----------------------------------------------------------
    --cripto tab 
    -----------------------------------------------------------
    dgs.cripto_tab = dgsCreateTabPanel(0.16,0.28,0.55,0.6,true,bank_main_panel,20,false,tocolor(128,0,128,0))
    dgsSetVisible(dgs.cripto_tab,false)

    local title_list_rect = dgsCreateRoundRect({
        {8,false},
        {8,false},
        {-5,false},
        {-5,false},
    },tocolor(88,101,242,205))
    local main_list_rect = dgsCreateRoundRect({
        {0,false},
        {0,false},
        {15,false},
        {15,false},
    },tocolor(12,12,12,205))
    crypto_glist = dgsCreateGridList(0,0,1,0.42,true,dgs.cripto_tab,20,tocolor(0,0,0,255),false,tocolor(88,101,242,205),tocolor(0,0,0,0),tocolor(255,166,38,120),tocolor(255,59,84,120),main_list_rect,title_list_rect)
    crypto_list_column_1 =dgsGridListAddColumn( crypto_glist ,language[language_section][14] , 0.45)
    crypto_list_column_2 =dgsGridListAddColumn( crypto_glist ,language[language_section][15] , 0.45)
    dgs.buy_crypto_edit = createEditbox(0,0.46,0.45,0.13,"",true,dgs.cripto_tab)
    dgs.buy_cypto_btn = createButton(0.55,0.46,0.45,0.13,language[language_section][16][1],true,dgs.cripto_tab)

    crypto_wallet_list = dgsCreateGridList(0,0.6,1,0.22,true,dgs.cripto_tab,20,tocolor(0,0,0,255),false,tocolor(88,101,242,205),tocolor(0,0,0,0),tocolor(255,166,38,120),tocolor(255,59,84,120),main_list_rect,title_list_rect)
    crypto_wallet_list_column_1 =dgsGridListAddColumn( crypto_wallet_list ,language[language_section][17] , 0.45)
    crypto_wallet_list_column_2 =dgsGridListAddColumn( crypto_wallet_list ,language[language_section][18] , 0.45)
    dgs.sell_crypto_edit = createEditbox(0,0.86,0.45,0.13,"",true,dgs.cripto_tab)
    dgs.sell_cypto_btn = createButton(0.55,0.86,0.45,0.13,language[language_section][19][1],true,dgs.cripto_tab)
    ------------------------------------------------------
    --panel 2 
    ------------------------------------------------------
    local gradient_title = dgsCreateGradient(tocolor(0,0,0,255),tocolor(0,0,0,225),90)
    dgsGradientSetColorOverwritten(gradient_title,false)
    local panel_rect = dgsCreateRoundRect({
                                        {15,false},
                                        {15,false},
                                        {15,false},
                                        {15,false},
                                    })
                                    
    local canvas_title = dgsCreateCanvas(gradient_title,100,50)
    dgsRoundRectSetTexture(panel_rect, canvas_title)

    
    panel2 = dgsCreateWindow(0.22,0.26,0.6,0.45,language[language_section][2][1],true,tocolor(255,255,255),0,false,false,panel_rect,tocolor(255,255,255,255),false,true)
    dgsWindowSetSizable(panel2,false)
    dgsWindowSetMovable(panel2,false)
    dgsSetProperty(panel2, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(panel2, "renderCanvas", canvas_title)
    dgsSetFont(panel2, "default-bold")
    ---------------------------
    --message edit
    ---------------------------
    --dgs.message_edit = createEditbox(0.125,0.26,0.75,0.25,"",true,panel2)
    dgs.close_panel2_btn = createButton(0.15,0.88,0.7,0.08,language[language_section][13][1],true,panel2)
    --dgs.approval_panel2_btn = createButton(0.525,0.62,0.35,0.25,language[language_section][12][1],true,panel2)
    profile_img_scroll_pane = dgsCreateScrollPane(0,0,1,0.8,true,panel2)
    dgsSetProperty(profile_img_scroll_pane,"scrollBarThick",0)
    local px,py = 0.02,0.05
    profile_img_table = {}
    for k,v in ipairs(profile_img) do 
        dgsCreateImage(px+0.03,py+0.05,0.1,0.3,v,true,profile_img_scroll_pane)
        local pp_circle = dgsCreateCircle(0.5,0.42,360,tocolor(88,101,242,255))
        profile_img_table[k]= dgsCreateImage(px,py,0.16,0.4,pp_circle,true,profile_img_scroll_pane)
        px = px + 0.2
        if px > 0.9 then 
            px = 0.02
            py = py + 0.45
        end
    end


    dgsSetVisible(panel2,false)
    dgsSetVisible(bank_main_panel,false)
    


end
function createImage(x, y, g, u,img,relative, parent)
    local bottom_img_rect = dgsCreateRoundRect(15,false,tocolor(88,101,242,200))
    local img = dgsCreateImage(x,y,g,u,bottom_img_rect,relative,parent,tocolor(255,166,38))
    dgsImageSetImage(img,bottom_img_rect)
    return img
end


function createButton(x, y, g, u, text, relative, parent)
    local button_round = dgsCreateRoundRect(15,false,tocolor(255,255,255,255))
    local gradient = dgsCreateGradient(tocolor(107,0,153),tocolor(88,101,242),10)
    dgsGradientSetColorOverwritten(gradient,false)

    local canvas = dgsCreateCanvas(gradient,100,50)
    dgsRoundRectSetTexture(button_round, canvas)

    local button_round_hover = dgsCreateRoundRect(15,false,tocolor(255,255,255,255))
    local gradient = dgsCreateGradient(tocolor(107,0,153),tocolor(88,101,242),-170)
    dgsGradientSetColorOverwritten(gradient,false)

    local canvas = dgsCreateCanvas(gradient,100,50)
    dgsRoundRectSetTexture(button_round, canvas)
    
    dgs[tostring(x)] = dgsCreateButton(x, y, g, u, "", relative, parent)
    dgsSetEnabled(dgs[tostring(x)],false)
    dgsSetProperty(dgs[tostring(x)], "image",{button_round,button_round,button_round})
    dgsSetProperty(dgs[tostring(x)], "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(dgs[tostring(x)], "renderCanvas", canvas)
    dgsSetFont(dgs[tostring(x)], "default-bold")
    dgsSetProperty(dgs[tostring(x)], "clickType", 1)
    

    local button_round = dgsCreateRoundRect(15,false,tocolor(255,255,255,255))
    local gradient = dgsCreateGradient(tocolor(107,0,153),tocolor(88,101,242),10)
    dgsGradientSetColorOverwritten(gradient,false)

    local canvas = dgsCreateCanvas(gradient,100,50)
    dgsRoundRectSetTexture(button_round, canvas)

    local button_round_hover = dgsCreateRoundRect(15,false,tocolor(255,255,255,255))
    local gradient = dgsCreateGradient(tocolor(107,0,153),tocolor(88,101,242),10)
    dgsGradientSetColorOverwritten(gradient,false)

    local canvas = dgsCreateCanvas(gradient,100,50)
    dgsRoundRectSetTexture(button_round, canvas)
    
    local button_1 = dgsCreateButton(x, y, g, u,text, relative, parent)
    dgsSetProperty(button_1, "image",{button_round,canvas,button_round})
    dgsSetProperty(button_1, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(button_1, "renderCanvas", canvas)
    dgsSetFont(button_1, "default-bold")
    dgsSetProperty(button_1, "clickType", 1)

    return button_1
end

function createEditbox(x, y, g, u, text,relative, parent)
    local edit_round = dgsCreateRoundRect(15,false,tocolor(255,255,255,205))

    local editbox = dgsCreateEdit(x, y, g, u, text, relative, parent, tocolor(12,12,12,255), nil, nil, edit_round)
    dgsSetProperty(editbox, "image",{edit_round,edit_round,edit_round})

    dgsEditSetHorizontalAlign(editbox,"center")
    dgsEditSetCaretStyle(editbox,1)
    dgsSetProperty(editbox,"caretColor",tocolor(12,12,12,255))

    dgsSetFont(editbox, "default-bold")
    dgsSetProperty(editbox, "clickType", 1)
    return editbox
end

addEventHandler("onClientResourceStart",resourceRoot,resource_start)

