#! /bin/sh

# Create necessary directories
mkdir -p ~/.vim
mkdir -p ~/Library/Application\ Support/Code/User
mkdir -p ~/.config/windsurf

# Vim configuration
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim

# VSCode configuration
ln -sf ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# Windsurf configuration
ln -sf ~/dotfiles/windsurf/settings.json ~/.config/windsurf/settings.json
ln -sf ~/dotfiles/windsurf/keybindings.json ~/.config/windsurf/keybindings.json

echo "Configuration files have been linked successfully!"
