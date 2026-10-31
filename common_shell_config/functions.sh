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
        root="$(jj workspace root || true)"
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
            --cached | --others | --exclude-standard) ;;
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
        command open "$@" >/dev/null 2>&1 &
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
    if command -v pbpaste >/dev/null; then
        pbpaste | sed -e "s/$/\n/"
    elif command -v wl-paste >/dev/null; then
        wl-paste | sed -e "s/$/\n/"
    elif command -v xclip >/dev/null; then
        xclip -selection clipboard -o | sed -e "s/$/\n/"
    elif command -v xsel >/dev/null; then
        xsel --clipboard --output | sed -e "s/$/\n/"
    else
        printf 'paste: no clipboard command found\n' >&2
        return 1
    fi
}

function copy() {
    if command -v pbcopy >/dev/null; then
        pbcopy
    elif command -v wl-copy >/dev/null; then
        wl-copy
    elif command -v xclip >/dev/null; then
        xclip -selection clipboard
    elif command -v xsel >/dev/null; then
        xsel --clipboard --input
    else
        printf 'copy: no clipboard command found\n' >&2
        return 1
    fi
}

## Kubernetes
function _set_kubeconfig() {
    [ -d "$HOME/.kube" ] || return 0
    local configs
    configs="$(find "$HOME/.kube" -type f -print -maxdepth 1 | command paste -sd ':' -)" || return
    if [ -n "$configs" ]; then
        export KUBECONFIG="$configs"
    fi
}
function kd() {
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        printf 'Usage: kd <kubernetes resource> [filter]\n' >&2
        return 2
    fi

    local names
    names="$(kubectl get "$1" -o name)" || return

    if [ "$#" -eq 2 ]; then
        names="$(printf '%s\n' "$names" | grep -E -- "$2")" || {
            [ "$?" -eq 1 ] && return 0
            return 2
        }
    fi

    [ -n "$names" ] || return 0
    printf '%s\n' "$names" | xargs -r kubectl delete
}

# Set REPLY to a selected name from a newline-separated list. A missing choice
# lists the available names and reads a name or number from stdin.
function _read_numbered_result() {
    local results="$1" label="$2" command_name="$3" choice number
    REPLY=

    if [ "$#" -eq 3 ]; then
        [ -n "$results" ] || {
            printf '%s: no %s available\n' "$command_name" "$label" >&2
            return 1
        }
        printf '%s\n' "$results" | awk '{printf "%d. %s\n", NR, $0}'
        [ -t 0 ] && printf '%s: ' "$label" >&2
        read -r choice || [ -n "$choice" ] || return 0
    else
        choice="$4"
    fi

    [ -n "$choice" ] || return 0
    if [[ "$choice" =~ ^[0-9]+$ ]]; then
        number="$choice"
        choice="$(printf '%s\n' "$results" | awk -v number="$number" 'NR == number {print; exit}')"
        if [ -z "$choice" ]; then
            printf '%s: no %s numbered %s\n' "$command_name" "$label" "$number" >&2
            return 1
        fi
    fi
    REPLY="$choice"
}

# With no argument, list contexts and read a name or number from stdin.
function kx() {
    [ "$#" -le 1 ] || {
        printf 'Usage: kx [context]\n' >&2
        return 2
    }
    _set_kubeconfig || return
    local contexts REPLY
    contexts="$(kubectl config get-contexts -o name)" || return
    _read_numbered_result "$contexts" context kx "$@" || return
    [ -n "$REPLY" ] || return 0
    kubectl config use-context "$REPLY"
}

# similar interface to kx but for setting the current namespace
function set_ns() {
    [ "$#" -le 1 ] || {
        printf 'Usage: set_ns [namespace]\n' >&2
        return 2
    }
    _set_kubeconfig || return
    local namespaces REPLY
    namespaces="$(kubectl get namespaces --no-headers -o custom-columns=:metadata.name)" || return
    _read_numbered_result "$namespaces" namespace set_ns "$@" || return
    [ -n "$REPLY" ] || return 0
    kubectl config set-context --current --namespace="$REPLY"
}
