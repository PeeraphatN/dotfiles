# dotfiles

Personal setup.

## tmux

- `tmux/tmux.conf` — prefix `Ctrl+a`, vi copy mode → `pbcopy`, mouse on, Catppuccin status bar.
- Requires a [Nerd Font](https://www.nerdfonts.com/) in your terminal for the status bar icons (e.g. `brew install --cask font-meslo-lg-nerd-font`).

## install

```sh
./install.sh
```

Symlinks `tmux/tmux.conf` to `~/.tmux.conf`, installs TPM, and installs plugins.
