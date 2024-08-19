#!/bin/bash

for dir in ~/{.emacs.d,org,org-roam,org-roam/public}; do
    if [ -d "$dir" ]; then
        echo "Pulling $dir"
        git -C "$dir" pull
    fi
done

git -C ~/dotfiles fetch origin
git -C ~/dotfiles merge origin/main
