if [ -f ~/dotfiles/.sharedrc ]; then
    source ~/dotfiles/.sharedrc
fi
# Settings
setopt autocd # change dir without typing cd
export XDG_CONFIG_HOME=$HOME/dotfiles/.config

# History
unsetopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

DISABLE_AUTOUPDATE=false

# Vi mode
# bindkey -v
# bindkey -M viins 'jk' vi-cmd-mode # remap <esc>
export KEYTIMEOUT=20

bindkey -e

autoload edit-command-line
zle -N edit-command-line
bindkey '^[v' edit-command-line

# Tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # include dotfiles
compinit
source <(jj util completion zsh)

# Vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M viins '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward

# Prompt
export TERM=xterm-256color

setopt prompt_subst
prompt='%F{${OMARCHY_PROMPT_ACCENT:-#e68e0d}}%2~$(prompt_jj)%F{${OMARCHY_PROMPT_FOREGROUND:-#bebebe}} %b# '
PS2='> '

if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
    export ZSH="$HOME/.oh-my-zsh"

    plugins=(
        zsh-autosuggestions
        zsh-syntax-highlighting
    )

    source "$ZSH/oh-my-zsh.sh"
else
    for file in \
        /usr/share/zsh/plugins/zsh-autosuggestions/*.zsh \
        /usr/share/zsh/plugins/zsh-syntax-highlighting/*.zsh
    do
        [ -f "$file" ] && source "$file"
    done
fi

# bindkey '^K' autosuggest-accept
# bindkey '^F' autosuggest-execute
bindkey '^[^M' autosuggest-execute
bindkey '^W' kill-region

# emacs stuff
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

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
fi

# Set up autocompletions
# complete -C aws_completer aws

# PHP
export PATH="/Users/lance/.config/herd-lite/bin:$PATH"
export PATH="$XDG_CONFIG_HOME/composer/vendor/bin:$PATH"
export PATH="$XDG_CONFIG_HOME/composer/vendor/bin:$PATH"

if [ -f $HOME/secrets/claude_key ]; then
    export ANTHROPIC_API_KEY=$(cat ~/secrets/claude_key | base64 -d)
fi

source <(fzf --zsh)

# bindkey -s ^a "tmux-sessionizer\n"

# bun completions
[ -s "/Users/lance/.oh-my-zsh/completions/_bun" ] && source "/Users/lance/.oh-my-zsh/completions/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# opencode
export PATH=/Users/lance/.opencode/bin:$PATH
