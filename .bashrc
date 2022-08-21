if [[ -f /etc/bashrc && ! $BASH_SOURCED ]]; then
   . /etc/bashrc
fi

set -o vi # vim style keys

export PATH=$PATH:~/.local/bin
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
bind -x $'"\C-l":clear;'
