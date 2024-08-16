#!/bin/bash

if [ "$#" -ne 1 ] || [ "$1" = "-h" ]; then
    echo "mv_screenshot <path to new file>"
    exit 0
fi

filename=$(basename "$1")
base_dir=$(dirname "$1")
mkdir -p "$base_dir"
screenshot=$(ls -t ~/Downloads | head -n 1 | sed 's/ /\\ /g')

cmd="mv ~/Downloads/$screenshot $base_dir/$filename"
echo $cmd
eval $cmd
