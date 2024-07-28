function fish_prompt
    set -g __fish_git_prompt_showupstream auto
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showcolorhints true
    printf '%s %s$ ' (prompt_pwd) (fish_git_prompt)
end

function fish_user_key_bindings
    fish_vi_key_bindings

    for mode in insert default visual
        bind -M $mode \ct accept-autosuggestion
        bind -M $mode \cf accept-autosuggestion execute
    end
end
