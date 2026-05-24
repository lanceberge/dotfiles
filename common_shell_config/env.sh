#!/usr/bin/env bash
export XDG_CONFIG_HOME=~/dotfiles/.config
export CODEX_HOME="$XDG_CONFIG_HOME/codex"
export LANG=en_US.UTF-8
export EDITOR="emacsclient -t"
export FZF_DEFAULT_OPTS="--bind 'ctrl-k:kill-line'"
export LESS='-R' # preserves colors in inputs

# history
export HISTSIZE=100000
export HISTFILESIZE=100000

if [ -f $HOME/secrets/claude_key ]; then
    export ANTHROPIC_API_KEY=$(cat ~/secrets/claude_key | base64 -d)
fi

# bun
export BUN_INSTALL="$HOME/.bun"

if [ -f $HOME/secrets/gh_token ]; then
    export GH_TOKEN=$(cat ~/secrets/gh_token)
fi
export PS2='> '
