#!/usr/bin/env bash
set -euo pipefail

if ! command -v pi >/dev/null 2>&1; then
	echo "pi is not installed or is not available on PATH" >&2
	exit 1
fi

# Install globally so these extensions are available in every Pi project.
pi install npm:pi-web-access
pi install npm:@juicesharp/rpiv-ask-user-question
pi install npm:pi-mono-context-guard
pi install npm:@ayulab/pi-rewind
pi install npm:pi-mono-multi-edit

# This checkout carries local Elixir filetype support for Expert.
adapter_dir="$HOME/code/pi-extensions"
if [[ ! -d "$adapter_dir" ]]; then
	echo "Clone pi-lsp-adapter into $adapter_dir before running this script" >&2
	exit 1
fi

npm install --prefix "$adapter_dir"
pi remove npm:pi-lsp-adapter 2>/dev/null || true
pi install "$adapter_dir"

mkdir -p "$HOME/.pi/agent"
ln -sfnT "$HOME/dotfiles/.config/pi/agent/lsp.json" "$HOME/.pi/agent/lsp.json"
ln -sfnT "$HOME/dotfiles/.config/pi/agent/settings.json" "$HOME/.pi/agent/settings.json"
