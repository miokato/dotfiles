#! /bin/sh

# Create necessary directories
mkdir -p ~/Library/Application\ Support/Code/User
mkdir -p ~/.config/windsurf
mkdir -p ~/.claude

# Vim configuration
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# Install Vim plugins and colorschemes using vim-plug
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Install plugins
    echo "Installing Vim plugins..."
    vim +PlugInstall +qall
fi

# VSCode configuration
ln -sf ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# Windsurf configuration
ln -sf ~/dotfiles/windsurf/settings.json ~/.config/windsurf/settings.json
ln -sf ~/dotfiles/windsurf/keybindings.json ~/.config/windsurf/keybindings.json

# Claude configuration
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md

echo "Configuration files have been linked successfully!"
