#NoEnv
#SingleInstance Force
SendMode Input
SetTitleMatchMode, 2
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

; =========================================
; SERIAL NUMBER
; =========================================

serial := "UNKNOWN"

shell := ComObjCreate("WScript.Shell")
exec := shell.Exec("cmd /c wmic bios get serialnumber")
output := exec.StdOut.ReadAll()

lines := StrSplit(output, "`n")

if (lines.MaxIndex() >= 2)
    serial := Trim(lines[2])

; =========================================
; LAUNCH OCCT
; =========================================

Run, C:\Users\Administrator\Desktop\OCCT\OCCTPro.exe
WinWait, OCCT,, 30
WinActivate, OCCT
Sleep, 8000

; =========================================
; IMAGE CLICK FUNCTION
; =========================================

FindAndClick(image, timeout := 20000)
{
    start := A_TickCount

    while ((A_TickCount - start) < timeout)
    {
        ImageSearch, x, y, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %image%

        if (ErrorLevel = 0)
        {
            Click, %x%, %y%
            return true
        }

        Sleep, 500
    }

    return false
}

; =========================================
; AUTOMATION (IMAGE BASED)
; =========================================

if !FindAndClick("E:\img\stability.png")
    ExitApp

Sleep, 1000

if !FindAndClick("E:\img\platinum.png")
    ExitApp

Sleep, 1000

if !FindAndClick("E:\img\start.png")
    ExitApp

; =========================================
; WAIT TEST (12 HOURS)
; =========================================

Sleep, 44200000

; =========================================
; SCREENSHOT TO DESKTOP
; =========================================


Send, #{PrintScreen}
return

ExitApp