source <(COMPLETE=bash jj)
complete -o nospace -o bashdefault -o nosort -F _clap_complete_jj j

if command -v kubectl >/dev/null 2>&1; then
    _kx_completion() {
        [ "$COMP_CWORD" -eq 1 ] || return 0
        _set_kubeconfig || return
        local contexts
        contexts="$(kubectl config get-contexts -o name 2>/dev/null)" || return
        mapfile -t COMPREPLY < <(compgen -W "$contexts" -- "${COMP_WORDS[COMP_CWORD]}")
    }
    complete -F _kx_completion kx

    _set_ns_completion() {
        [ "$COMP_CWORD" -eq 1 ] || return 0
        _set_kubeconfig || return
        local namespaces
        namespaces="$(kubectl get namespaces --no-headers -o custom-columns=:metadata.name 2>/dev/null)" || return
        mapfile -t COMPREPLY < <(compgen -W "$namespaces" -- "${COMP_WORDS[COMP_CWORD]}")
    }
    complete -F _set_ns_completion set_ns
fi

if command -v helm >/dev/null 2>&2; then
    source <(helm completion bash)
fi
