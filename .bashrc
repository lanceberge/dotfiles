if [[ -f /etc/bashrc && ! $BASH_SOURCED ]]; then
   . /etc/bashrc
fi

set -o vi

for file in ~/dotfiles/.{aliases,prompt}; do
    [ -r "$file" ] && [ -f "$file" ] &&
        source "$file";
done;
unset file;
