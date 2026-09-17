# /// script
# requires-python = ">=3.10"
# dependencies = [
#   "pillow>=11,<13",
#   "qrcode>=8,<9",
# ]
# ///

"""Generate a QR-code PNG from a UTF-8 text file."""

from pathlib import Path
import sys

import qrcode


def main() -> int:
    if len(sys.argv) != 3:
        print("usage: clipboard_to_qr.py INPUT_TEXT OUTPUT_PNG", file=sys.stderr)
        return 2

    input_path = Path(sys.argv[1])
    output_path = Path(sys.argv[2])
    text = input_path.read_text(encoding="utf-8-sig")
    if not text:
        print("input is empty", file=sys.stderr)
        return 2

    image = qrcode.make(text)
    image.save(output_path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

