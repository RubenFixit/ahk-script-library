# AutoHotkey Script Library

A public collection of general-purpose AutoHotkey v2 scripts. The repository is
also the reference multi-script collection for AutoHotkey Repository Manager.

## Use with AutoHotkey Repository Manager

Add this repository and select `ahk-library.toml`. The manifest exposes each
module independently, so users can enable only the scripts they want.

All current modules use `type = "include"` and are intended to share one trusted
AutoHotkey process. Review hotkeys before enabling modules alongside another
collection.

## Run the entire collection

Run `autohotkey.ahk` with AutoHotkey v2 to load every module without the manager.

## Modules

- `clipboard-to-qr`: creates and opens a QR code from clipboard text with F1
- `payment-fee-calculator`: configurable payment-processing fee calculator
- `type-clipboard`: types clipboard text as keystrokes instead of pasting
- `windows-explorer`: Startup-folder and hidden-file helpers

Clipboard-to-QR also requires `uv`; its Python helper declares and installs its
own `qrcode` and Pillow dependencies. Clipboard contents stay on the local
computer.

## License

MIT
