#!/bin/bash
# install.sh — Install the plugin-free Vim configuration
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
VIMRC_SRC="$REPO_DIR/.vimrc"
VIMRC_DST="$HOME/.vimrc"

echo "=== Vim Environment Installer ==="
echo ""

# --- Back up existing .vimrc ---
if [ -f "$VIMRC_DST" ] || [ -L "$VIMRC_DST" ]; then
    BACKUP="$VIMRC_DST.backup.$(date +%Y%m%d%H%M%S)"
    echo "[backup]  $VIMRC_DST → $BACKUP"
    cp "$VIMRC_DST" "$BACKUP"
fi

# --- Symlink .vimrc ---
echo "[link]    $VIMRC_SRC → $VIMRC_DST"
ln -sf "$VIMRC_SRC" "$VIMRC_DST"

# --- Create required directories ---
echo "[mkdir]   ~/.vim/backup"
mkdir -p "$HOME/.vim/backup"

echo "[mkdir]   ~/.vim/swap"
mkdir -p "$HOME/.vim/swap"

echo "[mkdir]   ~/.vim/undo"
mkdir -p "$HOME/.vim/undo"

# --- Check for optional dependencies ---
echo ""
if command -v rg &>/dev/null; then
    echo "[ok]      ripgrep (rg) found — project search (Space /) will work"
else
    echo "[info]    ripgrep (rg) not found — Space / will fall back to built-in grep"
    echo "          Install: brew install ripgrep"
fi

echo ""
echo "Done! Open Vim to start using the config."
echo "See vim-dictionary.md for the full reference guide."
