# vim_config

A plugin-free Vim configuration for macOS. Simple, fast, and fully portable — just Vim.

## What's Inside

| File | Purpose |
| --- | --- |
| `.vimrc` | The Vim configuration |
| `vim-dictionary.md` | Full reference guide for this setup |
| `setup.sh` | One-command installer |

## Install

```bash
git clone https://github.com/KSpirin/vim_config.git ~/vim_config
cd ~/vim_config
chmod +x setup.sh
./setup.sh
```

This will:

1. **Back up** your existing `~/.vimrc` (timestamped, nothing is lost)
2. **Symlink** this repo's `.vimrc` → `~/.vimrc`
3. **Create** `~/.vim/backup`, `~/.vim/swap`, `~/.vim/undo` directories

## Optional: Install ripgrep

For project-wide search (`Space /`):

```bash
brew install ripgrep
```

Without it, `Space /` falls back to Vim's built-in `:grep`.

## Uninstall

```bash
rm ~/.vimrc
# Restore your backup:
mv ~/.vimrc.backup.<timestamp> ~/.vimrc
```

## Features

- **Zero plugins** — everything uses built-in Vim features
- **Space as leader** — `Space w` to save, `Space q` to quit, `Space e` for file explorer
- **Built-in cheat sheet & panic button** — `Space ?` to view shortcuts anytime, `Space o` to close all extra splits/panels and keep only your code
- **Smart defaults** — syntax on, line numbers, smart search, auto-indent, statusline with quick hints
- **Seamless window & terminal navigation** — `Ctrl+h/j/k/l` moves between splits and jumps straight out of terminal mode (`Esc Esc` also exits terminal mode)
- **One-key code runner** — `Space r` runs C, C++, Java, Python in a clean bottom split (auto-replaces old runner splits so windows never stack up)
- **Git shortcuts** — `Space gs`, `Space gd`, `Space gl`, `Space ga`
- **Project search** — `Space /` with ripgrep + auto-opening Quickfix navigation
- **Pink/purple color scheme** — custom 256-color theme with rainbow braces and matching bracket highlight

See [vim-dictionary.md](vim-dictionary.md) for the full reference guide.

## Requirements

- Vim 8.0+ (for terminal support)
- macOS (tested) / Linux (should work)
- Optional: ripgrep (`brew install ripgrep`) for `Space /`
