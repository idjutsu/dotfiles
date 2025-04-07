#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d%H%M%S)"

echo "📦 Dotfiles setup started..."
echo "🔙 Backing up existing files to $BACKUP_DIR"

mkdir -p "$BACKUP_DIR"

link_dotfile() {
  local src="$1"
  local target="$2"

  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "🔁 Backing up $target"
    mv "$target" "$BACKUP_DIR/"
  fi

  echo "🔗 Linking $src → $target"
  ln -s "$DOTFILES_DIR/$src" "$target"
}

# 各dotfileのリンク
link_dotfile "bashrc"     "$HOME/.bashrc"
link_dotfile "inputrc"    "$HOME/.inputrc"
link_dotfile "tmux.conf"  "$HOME/.tmux.conf"
link_dotfile "nvim"       "$HOME/.config/nvim"

echo "✅ Dotfiles setup complete!"
