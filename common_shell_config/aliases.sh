#!/usr/bin/env bash

#--------------------Aliases--------------------
alias v='nvim'
alias jn="jupyter notebook --ip='*' --NotebookApp.token='' --NotebookApp.password=''"
alias jl="jupyter lab"
alias j='jj'

# Navigation
alias cd_df='cd ~/dotfiles'
alias cdr='cd $(project_root)' # cd to the jj/git root

alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

alias gha='unset GH_TOKEN && cat ~/secrets/gh_token | base64 -d | gh auth login --with-token'

# Listing Files
alias ls='ls -F'
alias ll='ls -lF'
alias lsa='ls -aF'
alias la='ls -lAF'
alias lsd="ls -lF| grep --color=never '^d'"

alias ff='vc_list_files | fzf --preview "bat --style=numbers --color=always {}"'

if command -v eza >/dev/null 2>&1; then
    alias ls="eza --color=always"
    alias lt='eza --color=always --tree --level=2 --long --icons --git'
fi

# Docker
alias dps='docker ps'
alias dil='docker image list'
alias dlps='docker ps -a'
alias drun='docker run'
alias drit='docker run -it'
alias drrm='docker run --rm'
alias dex='docker exec -it'
alias dimg='docker images'
alias dsp='docker system prune'
alias dkill='docker kill'
alias dstop='docker stop'
alias drm='docker rm'
alias drmi='docker rmi'
alias dins='docker inspect'
alias dll='docker logs $(docker ps -l -q)' # last docker logs

# Kubernetes
alias k='kubectl'
alias kqa='kc delete all --all -n $(whoami)'

#Maven
alias mcs='mvn clean install -DskipTests'
alias mci='mvn clean install'

alias hse='helmfile sync -e'
alias hde='helmfile destroy -e'

alias nrs='sudo nixos-rebuild switch --flake ~/.config/nixos'
alias hrs='home-manager switch --flake ~/.config/nixos#lance'

alias et='emacs -nw -q -l $HOME/dotfiles/.emacs'
