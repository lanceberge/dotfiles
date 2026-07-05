Do not edit anything in ~/.local/share or ~/.config. Those directories include omarchy defaults that should not be touched

all changes, unless otherwise instructed, should be version-controlled in this repo. ./.config is the $XDG_CONFIG_HOME so use this for setting up tools that use it and update the .gitignore in ./.config.

If changes are needed in other directories, add symlinks and document them in the setup_omarchy.sh script. If this is done, don't run the setup_omarchy script but run the symlink commands manually instead
