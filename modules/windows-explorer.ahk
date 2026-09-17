; Windows and File Explorer helpers.

; Win+S: open the current user's Startup folder.
#s::Run('explore "' A_AppData '\Microsoft\Windows\Start Menu\Programs\Startup"')

; Win+H: toggle hidden files, then refresh the active window.
#h::
{
    hiddenStatus := RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "Hidden")
    if (hiddenStatus = 2)
        RegWrite(1, "REG_DWORD", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "Hidden")
    else
        RegWrite(2, "REG_DWORD", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "Hidden")
    Send("{F5}")
}

