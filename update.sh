#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$HOME/Repos/vsConfig"
VSCODE_DIR="$HOME/.config/Code/User"
TS="$(date +%Y-%m-%d_%H-%M-%S)"

cd "$REPO_DIR"

cp -v "$VSCODE_DIR/settings.json" "settings.json" 2>/dev/null || true
cp -v "$VSCODE_DIR/keybindings.json" "keybindings.json" 2>/dev/null || true
code --list-extensions > extensions.txt

mkdir -p backups
cp -v settings.json "backups/settings.json.$TS.bak" 2>/dev/null || true
cp -v keybindings.json "backups/keybindings.json.$TS.bak" 2>/dev/null || true
cp -v extensions.txt "backups/extensions.txt.$TS.bak" 2>/dev/null || true

git add .
git commit -m "Update VS Code config ($TS)" || echo "No changes to commit"
git push

echo "Done: pushed latest VS Code config"
