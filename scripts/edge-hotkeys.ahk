#Requires AutoHotkey v2.0

; Microsoft Edge tab switching bridge for:
; CLUT: Cycle Last Used Tabs
; https://chromewebstore.google.com/detail/clut-cycle-last-used-tabs/cobieddmkhhnbeldhncnfcgcaccmehgn?hl=en
;
; Edge does not natively support MRU tab switching with Ctrl+Tab, so these
; remaps translate the standard shortcuts into the extension shortcuts.

#HotIf WinActive("ahk_exe msedge.exe")
^Tab::Send("!s")
^+Tab::Send("!+s")
#HotIf
