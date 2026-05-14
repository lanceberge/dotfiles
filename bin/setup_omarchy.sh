#!/usr/bin/env bash
set -euo pipefail

uninstall_packages=(
    1password-beta
    1password-cli
    aether
    cliamp
    kdenlive
    lazydocker
    lazygit
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

sudo pacman -Rns "${uninstall_packages[@]}"
rm -f "${desktop_entries[@]}"

mkdir -p ~/.local/bin
gh release download nightly --pattern 'expert_linux_amd64' --repo expert-lsp/expert --dir ~/.local/bin
chmod +x ~/.local/bin/expert_linux_amd64

install_packages=(
    "bun"
    "elixir"
    "erlang-public_key"
    "erlang-ssl"
    "extra/bash-language-server"
    "inotify-tools"
    "postgresql"
    "shfmt"
    "jujutsu"
)
sudo pacman -S "${install_packages[@]}"
rm ~/.local/share/omarchy/default/hypr/bindings/tiling-v2.conf

aur_install_packages=(
    "watchman-bin"
)

yay -S "${aur_install_packages[@]}"

# setup postgres
sudo -iu postgres initdb -D /var/lib/postgres/data
sudo systemctl enable --now postgresql
sudo -iu postgres createuser --superuser lance

mkdir -p "$HOME/.local/share/themes"
ln -sfn "$HOME/dotfiles/.config/gtk-key-themes/EmacsNoCtrlW" "$HOME/.local/share/themes/EmacsNoCtrlW"
gsettings set org.gnome.desktop.interface gtk-key-theme 'EmacsNoCtrlW'

mkdir -p "$HOME/.config/omarchy/hooks"
ln -sfn "$HOME/dotfiles/.config/omarchy/hooks/theme-set" "$HOME/.config/omarchy/hooks/theme-set"

mkdir -p "$HOME/.config/omarchy/themed"
ln -sfn "$HOME/dotfiles/.config/omarchy/themed/prompt-colors.sh.tpl" "$HOME/.config/omarchy/themed/prompt-colors.sh.tpl"

mkdir -p "$HOME/.config/omarchy/themes"
ln -sfn "$HOME/dotfiles/.config/omarchy/themes/matte-black" "$HOME/.config/omarchy/themes/matte-black"

mkdir -p "$HOME/.local/state/omarchy/toggles"
touch "$HOME/.local/state/omarchy/toggles/screensaver-off"
