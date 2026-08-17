#!/usr/bin/env bash
# Claude Code status line — user, git branch, model, rate-limit meters, context usage.
# Parsing is done in a single python3 pass (no jq dependency).

input=$(cat)

# Log raw payload for debugging
printf '%s' "$input" > /tmp/statusline-debug.json

if ! command -v python3 >/dev/null 2>&1; then
    printf '\033[01;32m%s\033[00m' "$(whoami)"
    exit 0
fi

printf '%s' "$input" | python3 -c '
import getpass, json, os, sys

try:
    d = json.load(sys.stdin)
except Exception:
    d = {}

def dig(*path):
    cur = d
    for key in path:
        if not isinstance(cur, dict):
            return None
        cur = cur.get(key)
    return cur

BAR_WIDTH = 12
FILLED, EMPTY = "▓", "░"

def color(text, code):
    return "\033[{}m{}\033[0m".format(code, text)

def git_branch(start):
    """Branch name for the repo containing `start`, or None. Reads .git directly."""
    path = os.path.abspath(start)
    while True:
        dotgit = os.path.join(path, ".git")
        if os.path.isfile(dotgit):          # worktree / submodule: "gitdir: <path>"
            try:
                with open(dotgit) as fh:
                    line = fh.read().strip()
            except OSError:
                return None
            if line.startswith("gitdir:"):
                dotgit = os.path.join(path, line[7:].strip())
            else:
                return None
        if os.path.isdir(dotgit):
            try:
                with open(os.path.join(dotgit, "HEAD")) as fh:
                    head = fh.read().strip()
            except OSError:
                return None
            if head.startswith("ref: refs/heads/"):
                return head[len("ref: refs/heads/"):]
            return head[:7] or None         # detached HEAD
        parent = os.path.dirname(path)
        if parent == path:
            return None
        path = parent

def meter(label, key, hue):
    """label:[▓▓░░░░]NN%  — hue is a 256-color index for label + filled cells."""
    pct = dig("rate_limits", key, "used_percentage")
    if not isinstance(pct, (int, float)):
        return None
    pct = max(0.0, min(100.0, float(pct)))
    cells = int(round(pct / 100 * BAR_WIDTH))
    if pct > 0 and cells == 0:
        cells = 1
    bar = (color(FILLED * cells, "38;5;{}".format(hue)) +
           color(EMPTY * (BAR_WIDTH - cells), "38;5;240"))
    return "{}{}{}{}{}".format(
        color(label + ":", "38;5;{}".format(hue)),
        color("[", "38;5;240"),
        bar,
        color("]", "38;5;240"),
        color("{:.0f}%".format(pct), "38;5;{}".format(hue)),
    )

parts = []

# --- User (bold green) ---
parts.append(color(getpass.getuser(), "1;32"))

# --- Git branch (bold cyan) ---
branch = git_branch(dig("cwd") or os.getcwd())
if branch:
    parts.append(color(branch, "1;36"))

# --- Model (bold white) ---
model = dig("model", "display_name")
if model:
    parts.append(color(model, "1;37"))

# --- Rate limits ---
for text in (meter("5h", "five_hour", 215), meter("7d", "seven_day", 141)):
    if text:
        parts.append(text)

# --- Context window, numeric token count (dim grey) ---
tin = dig("context_window", "total_input_tokens")
tout = dig("context_window", "total_output_tokens")
if isinstance(tin, (int, float)) and isinstance(tout, (int, float)):
    tokens = tin + tout
    label = "{:.1f}k".format(tokens / 1000) if tokens >= 1000 else str(int(tokens))
    parts.append(color("ctx:{}".format(label), "38;5;245"))

sys.stdout.write(" ".join(parts))
'
