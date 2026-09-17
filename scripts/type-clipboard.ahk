; User-adjustable timing values.
global TypeClipboardTargetTimeoutMs := 10000
global TypeClipboardFocusDelayMs := 300

; Ctrl+Shift+V: type clipboard text as keystrokes instead of pasting it.
^+v::
{
    global TypeClipboardTargetTimeoutMs, TypeClipboardFocusDelayMs
    clipboardContent := RegExReplace(A_Clipboard, "\r\n", "\n")
    if (clipboardContent = "") {
        MsgBox("The clipboard does not contain any text.", "Type Clipboard", "Icon!")
        return
    }

    sourceWindow := WinExist("A")
    KeyWait("Ctrl")
    KeyWait("Shift")
    KeyWait("V")
    ToolTip("Click the location where you want the clipboard text typed.`nPress Escape to cancel.")

    deadline := A_TickCount + TypeClipboardTargetTimeoutMs
    targetWindow := 0
    while (A_TickCount < deadline) {
        if GetKeyState("Escape", "P") {
            ToolTip()
            return
        }
        activeWindow := WinExist("A")
        if (activeWindow && activeWindow != sourceWindow) {
            targetWindow := activeWindow
            break
        }
        Sleep(50)
    }

    ToolTip()
    if !targetWindow
        return
    if !WinActive("ahk_id " targetWindow)
        return

    ; Give the destination control a moment to receive keyboard focus.
    Sleep(TypeClipboardFocusDelayMs)
    if !WinActive("ahk_id " targetWindow)
        return

    SetKeyDelay(20, 2)
    SendEvent("{Raw}" clipboardContent)
}
