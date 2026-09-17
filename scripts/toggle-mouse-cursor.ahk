#Requires AutoHotkey v2.0

; Win + Alt + M: toggle system cursor visibility.
#!m::
{
    static cursorVisible := true
    static cleanupRegistered := false

    if !cleanupRegistered
    {
        OnExit(RestoreSystemCursor)
        cleanupRegistered := true
    }

    cursorVisible := !cursorVisible
    SystemCursor(cursorVisible)
}

SystemCursor(visible := true)
{
    static SPI_SETCURSORS := 0x0057
    static cursorIds := [
        32512, ; Arrow
        32513, ; I-beam
        32514, ; Wait
        32515, ; Crosshair
        32516, ; Up arrow
        32642, ; Size NW-SE
        32643, ; Size NE-SW
        32644, ; Size W-E
        32645, ; Size N-S
        32646, ; Size all
        32648, ; No
        32649, ; Hand
        32650, ; App starting
        32651  ; Help
    ]

    if visible
    {
        DllCall(
            "User32\SystemParametersInfo",
            "UInt", SPI_SETCURSORS,
            "UInt", 0,
            "Ptr", 0,
            "UInt", 0
        )
        return
    }

    andMask := Buffer(32 * 4, 0xFF)
    xorMask := Buffer(32 * 4, 0)

    for cursorId in cursorIds
    {
        blankCursor := DllCall(
            "User32\CreateCursor",
            "Ptr", 0,
            "Int", 0,
            "Int", 0,
            "Int", 32,
            "Int", 32,
            "Ptr", andMask,
            "Ptr", xorMask,
            "Ptr"
        )
        if !blankCursor
            throw Error("CreateCursor failed (error " . A_LastError . ")")

        if !DllCall("User32\SetSystemCursor", "Ptr", blankCursor, "UInt", cursorId)
        {
            DllCall("User32\DestroyCursor", "Ptr", blankCursor)
            throw Error("SetSystemCursor failed (error " . A_LastError . ")")
        }
    }
}

RestoreSystemCursor(exitReason, exitCode)
{
    SystemCursor(true)
}
