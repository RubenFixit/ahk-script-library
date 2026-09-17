#Requires AutoHotkey v2.0
#Warn
#SingleInstance Force

CoordMode("Mouse", "Screen")

MoveDelay := 10 * 60 * 1000

OnExit(SessionCleanup)
SessionChange(true)
SetTimer(MoveTimer, MoveDelay)

MoveTimer()
{
    MouseMove(1, 1, 0, "R")
    MouseMove(-1, -1, 0, "R")
}

SessionChange(notify := true)
{
    static WTS_CURRENT_SERVER := 0
    static NOTIFY_FOR_ALL_SESSIONS := 1

    if notify
    {
        registered := DllCall(
            "Wtsapi32\WTSRegisterSessionNotificationEx",
            "Ptr", WTS_CURRENT_SERVER,
            "Ptr", A_ScriptHwnd,
            "UInt", NOTIFY_FOR_ALL_SESSIONS
        )
        if !registered
            throw Error("WTSRegisterSessionNotificationEx failed (error " . A_LastError . ")")

        OnMessage(0x02B1, WM_WTSSESSION_CHANGE)
    }
    else
    {
        OnMessage(0x02B1, WM_WTSSESSION_CHANGE, 0)
        DllCall(
            "Wtsapi32\WTSUnRegisterSessionNotificationEx",
            "Ptr", WTS_CURRENT_SERVER,
            "Ptr", A_ScriptHwnd
        )
    }
}

WM_WTSSESSION_CHANGE(wParam, lParam, msg, hwnd)
{
    global MoveDelay
    static WTS_SESSION_LOCK := 0x7
    static WTS_SESSION_UNLOCK := 0x8

    if (wParam = WTS_SESSION_LOCK)
        SetTimer(MoveTimer, 0)
    else if (wParam = WTS_SESSION_UNLOCK)
        SetTimer(MoveTimer, MoveDelay)
}

SessionCleanup(exitReason, exitCode)
{
    try SessionChange(false)
}
