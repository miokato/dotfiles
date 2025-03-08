# dotfiles

## Install
```bash
$ sh install_mac.sh

# vscode extensions
$ sh install_extensions_mac
```

## Windsurf Setup
Windsurf configurations include:
- Solarized Light theme
- Custom keybindings
  - `cmd+8`: Toggle terminal
  - `cmd+1`: Toggle sidebar
- Extensions:
  - Codeium (AI coding assistant)
  - Python support and debugger
  - Vim keybindings

### Installation
```bash
# Clone this repository
git clone <repository-url> ~/dotfiles

# Run the Windsurf setup script
cd ~/dotfiles/windsurf
./setup.sh

# Install Windsurf extensions
cd ~/dotfiles
./install_extensions_mac.sh
```

The setup script will:
1. Create the Windsurf config directory if it doesn't exist
2. Copy the configuration files to `~/.config/windsurf/`
3. Set appropriate file permissions

The extensions script will install both VSCode and Windsurf extensions from the predefined lists.