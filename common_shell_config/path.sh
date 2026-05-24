#!/usr/bin/env bash

path_dirs=(
    "${XDG_CONFIG_HOME:-$HOME/.config}/composer/vendor/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/dotfiles/bin"
    "$HOME/.cargo/bin"
    "${BUN_INSTALL:+$BUN_INSTALL/bin}"
    "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
)

for dir in "${path_dirs[@]}"; do
    [ -d "$dir" ] && export PATH="$dir:$PATH"
done
unset dir path_dirs

if [ -d ~/code/scripts ]; then
    for dir in ~/code/scripts/*/; do
        [ -d "$dir" ] && export PATH="$dir":"$PATH"
    done
fi
