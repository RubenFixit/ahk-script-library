#Requires AutoHotkey v2.0

; Hotstrings to enter time stamps.
:B0X:now_t::DateHotstrings_Insert(FormatTime(, "h:mm tt"))
:B0X:now_t24::DateHotstrings_Insert(FormatTime(, "H:mm"))
:B0X:now_tp::DateHotstrings_Insert(FormatTime(, "hh:mm tt"))
:B0X:now_tp24::DateHotstrings_Insert(FormatTime(, "HH:mm"))
:B0X:now_ts::DateHotstrings_Insert(FormatTime(, "hh:mm:ss tt"))
:B0X:now_ts24::DateHotstrings_Insert(FormatTime(, "HH:mm:ss"))

; Hotstrings to enter date stamps.
:B0X:now_d::DateHotstrings_Insert(FormatTime(, "MM/dd/yyyy"))
:B0X:now_ld::DateHotstrings_Insert(FormatTime(, "LongDate"))
:B0X:now_dt::DateHotstrings_Insert(FormatTime(, "MM/dd/yyyy, hh:mm tt"))
:B0X:now_dt24::DateHotstrings_Insert(FormatTime(, "MM/dd/yyyy, HH:mm"))
:B0X:now_ldt::DateHotstrings_Insert(FormatTime(, "LongDate") . FormatTime(, ", hh:mm tt"))
:B0X:now_ldt24::DateHotstrings_Insert(FormatTime(, "LongDate") . FormatTime(, ", HH:mm"))

; Markdown Journal Header with as longdate
:B0X:jh::DateHotstrings_Insert("## " . FormatTime(, "LongDate"))

; Filename-friendly date and time stamps.
:*?B0X:now_ff::DateHotstrings_Insert6(FormatTime(, "yyyyMMdd_HHmmss"))
:*?B0X:now_fd::DateHotstrings_Insert6(FormatTime(, "yyyyMMdd"))
:*?B0X:now_ft::DateHotstrings_Insert6(FormatTime(, "HHmmss"))

DateHotstrings_Insert(text)
{
    ; B0 leaves the trigger in place; Ctrl+Backspace removes it before insertion.
    Send("^{Backspace}")
    SendText(text)
}

DateHotstrings_Insert6(text)
{
    ; B0 leaves the trigger in place; Backspace 5 removes it before insertion.
    Send("{Backspace 6}")
    SendText(text)
}
