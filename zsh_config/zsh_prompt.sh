#!/usr/bin/env bash

__omarchy_source_prompt_colors() {
    local colors_file="$HOME/.config/omarchy/current/theme/prompt-colors.sh"

    [ -f "$colors_file" ] && source "$colors_file"
}

__omarchy_register_prompt_shell() {
    local state_dir="${XDG_RUNTIME_DIR:-/tmp}/omarchy"
    local state_file="$state_dir/prompt-shells"

    mkdir -p "$state_dir"
    printf '%s\t%s\n' "$$" zsh >>"$state_file"
}

TRAPUSR1() {
    __omarchy_source_prompt_colors
    zle reset-prompt 2>/dev/null || true
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
        s="%F{${OMARCHY_PROMPT_ACCENT:-#e68e0d}}on %F{${OMARCHY_PROMPT_BRANCH:-#ffc107}}${bm}"
        [ "$count" -gt 0 ] && s="${s}+${count}"
    fi
    [ -n "$flags" ] && s="${s:+$s }%F{${OMARCHY_PROMPT_WARNING:-#d35f5f}}[${flags}]"
    [ -n "$s" ] && printf ' %s' "$s"
}

__omarchy_source_prompt_colors

if [[ -o interactive ]]; then
    __omarchy_register_prompt_shell
fi

setopt prompt_subst
prompt='$(__omarchy_source_prompt_colors)%F{${OMARCHY_PROMPT_ACCENT:-#e68e0d}}%2~$(prompt_jj)%F{${OMARCHY_PROMPT_FOREGROUND:-#bebebe}} %b# '
