#! /bin/sh

# Create necessary directories
mkdir -p ~/Library/Application\ Support/Code/User
mkdir -p ~/.config/windsurf
mkdir -p ~/.claude

# vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# vscode
ln -sf ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# windsurf
ln -sf ~/dotfiles/windsurf/settings.json ~/.config/windsurf/settings.json
ln -sf ~/dotfiles/windsurf/keybindings.json ~/.config/windsurf/keybindings.json

# claude
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md

echo "Configuration files have been linked successfully!"
