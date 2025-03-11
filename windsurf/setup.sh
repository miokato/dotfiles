#!/bin/bash

# Windsurfの設定ディレクトリ
WINDSURF_CONFIG_DIR="$HOME/Library/Application Support/windsurf/User"

# 設定ディレクトリが存在しない場合は作成
mkdir -p "$WINDSURF_CONFIG_DIR"

# 現在のスクリプトのディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 既存の設定ファイルのバックアップを作成（存在する場合）
if [ -f "$WINDSURF_CONFIG_DIR/settings.json" ]; then
    mv "$WINDSURF_CONFIG_DIR/settings.json" "$WINDSURF_CONFIG_DIR/settings.json.backup"
fi
if [ -f "$WINDSURF_CONFIG_DIR/keybindings.json" ]; then
    mv "$WINDSURF_CONFIG_DIR/keybindings.json" "$WINDSURF_CONFIG_DIR/keybindings.json.backup"
fi

# シンボリックリンクを作成
echo "Creating symbolic links for Windsurf configuration files..."
ln -sf "$SCRIPT_DIR/settings.json" "$WINDSURF_CONFIG_DIR/settings.json"
ln -sf "$SCRIPT_DIR/keybindings.json" "$WINDSURF_CONFIG_DIR/keybindings.json"

echo "Windsurf configuration has been installed to $WINDSURF_CONFIG_DIR"
