#!/usr/bin/env bash

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
        s="%F{${OMARCHY_PROMPT_ACCENT:-#e68e0d}}on %F{${OMARCHY_PROMPT_BRANCH:-#ffc107}}${bm}"
        [ "$count" -gt 0 ] && s="${s}+${count}"
    fi
    [ -n "$flags" ] && s="${s:+$s }%F{${OMARCHY_PROMPT_WARNING:-#d35f5f}}[${flags}]"
    [ -n "$s" ] && printf ' %s' "$s"
}

setopt prompt_subst
prompt='%F{${OMARCHY_PROMPT_ACCENT:-#e68e0d}}%2~$(prompt_jj)%F{${OMARCHY_PROMPT_FOREGROUND:-#bebebe}} %b# '
