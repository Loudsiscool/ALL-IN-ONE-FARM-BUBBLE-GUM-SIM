#Persistent
#SingleInstance Force
#Include %A_ScriptDir%\..\Gdip_All.ahk
toggle := false
lastHourlyAction := A_TickCount
lastThirtyFiveMinAction := A_TickCount
LastWebhookSent := A_TickCount

; ======= Load Settings.ini =======
settingsFile := A_ScriptDir . "\..\..\settings.ini"

; If settings.ini doesn't exist, exit the script
if !FileExist(settingsFile)
{
    MsgBox, 16, Error, settings.ini not found!
    ExitApp
}

readSetting(varName) {
    global settingsFile
    IniRead, value, %settingsFile%, Settings, %varName%, 
    if (ErrorLevel)
    {
        MsgBox, 16, Error, Missing setting "%varName%" in settings.ini!
        ExitApp
    }
    return value
}

; === Load all settings from settings.ini ===
startKey := readSetting("startKey")
stopKey := readSetting("stopKey")
pickRes := readSetting("pickRes")

bubbleFarm := readSetting("bubbleFarm") = "true"
sellBubbles := readSetting("sellBubbles") = "true"
bubbleSellTime := readSetting("bubbleSellTime")
eggOpen := readSetting("eggOpen") = "true"
fallSafety := readSetting("fallSafety") = "true"
fallSafetyAmount := readSetting("fallSafetyAmount")
autoClaimChests := readSetting("autoClaimChests") = "true"
VipChest := readSetting("VipChest") = "true"
playtimeGiftClaim := readSetting("playtimeGiftClaim") = "true"
alienShopBuy := readSetting("alienShopBuy") = "true"
blackMarketShopBuy := readSetting("blackMarketShopBuy") = "true"
wheelSpinClaim := readSetting("wheelSpinClaim") = "true"
reconnectFeature := readSetting("reconnectFeature") = "true"

webhookImage := readSetting("webhookImage") = "true"
WebhookLink := readSetting("WebhookLink")
WebhookTime := readSetting("WebhookTime")
disconnectColor := readSetting("disconnectColor")

floatingChestTime := readSetting("floatingChestTime")
voidChestTime := readSetting("voidChestTime")
infinityChestTime := readSetting("infinityChestTime")
playTimeGiftTime := readSetting("playTimeGiftTime")
alienShopTime := readSetting("alienShopTime")
blackMarketShopTime := readSetting("blackMarketShopTime")
wheelClaimTime := readSetting("wheelClaimTime")

gameLoadTime := readSetting("gameLoadTime")
assetLoadTime := readSetting("assetLoadTime")
sounds := readSetting("SoundEffects")

if (sounds = "true") {
    sounds := true
} else {
    sounds := false
}

; ======= Load Resolution Coordinates =======
resCoordsFile := A_ScriptDir . "\..\res_coords.ini"

; If res_coords.ini doesn't exist, exit the script
if !FileExist(resCoordsFile)
{
    MsgBox, 16, Error, res_coords.ini not found!
    ExitApp
}

; Read coordinates for the selected resolution from res_coords.ini
readResCoords(resName) {
    global resCoordsFile
    coords := {}
    IniRead, arrowButtonX, %resCoordsFile%, %resName%, arrowButtonX
    IniRead, arrowButtonY, %resCoordsFile%, %resName%, arrowButtonY
    IniRead, tpButtonX, %resCoordsFile%, %resName%, tpButtonX
    IniRead, tpButtonY, %resCoordsFile%, %resName%, tpButtonY
    IniRead, arrowButtonXDown, %resCoordsFile%, %resName%, arrowButtonXDown
    IniRead, arrowButtonYDown, %resCoordsFile%, %resName%, arrowButtonYDown
    IniRead, VoidChestX, %resCoordsFile%, %resName%, VoidChestX
    IniRead, VoidChestY, %resCoordsFile%, %resName%, VoidChestY
    IniRead, FloatingChestX, %resCoordsFile%, %resName%, FloatingChestX
    IniRead, FloatingChestY, %resCoordsFile%, %resName%, FloatingChestY
    IniRead, ShopSlot1X, %resCoordsFile%, %resName%, ShopSlot1X
    IniRead, ShopSlot1Y, %resCoordsFile%, %resName%, ShopSlot1Y
    IniRead, ShopSlot2X, %resCoordsFile%, %resName%, ShopSlot2X
    IniRead, ShopSlot2Y, %resCoordsFile%, %resName%, ShopSlot2Y
    IniRead, ShopSlot3X, %resCoordsFile%, %resName%, ShopSlot3X
    IniRead, ShopSlot3Y, %resCoordsFile%, %resName%, ShopSlot3Y
    IniRead, WheelClaimX, %resCoordsFile%, %resName%, WheelClaimX
    IniRead, WheelClaimY, %resCoordsFile%, %resName%, WheelClaimY
    IniRead, reconX, %resCoordsFile%, %resName%, reconX
    IniRead, reconY, %resCoordsFile%, %resName%, reconY
    IniRead, playButtonX, %resCoordsFile%, %resName%, playButtonX
    IniRead, playButtonY, %resCoordsFile%, %resName%, playButtonY
    IniRead, optimizeButtonX, %resCoordsFile%, %resName%, optimizeButtonX
    IniRead, optimizeButtonY, %resCoordsFile%, %resName%, optimizeButtonY
    IniRead, playtimeButtonX, %resCoordsFile%, %resName%, playtimeButtonX
    IniRead, playtimeButtonY, %resCoordsFile%, %resName%, playtimeButtonY
    IniRead, gift1X, %resCoordsFile%, %resName%, gift1X
    IniRead, gift1Y, %resCoordsFile%, %resName%, gift1Y
    IniRead, gift2X, %resCoordsFile%, %resName%, gift2X
    IniRead, gift2Y, %resCoordsFile%, %resName%, gift2Y
    IniRead, gift3X, %resCoordsFile%, %resName%, gift3X
    IniRead, gift3Y, %resCoordsFile%, %resName%, gift3Y
    IniRead, gift4X, %resCoordsFile%, %resName%, gift4X
    IniRead, gift4Y, %resCoordsFile%, %resName%, gift4Y
    IniRead, gift5X, %resCoordsFile%, %resName%, gift5X
    IniRead, gift5Y, %resCoordsFile%, %resName%, gift5Y
    IniRead, gift6X, %resCoordsFile%, %resName%, gift6X
    IniRead, gift6Y, %resCoordsFile%, %resName%, gift6Y
    IniRead, gift7X, %resCoordsFile%, %resName%, gift7X
    IniRead, gift7Y, %resCoordsFile%, %resName%, gift7Y
    IniRead, gift8X, %resCoordsFile%, %resName%, gift8X
    IniRead, gift8Y, %resCoordsFile%, %resName%, gift8Y
    IniRead, gift9X, %resCoordsFile%, %resName%, gift9X
    IniRead, gift9Y, %resCoordsFile%, %resName%, gift9Y
    IniRead, lastGiftClickX, %resCoordsFile%, %resName%, lastGiftClickX
    IniRead, lastGiftClickY, %resCoordsFile%, %resName%, lastGiftClickY
    IniRead, SkipGiftX, %resCoordsFile%, %resName%, SkipGiftX
    IniRead, SkipGiftY, %resCoordsFile%, %resName%, SkipGiftY
    IniRead, shopShotX, %resCoordsFile%, %resName%, shopShotX
    IniRead, shopShotY, %resCoordsFile%, %resName%, shopShotY
    IniRead, shopShotW, %resCoordsFile%, %resName%, shopShotW
    IniRead, shopShotH, %resCoordsFile%, %resName%, shopShotH
    IniRead, curShotX, %resCoordsFile%, %resName%, curShotX
    IniRead, curShotY, %resCoordsFile%, %resName%, curShotY
    IniRead, curShotW, %resCoordsFile%, %resName%, curShotW
    IniRead, curShotH, %resCoordsFile%, %resName%, curShotH

    coords.arrowButtonX := arrowButtonX
    coords.arrowButtonY := arrowButtonY
    coords.tpButtonX := tpButtonX
    coords.tpButtonY := tpButtonY
    coords.arrowButtonXDown := arrowButtonXDown
    coords.arrowButtonYDown := arrowButtonYDown
    coords.VoidChestX := VoidChestX
    coords.VoidChestY := VoidChestY
    coords.FloatingChestX := FloatingChestX
    coords.FloatingChestY := FloatingChestY
    coords.ShopSlot1X := ShopSlot1X
    coords.ShopSlot1Y := ShopSlot1Y
    coords.ShopSlot2X := ShopSlot2X
    coords.ShopSlot2Y := ShopSlot2Y
    coords.ShopSlot3X := ShopSlot3X
    coords.ShopSlot3Y := ShopSlot3Y
    coords.WheelClaimX := WheelClaimX
    coords.WheelClaimY := WheelClaimY
    coords.reconX := reconX
    coords.reconY := reconY
    coords.playButtonX := playButtonX
    coords.playButtonY := playButtonY
    coords.optimizeButtonX := optimizeButtonX
    coords.optimizeButtonY := optimizeButtonY
    coords.playtimeButtonX := playtimeButtonX
    coords.playtimeButtonY := playtimeButtonY
    coords.gift1X := gift1X
    coords.gift1Y := gift1Y
    coords.gift2X := gift2X
    coords.gift2Y := gift2Y
    coords.gift3X := gift3X
    coords.gift3Y := gift3Y
    coords.gift4X := gift4X
    coords.gift4Y := gift4Y
    coords.gift5X := gift5X
    coords.gift5Y := gift5Y
    coords.gift6X := gift6X
    coords.gift6Y := gift6Y
    coords.gift7X := gift7X
    coords.gift7Y := gift7Y
    coords.gift8X := gift8X
    coords.gift8Y := gift8Y
    coords.gift9X := gift9X
    coords.gift9Y := gift9Y
    coords.lastGiftClickX := lastGiftClickX
    coords.lastGiftClickY := lastGiftClickY
    coords.SkipGiftX := SkipGiftX
    coords.SkipGiftY := SkipGiftY
    coords.shopShotX := shopShotX
    coords.shopShotY := shopShotY
    coords.shopShotW := shopShotW
    coords.shopShotH := shopShotH
    coords.curShotX := curShotX
    coords.curShotY := curShotY
    coords.curShotW := curShotW
    coords.curShotH := curShotH

    return coords
}

resolutionCoords := readResCoords(pickRes)

arrowButtonX := resolutionCoords.arrowButtonX
arrowButtonY := resolutionCoords.arrowButtonY
tpButtonX := resolutionCoords.tpButtonX
tpButtonY := resolutionCoords.tpButtonY
arrowButtonXDown := resolutionCoords.arrowButtonXDown
arrowButtonYDown := resolutionCoords.arrowButtonYDown
VoidChestX := resolutionCoords.VoidChestX
VoidChestY := resolutionCoords.VoidChestY
FloatingChestX := resolutionCoords.FloatingChestX
FloatingChestY := resolutionCoords.FloatingChestY
ShopSlot1X := resolutionCoords.ShopSlot1X
ShopSlot1Y := resolutionCoords.ShopSlot1Y
ShopSlot2X := resolutionCoords.ShopSlot2X
ShopSlot2Y := resolutionCoords.ShopSlot2Y
ShopSlot3X := resolutionCoords.ShopSlot3X
ShopSlot3Y := resolutionCoords.ShopSlot3Y
WheelClaimX := resolutionCoords.WheelClaimX
WheelClaimY := resolutionCoords.WheelClaimY
reconX := resolutionCoords.reconX
reconY := resolutionCoords.reconY
playButtonX := resolutionCoords.playButtonX
playButtonY := resolutionCoords.playButtonY
optimizeButtonX := resolutionCoords.optimizeButtonX
optimizeButtonY := resolutionCoords.optimizeButtonY
playtimeButtonX := resolutionCoords.playtimeButtonX
playtimeButtonY := resolutionCoords.playtimeButtonY
gift1X := resolutionCoords.gift1X
gift1Y := resolutionCoords.gift1Y
gift2X := resolutionCoords.gift2X
gift2Y := resolutionCoords.gift2Y
gift3X := resolutionCoords.gift3X
gift3Y := resolutionCoords.gift3Y
gift4X := resolutionCoords.gift4X
gift4Y := resolutionCoords.gift4Y
gift5X := resolutionCoords.gift5X
gift5Y := resolutionCoords.gift5Y
gift6X := resolutionCoords.gift6X
gift6Y := resolutionCoords.gift6Y
gift7X := resolutionCoords.gift7X
gift7Y := resolutionCoords.gift7Y
gift8X := resolutionCoords.gift8X
gift8Y := resolutionCoords.gift8Y
gift9X := resolutionCoords.gift9X
gift9Y := resolutionCoords.gift9Y
lastGiftClickX := resolutionCoords.lastGiftClickX
lastGiftClickY := resolutionCoords.lastGiftClickY
SkipGiftX := resolutionCoords.SkipGiftX
SkipGiftY := resolutionCoords.SkipGiftY
shopShotX := resolutionCoords.shopShotX
shopShotY := resolutionCoords.shopShotY
shopShotW := resolutionCoords.shopShotW
shopShotH := resolutionCoords.shopShotH
curShotX := resolutionCoords.curShotX
curShotY := resolutionCoords.curShotY
curShotW := resolutionCoords.curShotW
curShotH := resolutionCoords.curShotH

SkipGift() {
    global SkipGiftX, SkipGiftY
    Click, %SkipGiftX%, %SkipGiftY%
}

SkipTimer(){
    Sleep 1100
}

GuiPopup(){
    sleep 100
}

; === Customizable Map Load time (Increase Number If Needed) ===
mapLoadTime := 2500

; === Convert time units ===
bubbleSellTime *= 1000        ; seconds > milliseconds
gameLoadTime *= 1000
assetLoadTime *= 1000
WebhookTime *= 60000          ; minutes > milliseconds
floatingChestTime *= 60000
voidChestTime *= 60000
infinityChestTime *= 60000
playTimeGiftTime *= 60000
alienShopTime *= 60000
blackMarketShopTime *= 60000
wheelClaimTime *= 60000
; === ============================== ===
loopCounter := 0
targetWindow := "Roblox"
WinActivate, %targetWindow%
global sounds
if (sounds) {
    SoundPlay, % A_ScriptDir . "\..\SFX\open.mp3"
}


SysGet, monPrimary, MonitorPrimary
SysGet, monArea, MonitorWorkArea, %monPrimary%
middleX := monAreaLeft
middleY := monAreaTop + 150

backgroundPath := A_ScriptDir . "\..\Gui\background.png"
logoPath := A_ScriptDir . "\..\Gui\logo.png"

Gui, TooltipGui:New
Gui, TooltipGui:-Caption +AlwaysOnTop +ToolWindow
Gui, TooltipGui:Margin, 0, 0
Gui, TooltipGui:Color, Black
Gui, TooltipGui:Font, s7.5 cWhite, Verdana

Gui, TooltipGui:Add, Picture, x0 y0 w220 h220 0xE, %backgroundPath%

Gui, TooltipGui:Add, Picture, x10 y10 w200 h90, %logoPath%
Gui, TooltipGui:Add, Text, vText2, Created By: FyReO
Gui, TooltipGui:Add, Text, vText4, Subscribe On YouTube
Gui, TooltipGui:Add, Text, vActionText, % Format("{:U}", startKey) ": To Start Macro"
Gui, TooltipGui:Add, Text, vActionText2, Y: To Open GUI

GuiControl, Move, vText2, x10 y145 w200 h20
GuiControl, Move, vText4, x10 y170 w200 h20
GuiControl, Move, vActionText, x10 y195 w200 h20

Gui, TooltipGui:Show, x%middleX% y%middleY% NoActivate, Tooltips

; === Settings GUI ===
settingsX := monAreaRight - 300
settingsY := monAreaTop + 100

Gui, SettingsGui:New
Gui, SettingsGui:+AlwaysOnTop -Caption +ToolWindow
Gui, SettingsGui:Color, Black
Gui, SettingsGui:Font, s8 cWhite, Verdana


Gui, SettingsGui:Add, Text,, [ Current Settings ]

AddSetting(name, isEnabled) {
    if (isEnabled) {
        Gui, SettingsGui:Font, cLime
        Gui, SettingsGui:Add, Text,, % name ": On"
    } else {
        Gui, SettingsGui:Font, cRed
        Gui, SettingsGui:Add, Text,, % name ": Off"
    }
    Gui, SettingsGui:Font, cWhite 
}

; Settings Display
Gui, SettingsGui:Add, Text,, Selected Res: %pickRes%
AddSetting("Bubble Farm", bubbleFarm)
AddSetting("Sell Bubbles", sellBubbles)
Gui, SettingsGui:Font, cWhite
Gui, SettingsGui:Add, Text,, % "Bubble Sell Time: " bubbleSellTime // 1000 " seconds"
AddSetting("Egg Open", eggOpen)
AddSetting("Fall Safety", fallSafety)
Gui, SettingsGui:Font, cWhite
Gui, SettingsGui:Add, Text,, Fall Safety Amount: %fallSafetyAmount% loops
AddSetting("Auto Claim Chests", autoClaimChests)
AddSetting("Vip Chest", VipChest)
AddSetting("Playtime Gift Claim", playtimeGiftClaim)
AddSetting("Alien Shop Buy", alienShopBuy)
AddSetting("Black Market Buy", blackMarketShopBuy)
AddSetting("Auto Spin Claim", wheelSpinClaim)
AddSetting("Webhooks", webhookImage)
AddSetting("Auto Reconnect", reconnectFeature)
Gui, SettingsGui:Add, Text,, % "Time Between Webhook: " WebhookTime // 60000 " minutes"

Gui, SettingsGui:Show, x%settingsX% y%settingsY% NoActivate, Settings
; === ============================================================== ===

Hotkey, %startKey%, StartMacro
Hotkey, %stopKey%, StopMacro
return

ClickInWindow(x, y) {
    global targetWindow
    IfWinActive, %targetWindow%
    {
        WinGetPos, winX, winY, winW, winH, %targetWindow%
        if (winX = "") {
            MsgBox, Could not find the target window: %targetWindow%
            ExitApp
        }
        ClickX := winX + x
        ClickY := winY + y
        MouseClick, left, %ClickX%, %ClickY%
    }
}

y::
Run, % A_ScriptDir . "\..\..\BGS Macro.ahk"
ExitApp
Return




StartMacro:
if (sounds) {
    SoundPlay, % A_ScriptDir . "\..\SFX\start.mp3"
}
GuiControl, TooltipGui:, ActionText, % Format("{:U}", stopKey) ": To Stop Macro"
Gui, SettingsGui:Destroy

IfWinExist, %targetWindow%
{
    WinActivate
    Sleep, 200

    if (!toggle) {
        toggle := true

        Send, m
        Sleep, 2500

        Loop, 6 {
            ClickInWindow(arrowButtonX, arrowButtonY)
            Sleep, 200
        }

        ClickInWindow(tpButtonX, tpButtonY)
        Sleep, 2500

        Gosub, DoMovements
        SetTimer, MainLoop, 10
    }
}
else
{
    MsgBox, 48, Error, Could not find the target window: %targetWindow%
}
return

StopMacro:
if (sounds) {
    SoundPlay, % A_ScriptDir . "\..\SFX\end.mp3"
    Sleep, 1000
}
ExitApp
return

DoMovements:
IfWinActive, %targetWindow%
{
    ClickWhileMoving(1950, "w")
    Sleep, 100

    if (eggOpen) {
        Send, {a down}
        Sleep, 200
        Send, {a up}
        Sleep, 200
        Send, e
        Sleep, 200
        Send, {d down}
        Sleep, 200
        Send, {d up}
        Sleep, 200
    }

    ClickWhileMoving(250, "d")
    Sleep, 100

    ClickWhileMoving(850, "w")
    Sleep, 100

    ClickWhileMoving(1250, "d")
    Sleep, 100

    ClickWhileMoving(450, "w")
    Sleep, 100

    ClickWhileMoving(950, "a")
    Sleep, 100

    ClickWhileMoving(950, "s")
    Sleep, 100

    ClickWhileMoving(150, "w")
    Sleep, 100

    ClickWhileMoving(450, "a")
    Sleep, 100

    ClickWhileMoving(950, "d")
    Sleep, 100

    ClickWhileMoving(350, "w")
    Sleep, 100

    ClickWhileMoving(950, "a")
    Sleep, 100
}
return

ClickWhileMoving(duration, key := "w") {
    global bubbleFarm, targetWindow

    Send, {%key% down}
    start := A_TickCount

    loop {
        elapsed := A_TickCount - start
        if (elapsed >= duration)
            break

        if (bubbleFarm && WinExist(targetWindow)) {
            WinGetPos, winX, winY, winW, winH, %targetWindow%
            if (winW != "") {
                offsetX := 150 
                centerX := winX + (winW // 2) + offsetX
                centerY := winY + (winH // 2)
                MouseClick, left, %centerX%, %centerY%
            }
        }

        Sleep, 50
    }

    Send, {%key% up}
}

; === Main Loop ===
MainLoop:
if (toggle) {
    IfWinActive, %targetWindow%
    {
        if (reconnectFeature) {
            Reconnect()
        }

        loopCounter++

        Send, m
        Sleep, %mapLoadTime%

        if (fallSafety && Mod(loopCounter, fallSafetyAmount) = 0) {
            Loop, 6 {
                ClickInWindow(arrowButtonX, arrowButtonY)
                Sleep, 200
            }
            ClickInWindow(tpButtonX, tpButtonY)
            Sleep, 2500
        }
        else {
            ClickInWindow(tpButtonX, tpButtonY)
            Sleep, 2000
        }

        currentTick := A_TickCount

        ; === Playtime Gifts Feature (Shoutout lyfejr) ===
        if (playtimeGiftClaim && (currentTick - lastHourlyAction) >= playTimeGiftTime) {
            ClickInWindow(63, 432)
            GuiPopup()
            ClickInWindow(gift1X, gift1Y) ; Gift 1
            GuiPopup()
            SkipGift()
            SkipTimer()
            ClickInWindow(gift2X, gift2Y) ; Gift 2
            GuiPopup()
            SkipGift()
            SkipTimer()
            ClickInWindow(gift3X, gift3Y) ; Gift 3
            GuiPopup()
            SkipGift()
            SkipTimer()
            ClickInWindow(gift4X, gift4Y) ; Gift 4
            GuiPopup()
            SkipGift()
            SkipTimer()
            ClickInWindow(gift5X, gift5Y) ; Gift 5
            GuiPopup()
            SkipGift()
            SkipTimer()
            ClickInWindow(gift6X, gift6Y) ; Gift 6
            GuiPopup()
            SkipGift()
            SkipTimer()
            ClickInWindow(gift7X, gift7Y) ; Gift 7
            GuiPopup()
            SkipGift()
            SkipTimer()
            ClickInWindow(gift8X, gift8Y) ; Gift 8
            GuiPopup()
            SkipGift()
            SkipTimer()
            ClickInWindow(gift9X, gift9Y)  ; Gift 9
            GuiPopup()
            SkipGift()
            SkipTimer()
            ClickInWindow(lastGiftClickX, lastGiftClickY)
            lastHourlyAction := currentTick
        }

    ; === Claim Chests Feature (Shoutout lyfejr) ===
    if (autoClaimChests) {
        if (!lastFloatingChestAction)
            lastFloatingChestAction := currentTick
        if (!lastVoidChestAction)
            lastVoidChestAction := currentTick
        if (!LastInfinityChestAction)
            lastInfinityChestAction := currentTick

        ; == Floating Chest ==
        if ((currentTick - lastFloatingChestAction) >= floatingChestTime) {
            Send, m
            Sleep, %mapLoadTime%
            Loop, 3 {
                ClickInWindow(arrowButtonXDown, arrowButtonYDown)
                Sleep, 200
            }
            ClickInWindow(FloatingChestX, FloatingChestY) ; Collect Floating Chest
            Sleep, 100
            Send, m
            Sleep, 1000
            lastFloatingChestAction := currentTick
        }

        ; == Void Chest ==
        if ((currentTick - lastVoidChestAction) >= voidChestTime) {
            Send, m
            Sleep, %mapLoadTime%
            ClickInWindow(arrowButtonXDown, arrowButtonYDown)
            Sleep, 200
            ClickInWindow(VoidChestX, VoidChestY) ; Collect Void Chest
            Sleep, 100
            Send, m
            Sleep, 1000
            lastVoidChestAction := currentTick
        }
        ; == Infinity Chest ==
        if (VipChest) {
        if ((currentTick - LastInfinityChestAction) >= infinityChestTime) {
            Send, m
            Sleep, %mapLoadTime%
            Loop, 5 {
                ClickInWindow(arrowButtonXDown, arrowButtonYDown)
                Sleep, 200
            }
            ClickInWindow(InfinityChestX, InfinityChestY) ; Collect Floating Chest
            Sleep, 100
            Send, m
            Sleep, 1000
            lastInfinityChestAction := currentTick
        }
    }
    }
    ; == Alien Shop Feature ==
    if (alienShopBuy) {
        if (!lastAlienShopAction)
            lastAlienShopAction := currentTick

        if ((currentTick - lastAlienShopAction) >= alienShopTime) {
            ; === walk to alien shop pattern ===
            ClickWhileMoving(2000, "w")
            Sleep, 100
            ClickWhileMoving(300, "d")
            Sleep, 100
            ClickWhileMoving(1000, "w")
            Sleep, 100
            ClickWhileMoving(3600, "d")
            Sleep, 1000
            ClickWhileMoving(650, "s")
            Sleep, 500

            if (webhookImage) {
                WebhookURL := WebhookLink
                FilePath := A_ScriptDir . "\shop_screenshot.png"

                if !pToken := Gdip_Startup() {
                    MsgBox, Failed to start GDI+
                    ExitApp
                }
                screenArea := shopShotX "|" shopShotY "|" shopShotW "|" shopShotH
                pBitmap := Gdip_BitmapFromScreen(screenArea)
                Gdip_SaveBitmapToFile(pBitmap, FilePath, 100)
                Gdip_DisposeImage(pBitmap)
                Gdip_Shutdown(pToken)
            }

            ; === Buy item click positions ===
            Loop, 30 {
                Click, %ShopSlot1X%, %ShopSlot1Y%
                Sleep, 100
            }
            Loop, 30 {
                Click, %ShopSlot2X%, %ShopSlot2Y%
                Sleep, 100
            }
            Loop, 30 {
                Click, %ShopSlot3X%, %ShopSlot3Y%
                Sleep, 100
            }

            if (webhookImage) {
                Run, %ComSpec% /c curl -F "file1=@%FilePath%" -F "content=## Alien Shop Buy Successful" %WebhookURL%, , Hide
                Sleep, 500
                FileDelete, %FilePath%
            }

            lastAlienShopAction := currentTick
            return
        }
    }

    ; == Sell Bubblegum Feature ==
    if (sellBubbles) {
        if (!lastMovementAction)
            lastMovementAction := currentTick

        if ((currentTick - lastMovementAction) >= bubbleSellTime) {
            Send, m
            Sleep, mapLoadTime

            Loop, 2 {
                ClickInWindow(arrowButtonXDown, arrowButtonYDown)
                Sleep, 200
            }
            ClickInWindow(tpButtonX, tpButtonY)
            Sleep, mapLoadTime

            Send, {s down}
            Sleep, 250
            Send, {s up}
            Sleep, 100
            Send, {a down}
            Sleep, 900
            Send, {a up}
            Sleep, 100

            Send, m
            Sleep, mapLoadTime

            Loop, 4 {
                ClickInWindow(arrowButtonX, arrowButtonY)
                Sleep, 200
            }
            ClickInWindow(tpButtonX, tpButtonY)

            lastMovementAction := currentTick
            return
        }
    }

    ; == Black Market Shop Feature ==
    if (blackMarketShopBuy) {
        if (!lastBMShopAction)
            lastBMShopAction := currentTick

        if ((currentTick - lastBMShopAction) >= blackMarketShopTime) {

            Send, m
            Sleep, mapLoadTime

            ClickInWindow(arrowButtonXDown, arrowButtonYDown)
            Sleep, 100
            ClickInWindow(tpButtonX, tpButtonY)
            Sleep, mapLoadTime
            

            ; === walk to black market shop pattern ===
            Send, {a down}
            Sleep, 750
            Send, {a up}
            Sleep, 1000
            Send, {s down}
            Sleep, 1250
            Send, {s up}
            Sleep, 1000
            Send, {d down}
            Sleep, 350
            Send, {d up}
            Sleep, 1000

            if (webhookImage) {
                WebhookURL := WebhookLink
                FilePath := A_ScriptDir . "\bmshop_screenshot.png"

                if !pToken := Gdip_Startup() {
                    MsgBox, Failed to start GDI+
                    ExitApp
                }
                bmscreenArea := shopShotX "|" shopShotY "|" shopShotW "|" shopShotH
                pBitmap := Gdip_BitmapFromScreen(bmscreenArea)
                Gdip_SaveBitmapToFile(pBitmap, FilePath, 100)
                Gdip_DisposeImage(pBitmap)
                Gdip_Shutdown(pToken)
            }

            ; === Buy item click positions ===
            Loop, 10 {
                Click, %ShopSlot1X%, %ShopSlot1Y%
                Sleep, 50
            }
            Loop, 10 {
                Click, %ShopSlot2X%, %ShopSlot2Y%
                Sleep, 50
            }
            Loop, 10 {
                Click, %ShopSlot3X%, %ShopSlot3Y%
                Sleep, 50
            }

            if (webhookImage) {
                Run, %ComSpec% /c curl -F "file1=@%FilePath%" -F "content=## Black Market Shop Buy Successful" %WebhookURL%, , Hide
                Sleep, 500
                FileDelete, %FilePath%
            }

            Send, m
            Sleep, mapLoadTime
            ClickInWindow(arrowButtonX, arrowButtonY)
            Sleep, 150
            ClickInWindow(tpButtonX, tpButtonY)
            Sleep, mapLoadTime

            lastBMShopAction := currentTick
            return
        }
    }

    ; == Auto Claim Spin Wheel Feature ==
    if (wheelSpinClaim) {
        if (!lastWheelAction)
            lastWheelAction := currentTick

        if ((currentTick - lastWheelAction) >= wheelClaimTime) {
            Send, m
            Sleep, mapLoadTime

            Loop, 4 {
                ClickInWindow(arrowButtonXDown, arrowButtonYDown)
                Sleep, 200
            }
            ClickInWindow(tpButtonX, tpButtonY)
            Sleep, mapLoadTime

            Send, {a down}
            Sleep, 900
            Send, {a up}
            Sleep, 100

            ClickInWindow(WheelClaimX, WheelClaimY)
            Sleep, 100

            Send, m
            Sleep, mapLoadTime

            Loop, 4 {
                ClickInWindow(arrowButtonX, arrowButtonY)
                Sleep, 200
            }
            ClickInWindow(tpButtonX, tpButtonY)

            lastWheelAction := currentTick
            return
        }
    }

    ; == Currency Webhook Feature ==
    if ((currentTick - LastWebhookSent) >= WebhookTime) {
        if (webhookImage) {
            WebhookURL := WebhookLink
            FilePath := A_ScriptDir . "\screenshot.png"

            if !pToken := Gdip_Startup() {
                MsgBox, Failed to start GDI+
                ExitApp
            }
            screenCurArea := curShotX "|" curShotY "|" curShotW "|" curShotH
            pBitmap := Gdip_BitmapFromScreen(screenCurArea)
            Gdip_SaveBitmapToFile(pBitmap, FilePath, 100)
            Gdip_DisposeImage(pBitmap)
            Gdip_Shutdown(pToken)

            RunWait, %ComSpec% /c curl -F "file1=@%FilePath%" %WebhookURL%, , Hide
            FileDelete, %FilePath%

            LastWebhookSent := currentTick
        }
    }


	}
        Gosub, DoMovements
}
return

; == Reconnect Feature ==
Reconnect() {
    global reconX, reconY, targetWindow
    global playButtonX, playButtonY, optimizeButtonX, optimizeButtonY, arrowButtonX, arrowButtonY, tpButtonX, tpButtonY
    global gameLoadTime, assetLoadTime, disconnectColor

    PixelGetColor, color, reconX, reconY
    Sleep, 1000

    if (color = disconnectColor) {
        ToolTip, Disconnect Detected Rejoining game...

        Run, roblox://placeID=85896571713843
        ToolTip, Waiting to make sure game loads..
        Sleep, gameLoadTime
        
        ToolTip, Waiting for Roblox window...
        WinWaitActive, %targetWindow%, , 10
        if !WinActive(targetWindow) {
            ToolTip, Roblox window not active!
            Sleep, 3000
            return
        }

        ToolTip, Rejoin Success!. Starting macro sequenece..
        Sleep, 1000
        ToolTip

        ToolTip, Clicking Play Button
        ClickInWindow(playButtonX, playButtonY)
        Sleep, 1500

        ToolTip, Clicking Optimized Button
        ClickInWindow(optimizeButtonX, optimizeButtonY)
        ToolTip
        Sleep, assetLoadTime

        toggle := true

        Send, m
        ToolTip, waiting 10 seconds to ensure map loads...
        Sleep, 10000
        Tooltip

        ToolTip, Clicking Up Arrow
        Loop, 6 {
            ClickInWindow(arrowButtonX, arrowButtonY) 
            Sleep, 200
        }
        Sleep, 1000

        ToolTip, Clicking TP Button
        ClickInWindow(tpButtonX, tpButtonY)
        ToolTip
        Sleep, 3000

        ToolTip, Movements Started
        Sleep, 100
        ToolTip
        Gosub, DoMovements
        SetTimer, MainLoop, 10

        Sleep, 1000
    }
}