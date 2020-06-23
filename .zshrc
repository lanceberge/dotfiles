# Aliases
source ~/dotfiles/.aliases

# Settings
setopt autocd

# Exports
export EDITOR="vim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export LANG=en_US.UTF-8
export VIMINIT="source ~/dotfiles/.vimrc"

# History
HISTSIZE=1000
SAVEHIST=1000

# Vi mode
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode # remap <esc>
bindkey -M viins 'kj' vi-cmd-mode # remap <esc>
export KEYTIMEOUT=20

# Edit line in vim with C-f
autoload edit-command-line; zle -N edit-command-line
bindkey '^f' edit-command-line

# Tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include dotfiles

# Vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M viins '^?' backward-delete-char

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
prompt='%F{cyan} %~${vcs_info_msg_0_}%F{white} # '
PS2='> '

# Start x at login
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# Vi mode indicator
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
