set -o vi

for file in ~/dotfiles/.{aliases,prompt}; do
    [ -r "$file" ] && [ -f "$file" ] &&
        source "$file";
done;
unset file;
