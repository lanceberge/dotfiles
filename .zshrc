# [[ -o interactive ]] || return
# [[ -t 0 && -t 1 ]] || return

for file in "$HOME"/dotfiles/common_shell_config/*.sh "$HOME"/dotfiles/zsh_config/*.sh; do
    [ -f "$file" ] && source "$file"
done

# Settings
setopt autocd # change dir without typing cd
setopt PROMPT_SUBST

# History
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
export HISTFILE=~/.zsh_history

DISABLE_AUTOUPDATE=false

export KEYTIMEOUT=20

bindkey -e # emacs keys

autoload edit-command-line
zle -N edit-command-line
bindkey '^[v' edit-command-line # M-v
bindkey '^R' history-incremental-search-backward

# Prompt
export TERM=xterm-256color

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

bindkey '^[^M' autosuggest-execute
bindkey '^W' kill-region

source <(fzf --zsh)
