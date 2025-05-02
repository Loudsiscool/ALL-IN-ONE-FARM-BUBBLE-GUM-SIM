settingsFile := A_ScriptDir . "\..\..\settings.ini"

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

startKey := readSetting("startKey")
stopKey := readSetting("stopKey")

SysGet, monPrimary, MonitorPrimary
SysGet, monArea, MonitorWorkArea, %monPrimary%
middleX := monAreaLeft
middleY := monAreaTop + 150

backgroundPath := A_ScriptDir . "\..\Gui\background.png"
logoPath := A_ScriptDir . "\..\Gui\egghatch.png"

Gui, TooltipGui:New
Gui, TooltipGui:-Caption +AlwaysOnTop +ToolWindow
Gui, TooltipGui:Margin, 0, 0
Gui, TooltipGui:Color, Black
Gui, TooltipGui:Font, s7.5 cWhite, Verdana

Gui, TooltipGui:Add, Picture, x0 y0 w220 h220 0xE, %backgroundPath%

Gui, TooltipGui:Add, Picture, x10 y10 w200 h90, %logoPath%
Gui, TooltipGui:Add, Text, vText2, Created By: FyReO
Gui, TooltipGui:Add, Text, vText4, Subscribe On YouTube
Gui, TooltipGui:Add, Text, vActionText, % Format("{:U}", startKey) ": To Start Hatching"
Gui, TooltipGui:Add, Text, vActionText2, Y: To Open GUI

GuiControl, Move, vText2, x10 y145 w200 h20
GuiControl, Move, vText4, x10 y170 w200 h20
GuiControl, Move, vActionText, x10 y195 w200 h20
GuiControl, Move, vActionTex2t, x10 y205 w200 h20

Gui, TooltipGui:Show, x%middleX% y%middleY% NoActivate, Tooltips

Hotkey, %startKey%, StartMacro
Hotkey, %stopKey%, StopMacro
return

toggle := false

StartMacro:
GuiControl, TooltipGui:, ActionText, % Format("{:U}", stopKey) ": To Stop Hatching"
toggle := true
SetTimer, SpamE, 10
return

StopMacro:
GuiControl, TooltipGui:, ActionText, % Format("{:U}", startKey) ": To Start Hatching"
toggle := false
SetTimer, SpamE, Off
return

y::
Run, % A_ScriptDir . "\..\..\BGS Macro.ahk"
ExitApp
Return

SpamE:
if (toggle)
{
    Send, e
}
return
