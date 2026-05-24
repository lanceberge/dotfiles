#!/bin/bash

function +awk() {
    if [ $# -ne 1 ]; then
        echo "Usage: +awk <n>"
        return 1
    fi

    awk '{print $1}'
}

function root() {
    git rev-parse --show-toplevel
}

function e() {
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <filename>"
        exit 1
    fi

    if command -v emacsclient >/dev/null 2>&1; then
        emacsclient -n "$1"
    fi
}
