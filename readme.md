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

### Installation
```bash
# Clone this repository
git clone <repository-url> ~/dotfiles

# Run the Windsurf setup script
cd ~/dotfiles/windsurf
./setup.sh
```

The setup script will:
1. Create the Windsurf config directory if it doesn't exist
2. Copy the configuration files to `~/.config/windsurf/`
3. Set appropriate file permissions