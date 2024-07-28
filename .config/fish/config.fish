function fish_user_key_bindings
    fish_vi_key_bindings

    for mode in insert default visual
        bind -M $mode \ct accept-autosuggestion
        bind -M $mode \cf accept-autosuggestion execute
    end
end

source ~/dotfiles/.aliases
set -q LS_AFTER_CD || set -xg LS_AFTER_CD true

# show directory listing on directory change
function __ls_after_cd__on_variable_pwd --on-variable PWD
    if test "$LS_AFTER_CD" = true; and status --is-interactive
        ls -GF
    end
end

function fish_prompt
    set -g __fish_git_prompt_showupstream auto
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showcolorhints true
    printf '%s %s$ ' (prompt_pwd) (fish_git_prompt)
end

bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"

set -gx PATH /opt/homebrew/bin $PATH
