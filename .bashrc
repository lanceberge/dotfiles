# source aliases, prompt, ...
for file in ~/dotfiles/.{aliases,bash_prompt,local,sharedrc}; do
    [ -r "$file" ] && [ -f "$file" ] &&
        source "$file"
done
unset file

shopt -s autocd     # change directory without typing cd
shopt -s histappend # append to history file
set -o vi           # vim style keys
bind -x $'"\C-l":clear;'

eval "$(fzf --bash)"
