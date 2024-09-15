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
autoload edit-command-line
zle -N edit-command-line
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
# zstyle ':vcs_info:*' formats " %F{#fe8019}on %F{106}%b%F{#9d0006}[%u%c]"
# prompt='%F{#87afaf}%2~${vcs_info_msg_0_}%F{brightwhite} %b# '
zstyle ':vcs_info:*' formats " %F{208}on %F{106}%b%F{160}[%u%c]"
prompt='%F{109}%2~${vcs_info_msg_0_}%F{brightwhite} %b# '
PS2='> '

export ZSH="$HOME/.oh-my-zsh"

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    vi-mode
    git
)
source $ZSH/oh-my-zsh.sh

# bindkey '^J' autosuggest-accept
bindkey '^F' autosuggest-execute

# if [ -z "$TMUX" ]; then
#   # Start a new TMUX session named 'default' or attach to it if it already exists
#   tmux attach-session -t default || tmux new-session -s default
# fi

vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
}
setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
