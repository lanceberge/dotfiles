#!/bin/bash

function +awk() {
    if [ $# -ne 1 ]; then
        echo "Usage: +awk <n>"
        return 1
    fi

    awk '{print $1}'
}

function vc_root_dir() {
    local dir="${1:-$PWD}"
    local root

    if command -v jj >/dev/null 2>&1; then
        root="$(jj root --ignore-working-copy --at-operation @ --repository "$dir" 2>/dev/null || true)"
        if [ -n "$root" ] && [ -d "$root" ]; then
            printf "%s\n" "$root"
            return 0
        fi
    fi

    if command -v git >/dev/null 2>&1; then
        root="$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null || true)"
        if [ -n "$root" ] && [ -d "$root" ]; then
            printf "%s\n" "$root"
            return 0
        fi
    fi

    return 1
}

function vc_list_files() {
    local args=()
    local arg

    if command -v jj >/dev/null 2>&1 && jj root --ignore-working-copy --at-operation @ >/dev/null 2>&1; then
        for arg in "$@"; do
            case "$arg" in
                --cached|--others|--exclude-standard) ;;
                *) args+=("$arg") ;;
            esac
        done

        jj file list --quiet "${args[@]}"
        return
    fi

    if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        git ls-files "$@"
        return
    fi

    return 1
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

function eff() {
    local file

    file=$(
        vc_list_files --cached --others --exclude-standard |
        fzf --exit-0 --preview 'bat --style=numbers --color=always {}'
    ) || return

    [[ -z "$file" ]] && return

    emacsclient -n "$file"
}

open() (
    if command -v xdg-open >/dev/null 2>&1; then
        xdg-open "$@" >/dev/null 2>&1 &
    elif command -v open >/dev/null 2>&1; then
        open "$@" >/dev/null 2>&1 &
    else
        printf 'No opener found\n' >&2
        return 1
    fi
)

sb() {
    if [ -n "$BASH_VERSION" ]; then
        source ~/.bashrc
    elif [ -n "$ZSH_VERSION" ]; then
        source ~/.zshrc
    fi
}

function paste() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        xclip -o | sed -e "s/$/\n/"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        pbpaste | sed -e "s/$/\n/"
    fi
}
