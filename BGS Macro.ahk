#SingleInstance Force
#NoEnv

SetWorkingDir, %A_ScriptDir%
iniFile := A_ScriptDir "\settings.ini"

; === Load settings from ini ===
IniRead, startKey, %iniFile%, Settings, startKey, p
IniRead, stopKey, %iniFile%, Settings, stopKey, l
IniRead, pickRes, %iniFile%, Settings, pickRes, 1920x1080

IniRead, bubbleFarm, %iniFile%, Settings, bubbleFarm, false
IniRead, sellBubbles, %iniFile%, Settings, sellBubbles, false
IniRead, bubbleSellTime, %iniFile%, Settings, bubbleSellTime, 60

IniRead, eggOpen, %iniFile%, Settings, eggOpen, false
IniRead, fallSafety, %iniFile%, Settings, fallSafety, true
IniRead, fallSafetyAmount, %iniFile%, Settings, fallSafetyAmount, 8

IniRead, autoClaimChests, %iniFile%, Settings, autoClaimChests, true
IniRead, VipChest, %iniFile%, Settings, VipChest, false

IniRead, playtimeGiftClaim, %iniFile%, Settings, playtimeGiftClaim, true
IniRead, wheelSpinClaim, %iniFile%, Settings, wheelSpinClaim, true

IniRead, alienShopBuy, %iniFile%, Settings, alienShopBuy, true
IniRead, blackMarketShopBuy, %iniFile%, Settings, blackMarketShopBuy, false

IniRead, reconnectFeature, %iniFile%, Settings, reconnectFeature, true

IniRead, webhookImage, %iniFile%, Settings, webhookImage, true
IniRead, WebhookLink, %iniFile%, Settings, WebhookLink
IniRead, WebhookTime, %iniFile%, Settings, WebhookTime, 25

IniRead, SoundEffects, %iniFile%, Settings, SoundEffects, true

Gui, New
Gui, Margin, 15, 15

; Hotkeys
Gui, Add, GroupBox, x10 y10 w260 h90, Hotkeys
Gui, Add, Picture, x60 y7 w20 h20, %A_ScriptDir%\Dependencies\Gui\icon.png
Gui, Add, Text, x20 y40, Start Key:
Gui, Add, Edit, vStartKeyEdit w60, %startKey%
Gui, Add, Text, x100 y40, Stop Key:
Gui, Add, Edit, vStopKeyEdit w60, %stopKey%

; Resolution
Gui, Add, GroupBox, x280 y10 w260 h90, Resolution
Gui, Add, Picture, x340 y7 w20 h20, %A_ScriptDir%\Dependencies\Gui\icon5.png
Gui, Add, Text, x290 y40, Pick Res: (1920x1080 default)
Gui, Add, DropDownList, vPickResDropdown w120, 1280x720|1366x768|1600x900|1920x1080||2560x1440

; Bubbles
Gui, Add, GroupBox, x10 y110 w260 h150, Bubbles
Gui, Add, Picture, x60 y107 w20 h20, %A_ScriptDir%\Dependencies\Gui\icon2.png
Gui, Add, Checkbox, vBubbleFarmCheck x20 y140, Bubble Farm
Gui, Add, Checkbox, vSellBubblesCheck x20 y165, Sell Bubbles
Gui, Add, Text, x20 y200, Bubble Sell Time (s):
Gui, Add, Edit, vBubbleSellTimeEdit w50, %bubbleSellTime%

; Chests
Gui, Add, GroupBox, x280 y110 w260 h90, Chests
Gui, Add, Picture, x325 y107 w20 h20, %A_ScriptDir%\Dependencies\Gui\icon6.png
Gui, Add, Checkbox, vAutoClaimChestsCheck x290 y140, Auto Claim Chests
Gui, Add, Checkbox, vVipChestCheck x290 y165, VIP Chest

; Claims
Gui, Add, GroupBox, x10 y270 w260 h90, Claims
Gui, Add, Picture, x50 y267 w20 h20, %A_ScriptDir%\Dependencies\Gui\icon3.png
Gui, Add, Checkbox, vPlaytimeGiftClaimCheck x20 y300, Playtime Gift Claim
Gui, Add, Checkbox, vWheelSpinClaimCheck x20 y325, Auto Spin Claim

; Shops
Gui, Add, GroupBox, x280 y210 w260 h80, Shops
Gui, Add, Picture, x320 y207 w20 h20, %A_ScriptDir%\Dependencies\Gui\icon7.png
Gui, Add, Checkbox, vAlienShopBuyCheck x290 y240, Alien Shop Buy
Gui, Add, Checkbox, vBlackMarketShopBuyCheck x290 y265, Black Market Buy

; Safety Settings
Gui, Add, GroupBox, x10 y370 w260 h120, Safety Settings
Gui, Add, Picture, x95 y367 w20 h20, %A_ScriptDir%\Dependencies\Gui\icon4.png
Gui, Add, Checkbox, vFallSafetyCheck x20 y400, Fall Safety
Gui, Add, Text, x20 y425, Fall Safety Amount:
Gui, Add, Edit, vFallSafetyAmountEdit w50, %fallSafetyAmount%
Gui, Add, Checkbox, vReconnectFeatureCheck x150 y400, Auto Reconnect

; Webhook
Gui, Add, GroupBox, x280 y300 w260 h190, Webhook
Gui, Add, Picture, x340 y297 w20 h20, %A_ScriptDir%\Dependencies\Gui\icon8.png
Gui, Add, Checkbox, vWebhookImageCheck x290 y320, Webhook Image
Gui, Add, Text, x290 y345, Webhook Link:
Gui, Add, Edit, vWebhookLinkEdit w200, %WebhookLink%
Gui, Add, Text, x290 y435, Webhook Time (min):
Gui, Add, Edit, vWebhookTimeEdit w50, %WebhookTime%

; Misc
Gui, Add, GroupBox, x10 y500 w530 h60, Misc
Gui, Add, Picture, x45 y497 w20 h20, %A_ScriptDir%\Dependencies\Gui\icon9.png
Gui, Add, Checkbox, vSoundEffectsCheck x20 y525, Sound Effects
Gui, Add, Checkbox, vEggOpenCheck x130 y525, Egg Open
Gui, Add, Button, x425 y517 w80 h30 gFastEggHatch, Fast Egg Hatch

; Save and Load Buttons
Gui, Add, Button, x180 y580 w80 h30 gSaveSettings, Save
Gui, Add, Button, x270 y580 w80 h30 gLoadMainMacro, Load

; === Set checkboxes ===
GuiControl,, BubbleFarmCheck, % bubbleFarm = "true" ? 1 : 0
GuiControl,, SellBubblesCheck, % sellBubbles = "true" ? 1 : 0
GuiControl,, EggOpenCheck, % eggOpen = "true" ? 1 : 0
GuiControl,, AutoClaimChestsCheck, % autoClaimChests = "true" ? 1 : 0
GuiControl,, VipChestCheck, % VipChest = "true" ? 1 : 0
GuiControl,, PlaytimeGiftClaimCheck, % playtimeGiftClaim = "true" ? 1 : 0
GuiControl,, WheelSpinClaimCheck, % wheelSpinClaim = "true" ? 1 : 0
GuiControl,, AlienShopBuyCheck, % alienShopBuy = "true" ? 1 : 0
GuiControl,, BlackMarketShopBuyCheck, % blackMarketShopBuy = "true" ? 1 : 0
GuiControl,, FallSafetyCheck, % fallSafety = "true" ? 1 : 0
GuiControl,, ReconnectFeatureCheck, % reconnectFeature = "true" ? 1 : 0
GuiControl,, WebhookImageCheck, % webhookImage = "true" ? 1 : 0
GuiControl,, SoundEffectsCheck, % SoundEffects = "true" ? 1 : 0

Gui, Show, , Settings Loader
return

; === Save Button ===
SaveSettings:
Gui, Submit, NoHide
GuiControlGet, PickResDropdown

IniWrite, %StartKeyEdit%, %iniFile%, Settings, startKey
IniWrite, %StopKeyEdit%, %iniFile%, Settings, stopKey
IniWrite, %PickResDropdown%, %iniFile%, Settings, pickRes

IniWrite, % (BubbleFarmCheck ? "true" : "false"), %iniFile%, Settings, bubbleFarm
IniWrite, % (SellBubblesCheck ? "true" : "false"), %iniFile%, Settings, sellBubbles
IniWrite, %BubbleSellTimeEdit%, %iniFile%, Settings, bubbleSellTime

IniWrite, % (EggOpenCheck ? "true" : "false"), %iniFile%, Settings, eggOpen

IniWrite, % (AutoClaimChestsCheck ? "true" : "false"), %iniFile%, Settings, autoClaimChests
IniWrite, % (VipChestCheck ? "true" : "false"), %iniFile%, Settings, VipChest

IniWrite, % (PlaytimeGiftClaimCheck ? "true" : "false"), %iniFile%, Settings, playtimeGiftClaim
IniWrite, % (WheelSpinClaimCheck ? "true" : "false"), %iniFile%, Settings, wheelSpinClaim

IniWrite, % (AlienShopBuyCheck ? "true" : "false"), %iniFile%, Settings, alienShopBuy
IniWrite, % (BlackMarketShopBuyCheck ? "true" : "false"), %iniFile%, Settings, blackMarketShopBuy

IniWrite, % (FallSafetyCheck ? "true" : "false"), %iniFile%, Settings, fallSafety
IniWrite, %FallSafetyAmountEdit%, %iniFile%, Settings, fallSafetyAmount
IniWrite, % (ReconnectFeatureCheck ? "true" : "false"), %iniFile%, Settings, reconnectFeature

IniWrite, % (WebhookImageCheck ? "true" : "false"), %iniFile%, Settings, webhookImage
IniWrite, %WebhookLinkEdit%, %iniFile%, Settings, WebhookLink
IniWrite, %WebhookTimeEdit%, %iniFile%, Settings, WebhookTime

IniWrite, % (SoundEffectsCheck ? "true" : "false"), %iniFile%, Settings, SoundEffects

MsgBox, Settings Saved!
return

; === Load Button ===
LoadMainMacro:
Run, %A_ScriptDir%\Dependencies\Tasks\BGS Infinity Coins Farm V5.ahk
ExitApp
return

FastEggHatch:
Run, %A_ScriptDir%\Dependencies\Tasks\eggSpam.ahk
ExitApp
return