#!/usr/bin/env bash
set -euo pipefail

packages=(
    1password-beta
    1password-cli
    aether
    cliamp
    kdenlive
    lazydocker
    libreoffice-fresh
    localsend
    obsidian
    pinta
    signal-desktop
    typora
    xournalpp
)

desktop_entries=(
    "$HOME/.local/share/applications/Basecamp.desktop"
    "$HOME/.local/share/applications/ChatGPT.desktop"
    "$HOME/.local/share/applications/Cliamp.desktop"
    "$HOME/.local/share/applications/Docker.desktop"
    "$HOME/.local/share/applications/Discord.desktop"
    "$HOME/.local/share/applications/Figma.desktop"
    "$HOME/.local/share/applications/GitHub.desktop"
    "$HOME/.local/share/applications/Google Contacts.desktop"
    "$HOME/.local/share/applications/Google Maps.desktop"
    "$HOME/.local/share/applications/Google Messages.desktop"
    "$HOME/.local/share/applications/Google Photos.desktop"
    "$HOME/.local/share/applications/HEY.desktop"
    "$HOME/.local/share/applications/WhatsApp.desktop"
    "$HOME/.local/share/applications/X.desktop"
)

sudo pacman -Rns "${packages[@]}"
rm -f "${desktop_entries[@]}"

mkdir -p ~/.local/bin
gh release download nightly --pattern 'expert_linux_amd64' --repo expert-lsp/expert --dir ~/.local/bin
chmod +x ~/.local/bin/expert_linux_amd64

install_packages=(
    "elixir"
    "erlang-public_key"
    "erlang-ssl"
    "shfmt"
    "jujutsu"
)
sudo pacman -S "${install_packages[@]}"
rm ~/.local/share/omarchy/default/hypr/bindings/tiling-v2.conf
