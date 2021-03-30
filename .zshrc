# Aliases
source ~/dotfiles/.aliases

# Settings
setopt autocd

# Exports
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export LANG=en_US.UTF-8
export XDG_CONFIG_HOME=~/dotfiles/.config
# export PATH=$PATH:~/.local/bin/:/usr/local/MATLAB/R2020b/bin:.

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/dotfiles/etc/.zsh_history

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

# Start x at login
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
      exec startx ~/dotfiles/.xinitrc
fi

# Load zsh-syntax-highlighting; should be last.
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# List files every time you change directory
function chpwd {
    ls -AF
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lance/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lance/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lance/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lance/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
