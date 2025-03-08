# List all available make targets
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  install       - Set up complete development environment (configs + extensions)"
	@echo "  install-conf  - Install configuration files only"
	@echo "  install-ext   - Install VSCode and Windsurf extensions only"
	@echo "  list-ext      - List currently installed VSCode extensions"
	@echo "  list-windsurf - List currently installed Windsurf extensions"

# Default target
.DEFAULT_GOAL := help

# Install everything (configurations and extensions)
.PHONY: install
install: install-conf install-ext

# Install configuration files only
.PHONY: install-conf
install-conf:
	@echo "Installing configuration files..."
	@sh install_mac.sh

# Install extensions only
.PHONY: install-ext
install-ext:
	@echo "Installing extensions..."
	@sh install_extensions_mac.sh

# List currently installed VSCode extensions
.PHONY: list-ext
list-ext:
	@code --list-extensions

# List currently installed Windsurf extensions
.PHONY: list-windsurf
list-windsurf:
	@windsurf --list-extensions
