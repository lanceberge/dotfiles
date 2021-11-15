if [[ -f /etc/bashrc && ! $BASH_SOURCED ]]; then
   . /etc/bashrc
fi

set -o vi
shopt -s autocd # change directory without typing cd
shopt -s histappend # append to history file

for file in ~/dotfiles/.{aliases,prompt}; do
    [ -r "$file" ] && [ -f "$file" ] &&
        source "$file";
done;
unset file;

export HISTFILE=~/dotfiles/etc/.bash_history
bind -x $'"\C-l":clear;'
