#!/usr/bin/env bash

__prompt_color() {
    local hex="${1#\#}"
    printf '\001\033[38;2;%d;%d;%dm\002' \
        "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

__prompt_pwd() {
    local path="${PWD/#$HOME/~}"
    local home_path

    if [[ "$path" == /home/* ]]; then
        home_path="${path#/home/}"
        if [[ "$home_path" == */* ]]; then
            path="~/${home_path#*/}"
        else
            path="~"
        fi
    fi

    if [[ "$path" == "~" || "$path" != */*/* ]]; then
        printf '%s' "$path"
    else
        printf '%s' "${path%/*/*}/${path##*/}"
    fi
}

prompt_jj() {
    command -v jj >/dev/null 2>&1 || return
    jj root --ignore-working-copy >/dev/null 2>&1 || return

    local raw bm_id bm
    raw=$(jj log --ignore-working-copy --no-graph --limit 1 \
        -r 'heads(::@ & bookmarks())' \
        -T 'change_id.short() ++ "\t" ++ bookmarks.map(|b| b.name()).join(",")' 2>/dev/null)
    bm_id="${raw%%	*}"
    bm="${raw#*	}"

    local count flags
    count=$(jj log --ignore-working-copy --no-graph \
        -r "${bm_id:-trunk()}..@" \
        -T '"x\n"' 2>/dev/null | grep -c .)
    flags=$(jj log --ignore-working-copy --no-graph -r @ \
        -T 'if(empty, "", "+") ++ if(conflict, "!", "")' 2>/dev/null)

    local s=""
    if [ -n "$bm" ]; then
        s="$(__prompt_color "${OMARCHY_PROMPT_ACCENT:-#e68e0d}")on $(__prompt_color "${OMARCHY_PROMPT_BRANCH:-#ffc107}")${bm}"
        [ "$count" -gt 0 ] && s="${s}+${count}"
    fi
    [ -n "$flags" ] && s="${s:+$s }$(__prompt_color "${OMARCHY_PROMPT_WARNING:-#d35f5f}")[${flags}]"
    [ -n "$s" ] && printf ' %s' "$s"
}

PS1='$(__prompt_color "${OMARCHY_PROMPT_ACCENT:-#e68e0d}")$(__prompt_pwd)$(prompt_jj)$(__prompt_color "${OMARCHY_PROMPT_FOREGROUND:-#bebebe}") # \[\033[0m\]'
