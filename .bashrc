if [[ -f /etc/bashrc && ! $BASH_SOURCED ]]; then
   . /etc/bashrc
fi

set -o vi
export XDG_CONFIG_HOME=~/dotfiles/.config

for file in ~/dotfiles/.{aliases,prompt,local_aliases}; do
    [ -r "$file" ] && [ -f "$file" ] &&
        source "$file";
done;
unset file;

export HISTFILE=~/dotfiles/etc/.bash_history
