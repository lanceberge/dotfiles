for file in "$HOME"/dotfiles/common_shell_config/*.sh "$HOME"/dotfiles/bash_config/*.sh; do
    [ -f "$file" ] && source "$file"
done

shopt -s autocd # change directory without typing cd
shopt -s histappend # append to history file
bind -x $'"\C-l":clear;'
export HISTFILE=~/.bash_history
eval "$(fzf --bash)"

function cd {
    builtin cd "$@" && ls -F --color=tty
}
