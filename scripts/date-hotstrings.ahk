#Requires AutoHotkey v2.0

; Hotstrings to enter time stamps.
:B0X:now_t::InsertHotstringText(FormatTime(, "h:mm tt"))
:B0X:now_t24::InsertHotstringText(FormatTime(, "H:mm"))
:B0X:now_tp::InsertHotstringText(FormatTime(, "hh:mm tt"))
:B0X:now_tp24::InsertHotstringText(FormatTime(, "HH:mm"))
:B0X:now_ts::InsertHotstringText(FormatTime(, "hh:mm:ss tt"))
:B0X:now_ts24::InsertHotstringText(FormatTime(, "HH:mm:ss"))

; Hotstrings to enter date stamps.
:B0X:now_d::InsertHotstringText(FormatTime(, "MM/dd/yyyy"))
:B0X:now_ld::InsertHotstringText(FormatTime(, "LongDate"))
:B0X:now_dt::InsertHotstringText(FormatTime(, "MM/dd/yyyy, hh:mm tt"))
:B0X:now_dt24::InsertHotstringText(FormatTime(, "MM/dd/yyyy, HH:mm"))
:B0X:now_ldt::InsertHotstringText(FormatTime(, "LongDate") . FormatTime(, ", hh:mm tt"))
:B0X:now_ldt24::InsertHotstringText(FormatTime(, "LongDate") . FormatTime(, ", HH:mm"))

; Markdown Journal Header with as longdate
:B0X:jh::InsertHotstringText("## " . FormatTime(, "LongDate"))

; Filename-friendly date and time stamps.
:*?B0X:now_ff::InsertHotstringText6(FormatTime(, "yyyyMMdd_HHmmss"))
:*?B0X:now_fd::InsertHotstringText6(FormatTime(, "yyyyMMdd"))
:*?B0X:now_ft::InsertHotstringText6(FormatTime(, "HHmmss"))

InsertHotstringText(text)
{
    ; B0 leaves the trigger in place; Ctrl+Backspace removes it before insertion.
    Send("^{Backspace}")
    SendText(text)
}

InsertHotstringText6(text)
{
    ; B0 leaves the trigger in place; Backspace 5 removes it before insertion.
    Send("{Backspace 6}")
    SendText(text)
}
