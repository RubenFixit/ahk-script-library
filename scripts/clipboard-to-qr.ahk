; F1: turn clipboard text into a QR-code PNG and open it.
F1::CreateClipboardQr()

CreateClipboardQr() {
    clipboardText := A_Clipboard
    if (clipboardText = "") {
        MsgBox("The clipboard does not contain any text.", "Clipboard to QR", "Icon!")
        return
    }

    SplitPath(A_LineFile, , &moduleDir)
    processId := DllCall("GetCurrentProcessId")
    inputPath := A_Temp "\clipboard-qr-" processId ".txt"
    outputPath := A_Temp "\clipboard-qr-" processId ".png"
    helperPath := moduleDir "\..\support\clipboard_to_qr.py"

    try FileDelete(inputPath)
    try FileDelete(outputPath)
    FileAppend(clipboardText, inputPath, "UTF-8")

    command := 'uv run --script "' helperPath '" "' inputPath '" "' outputPath '"'
    exitCode := RunWait(command, moduleDir, "Hide")
    try FileDelete(inputPath)

    if (exitCode != 0 || !FileExist(outputPath)) {
        MsgBox("QR-code generation failed. Make sure uv is installed and available on PATH.", "Clipboard to QR", "Iconx")
        return
    }

    Run('"' outputPath '"')
}

