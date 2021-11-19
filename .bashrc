if [[ -f /etc/bashrc && ! $BASH_SOURCED ]]; then
   . /etc/bashrc
fi

set -o vi
<<<<<<< HEAD
export XDG_CONFIG_HOME=~/dotfiles/.config
=======
shopt -s autocd # change directory without typing cd
shopt -s histappend # append to history file
>>>>>>> 0988d02208fe075f460f780fa3fe54475f0d94de

for file in ~/dotfiles/.{aliases,prompt,local_aliases}; do
    [ -r "$file" ] && [ -f "$file" ] &&
        source "$file";
done;
unset file;

export HISTFILE=~/dotfiles/etc/.bash_history
bind -x $'"\C-l":clear;'
