#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d%H%M%S)"

echo "📦 Dotfiles setup started..."
echo "🔙 Backing up existing files to $BACKUP_DIR"

mkdir -p "$BACKUP_DIR"

copy_dotfile() {
  local src="$1"
  local target="$2"

  # 親ディレクトリが存在しない場合は作成
  mkdir -p "$(dirname "$target")"

  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "🔁 Backing up $target"
    mv "$target" "$BACKUP_DIR/"
  fi

  echo "📄 Copying $src → $target"
  cp -a "$DOTFILES_DIR/$src" "$target"
}

# 各dotfileのコピー（パーミッション変更は行わない）
copy_dotfile "bashrc"     "$HOME/.bashrc"
copy_dotfile "inputrc"    "$HOME/.inputrc"
copy_dotfile "tmux.conf"  "$HOME/.tmux.conf"
copy_dotfile "nvim"       "$HOME/.config/nvim"

echo "✅ Dotfiles setup complete!"
