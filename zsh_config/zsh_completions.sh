#!/usr/bin/env bash
# Tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # include dotfiles
compinit

source <(COMPLETE=zsh jj)

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

if command -v kubectl >/dev/null 2>&1; then
    source <(kubectl completion zsh)
    compdef k=kubectl

    _kx() {
        _set_kubeconfig || return
        compadd -- ${(f)"$(kubectl config get-contexts -o name 2>/dev/null)"}
    }
    compdef _kx kx

    _set_ns() {
        _set_kubeconfig || return
        compadd -- ${(f)"$(kubectl get namespaces --no-headers -o custom-columns=:metadata.name 2>/dev/null)"}
    }
    compdef _set_ns set_ns
fi

if command -v helm >/dev/null 2>&1; then
    source <(helm completion zsh)
fi
