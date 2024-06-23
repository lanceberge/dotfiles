# source files
for file in ~/dotfiles/.{aliases,local_aliases,local}; do
    [ -r "$file" ] && [ -f "$file" ] &&
        source "$file";
done;
unset file;

# Settings
setopt autocd # change dir without typing cd

# List files every time you change directory
function chpwd {
    ls -F
}

# Exports
export EDITOR="vim"
export LANG=en_US.UTF-8
export XDG_CONFIG_HOME=~/dotfiles/.config

# Path
if [ -d ~/code/scripts ]; then
    for file in ~/code/scripts/*/; do
        if [ -d "$file" ]; then
            export PATH="$PATH":"$file"
        fi
    done
    unset file
fi

# History
unsetopt EXTENDED_HISTORY
setopt SHARE_HISTORY
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

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
