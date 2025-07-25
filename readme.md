# dotfiles

## Installation

Clone this repository:
```bash
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
```

Use make to install everything (recommended):
```bash
make install
```

Or install specific components:
```bash
# Install only configuration files
make install-conf

# Install only extensions
make install-ext
```

View available make commands:
```bash
make help
```

## Supported Applications

This dotfiles repository manages configurations for:

- **Vim** - `.vimrc` configuration
- **VSCode** - Settings and keybindings
- **Claude** - Settings and CLAUDE.md (custom instructions)
- **Zed** - Settings and keymap configuration