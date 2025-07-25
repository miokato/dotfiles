#! /bin/sh

# Create necessary directories
mkdir -p ~/Library/Application\ Support/Code/User
mkdir -p ~/.config/windsurf
mkdir -p ~/.claude
mkdir -p ~/.config/zed

# vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# vscode
ln -sf ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# claude
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md

# zed
ln -sf ~/dotfiles/zed/settings.json ~/.config/zed/settings.json
ln -sf ~/dotfiles/zed/keymap.json ~/.config/zed/keymap.json

echo "Configuration files have been linked successfully!"
