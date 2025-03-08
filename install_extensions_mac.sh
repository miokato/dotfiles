#!/bin/sh

# Install VSCode extensions
echo "Installing VSCode extensions..."
cat ./vscode/extensions.txt | while read line
do
  code --install-extension "$line"
done

# Install Windsurf extensions
echo "Installing Windsurf extensions..."
cat ./windsurf/extensions.txt | while read line
do
  windsurf --install-extension "$line"
done

echo "All extensions have been installed!"
