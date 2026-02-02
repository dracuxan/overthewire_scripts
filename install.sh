#!/bin/bash

# Install script for overthewire.sh

SCRIPT_NAME="otw.sh"
INSTALL_DIR="$HOME/.local/bin"
TARGET="$INSTALL_DIR/otw"

echo "Installing $SCRIPT_NAME..."

# Ensure the script is executable
chmod +x "$SCRIPT_NAME"

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Create symlink
ln -sf "$(pwd)/$SCRIPT_NAME" "$TARGET"

echo "Successfully installed to $TARGET"
echo "Ensure $INSTALL_DIR is in your PATH."
echo "You can now run 'otw' from anywhere."