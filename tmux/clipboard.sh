#!/usr/bin/env bash
# Copies stdin to the system clipboard, detecting the OS/environment first.
set -euo pipefail

if grep -qi microsoft /proc/version 2>/dev/null; then
  iconv -f utf-8 -t utf-16le | clip.exe
elif command -v pbcopy >/dev/null 2>&1; then
  pbcopy
elif [ -n "${WAYLAND_DISPLAY:-}" ] && command -v wl-copy >/dev/null 2>&1; then
  wl-copy
elif command -v xclip >/dev/null 2>&1; then
  xclip -selection clipboard
elif command -v xsel >/dev/null 2>&1; then
  xsel --clipboard --input
else
  cat >/dev/null
fi
