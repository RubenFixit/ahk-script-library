#Requires AutoHotkey v2.0

; Split comma-separated clipboard contents into separate tabbed entries.
; Shift + Alt + V
+!v::
{
    lines := StrSplit(A_Clipboard, ",")
    MsgBox("Found " . lines.Length . " lines")

    for _, line in lines
    {
        SendText(line)
        Send("{Tab}{Space}")
        Sleep(1000)
    }
}

; Convert a Windows path in the clipboard to a Linux path.
; Ctrl + Shift + /
^+/::
{
    A_Clipboard := StrReplace(A_Clipboard, "\", "/")
}

; Type out clipboard content instead of pasting it.
; Shift + Ctrl + V
+^v::
{
    clipboardContent := A_Clipboard
    Sleep(1000)
    SetKeyDelay(20, 2, "Event")
    SendEvent("{Text}" . clipboardContent)
}
