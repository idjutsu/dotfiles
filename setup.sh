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
  local permission="$3"

  # 親ディレクトリが存在しない場合は作成
  mkdir -p "$(dirname "$target")"

  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "🔁 Backing up $target"
    mv "$target" "$BACKUP_DIR/"
  fi

  echo "🔗 Linking $src → $target"
  ln -s "$DOTFILES_DIR/$src" "$target"

  # パーミッションを設定（リンク先に対して）
  real_path="$DOTFILES_DIR/$src"
  if [ -f "$real_path" ]; then
    echo "🔒 Setting permission $permission on $real_path"
    chmod "$permission" "$real_path"
  fi
}

# 各 dotfile のリンクとパーミッション設定
link_dotfile "bashrc"     "$HOME/.bashrc"         600
link_dotfile "inputrc"    "$HOME/.inputrc"        600
link_dotfile "tmux.conf"  "$HOME/.tmux.conf"      600
link_dotfile "nvim"       "$HOME/.config/nvim"    700

# nvim 配下のパーミッションも設定（ディレクトリ: 700、ファイル: 600）
echo "🔒 Setting permissions inside nvim/"
find "$DOTFILES_DIR/nvim" -type d -exec chmod 700 {} \;
find "$DOTFILES_DIR/nvim" -type f -exec chmod 600 {} \;

echo "✅ Dotfiles setup complete!"
