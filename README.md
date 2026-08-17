# dotfiles

Personal setup.

## tmux

- `tmux/tmux.conf` — prefix `Ctrl+a`, vi copy mode → `pbcopy`, mouse on, Catppuccin status bar.
- Requires a [Nerd Font](https://www.nerdfonts.com/) in your terminal for the status bar icons (e.g. `brew install --cask font-meslo-lg-nerd-font`).

## claude code

- `claude/CLAUDE.md` — global instructions (reply style, tone).
- `claude/settings.json` — model, permissions, enabled plugins, statusline hookup.
- `claude/statusline-command.sh` — status line: user, git branch, model, rate-limit meters, context usage.

## install

```sh
./install.sh
```

Symlinks `tmux/tmux.conf` to `~/.tmux.conf`, `claude/CLAUDE.md` → `~/.claude/CLAUDE.md`, `claude/settings.json` → `~/.claude/settings.json`, `claude/statusline-command.sh` → `~/.claude/statusline-command.sh`; installs TPM and its plugins.
