#!/bin/sh

# Check if code command exists
if command -v code >/dev/null 2>&1; then
    echo "Installing VSCode extensions..."
    cat ./vscode/extensions.txt | while read line
    do
      code --install-extension "$line"
    done
else
    echo "Warning: 'code' command not found. Please install it via VSCode:"
    echo "1. Open VSCode"
    echo "2. Press Cmd+Shift+P"
    echo "3. Run 'Shell Command: Install code command in PATH'"
fi

echo "Extension installation process completed!"
