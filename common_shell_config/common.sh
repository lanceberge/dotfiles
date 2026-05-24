#!/usr/bin/env bash

if [ -f "$HOME/.config/omarchy/current/theme/prompt-colors.sh" ]; then
    source "$HOME/.config/omarchy/current/theme/prompt-colors.sh"
fi

# a new shell gets history from all previous shells
PROMPT_COMMAND='history -a'
export HISTCONTROL=ignoredups:erasedups
