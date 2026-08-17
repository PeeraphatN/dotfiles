#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf "$DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

"$HOME/.tmux/plugins/tpm/bin/install_plugins"

mkdir -p "$HOME/.claude"
ln -sf "$DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
ln -sf "$DIR/claude/settings.json" "$HOME/.claude/settings.json"
ln -sf "$DIR/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"

echo "done. start tmux to load config."
