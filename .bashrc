setxkbmap -layout us -option ctrl:swapcaps

if [[ -f /etc/bashrc && ! $BASH_SOURCED ]]; then
   . /etc/bashrc
fi

set -o vi # vim style keys

export PATH=~/.local/bin:$PATH
export XDG_CONFIG_HOME=~/dotfiles/.config
export EDITOR=vim

shopt -s autocd # change directory without typing cd
shopt -s histappend # append to history file

# source aliases, prompt, ...
for file in ~/dotfiles/.{aliases,prompt,local}; do
    [ -r "$file" ] && [ -f "$file" ] &&
        source "$file";
done;
unset file;

export HISTFILE=~/dotfiles/etc/.bash_history
export HISTSIZE=30000
export HISTFILESIZE=30000
bind -x $'"\C-l":clear;'

function vimf() {
    if [ "$#" -eq 1 ]; then
        $EDITOR $(find -name "$1")
    elif [ "$#" -eq 2 ]; then
        $EDITOR $(find "$1" -name "$2")
    else
        echo "Usage: vim_find [directory] <filename>"
    fi
}
