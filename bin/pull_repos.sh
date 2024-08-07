#!/bin/bash

for dir in ~/{dotfiles,.emacs.d,org,org-roam}; do
    if [ -d "$dir" ]; then
        echo "Pulling $dir"
        git -C "$dir" pull
    fi
done
