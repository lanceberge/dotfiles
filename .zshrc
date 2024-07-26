if [ -f ~/dotfiles/.sharedrc ]; then
    source ~/dotfiles/.sharedrc
fi

# Settings
setopt autocd # change dir without typing cd

# History
unsetopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# Vi mode
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode # remap <esc>
export KEYTIMEOUT=20

# Edit line in vim with C-f
autoload edit-command-line; zle -N edit-command-line
bindkey '^f' edit-command-line

# Tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # include dotfiles

# Vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M viins '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward

# Prompt
export TERM=xterm-256color

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd() {
    vcs_info
}
setopt prompt_subst
zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' formats " %F{108}on %F{208}%b%F{124}[%u%c]"
# prompt='%F{106} %~${vcs_info_msg_0_}%F{white} # '
zstyle ':vcs_info:*' formats " %F{green}on %F{yellow}%b%F{red}[%u%c]"
prompt='%B%F{cyan}%2~${vcs_info_msg_0_}%F{brightwhite} %b# '
PS2='> '
