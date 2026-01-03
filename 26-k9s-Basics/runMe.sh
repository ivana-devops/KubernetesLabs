#!/bin/bash

# K9s Installer and Launcher for Linux/macOS/Git Bash.

if ! command -v k9s &> /dev/null; then
    echo "K9s not found. Installing via webinstall.dev..."
    curl -sS https://webinstall.dev/k9s | bash
    # Source the new path if possible (webinstall usually adds to .bashrc)
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "Launching K9s..."
k9s

# --- Common Shortcuts (Cheat Sheet) ---
# :pods      - List all pods
# /          - Search/Filter
# d          - Describe
# l          - Logs
# s          - Shell
# ?          - Help
