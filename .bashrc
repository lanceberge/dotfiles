set -o vi

for file in ~/dotfiles/.{aliases,prompt,bashrc};do
    [ -r "$file" ] && [ -f "$file" ] &&
        source "$file";
done;
unset file;
