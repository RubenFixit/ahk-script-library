# AutoHotkey Script Library

A public collection of general-purpose AutoHotkey v2 scripts. The repository is
also the reference multi-script collection for AutoHotkey Script Manager.

## Use with AutoHotkey Script Manager

Add this repository and select `ahk-library.toml`. The manifest exposes each
module independently, so users can enable only the scripts they want.

All current modules use `type = "include"` and are intended to share one trusted
AutoHotkey process. Review hotkeys before enabling modules alongside another
collection.

## Run the entire collection

Run `autohotkey.ahk` with AutoHotkey v2 to load every module without the manager.

## Modules

- `clipboard-hotkeys`: clipboard text transforms (CSV to tabbed entries, path
  slashes, type instead of paste)
- `clipboard-to-qr`: creates and opens a QR code from clipboard text with F1
- `date-hotstrings`: hotstrings for date and time stamps
- `edge-hotkeys`: remaps Ctrl+Tab/Ctrl+Shift+Tab to the CLUT extension's MRU
  tab-switching shortcuts in Microsoft Edge
- `keep-awake`: periodically nudges the mouse to prevent the system from
  sleeping; runs as its own process
- `key-history`: opens AutoHotkey's built-in key history viewer; runs as its
  own process
- `payment-fee-calculator`: configurable payment-processing fee calculator
- `taskbar-hotkeys`: toggle taskbar visibility and auto-hide without the Start menu
- `toggle-mouse-cursor`: hides or restores the system mouse cursor (Ctrl+Alt+M)
- `type-clipboard`: types clipboard text as keystrokes instead of pasting
- `windows-explorer`: Startup-folder and hidden-file helpers

Clipboard-to-QR also requires `uv`; its Python helper declares and installs its
own `qrcode` and Pillow dependencies. Clipboard contents stay on the local
computer.

## License

MIT
