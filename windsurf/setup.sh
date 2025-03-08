#!/bin/bash

# Windsurfの設定ディレクトリ
WINDSURF_CONFIG_DIR="$HOME/.config/windsurf"

# 設定ディレクトリが存在しない場合は作成
mkdir -p "$WINDSURF_CONFIG_DIR"

# 現在のスクリプトのディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 設定ファイルをコピー
echo "Copying Windsurf configuration files..."
cp "$SCRIPT_DIR/settings.json" "$WINDSURF_CONFIG_DIR/"
cp "$SCRIPT_DIR/keybindings.json" "$WINDSURF_CONFIG_DIR/"

# パーミッションを設定
chmod 644 "$WINDSURF_CONFIG_DIR"/*.json

echo "Windsurf configuration has been installed to $WINDSURF_CONFIG_DIR"
