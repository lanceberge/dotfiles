#!/usr/bin/env bash
# Tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # include dotfiles
compinit

source <(COMPLETE=zsh jj)
