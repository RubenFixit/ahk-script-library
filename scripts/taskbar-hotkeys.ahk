#Requires AutoHotkey v2.0

; Ctrl + Alt + T
; Toggle taskbar visibility without opening Start. Win+T reveals the taskbar;
; restoring the last active application collapses it again.
^!t::
{
    if WinActive("ahk_class Shell_TrayWnd")
    {
        Taskbar_RestoreLastWindow()
    }
    else
    {
        Taskbar_RememberActiveWindow()
        Send("#t")
    }
}

; Ctrl + Alt + Shift + T: toggle Windows taskbar auto-hide.
^!+t::Taskbar_ToggleAutoHide()

Taskbar_ToggleAutoHide()
{
    static ABM_GETSTATE := 0x00000004
    static ABM_SETSTATE := 0x0000000A
    static ABS_AUTOHIDE := 0x1
    static ABS_ALWAYSONTOP := 0x2
    static APPBARDATA_SIZE := A_PtrSize = 8 ? 48 : 36
    static STATE_OFFSET := A_PtrSize = 8 ? 40 : 32

    appBarData := Buffer(APPBARDATA_SIZE, 0)
    NumPut("UInt", APPBARDATA_SIZE, appBarData, 0)

    state := DllCall(
        "Shell32\SHAppBarMessage",
        "UInt", ABM_GETSTATE,
        "Ptr", appBarData,
        "Ptr"
    )
    newState := (state & ABS_AUTOHIDE)
        ? ABS_ALWAYSONTOP
        : ABS_AUTOHIDE | ABS_ALWAYSONTOP

    NumPut("UInt", newState, appBarData, STATE_OFFSET)
    DllCall(
        "Shell32\SHAppBarMessage",
        "UInt", ABM_SETSTATE,
        "Ptr", appBarData,
        "Ptr"
    )
}

Taskbar_RememberActiveWindow()
{
    Taskbar_LastWindowId(WinExist("A"))
}

Taskbar_RestoreLastWindow()
{
    lastWindowId := Taskbar_LastWindowId()

    if lastWindowId && WinExist("ahk_id " . lastWindowId)
        WinActivate("ahk_id " . lastWindowId)
}

Taskbar_LastWindowId(newWindowId?)
{
    static lastWindowId := 0

    if IsSet(newWindowId)
        lastWindowId := newWindowId

    return lastWindowId
}
