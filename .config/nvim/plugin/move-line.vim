nnoremap <script> <silent>[e :<c-u>call <SID>MoveLineUp(v:count1)<cr>
nnoremap <script> <silent> ]e :<c-u>call <SID>MoveLineDown(v:count1)<cr>

function! s:MoveLineUp(count)
    for i in range(a:count)
        if line('.') ==# line('$')
            normal! ddP
        elseif line('.') !=# 1
            normal! ddkP
        else
            break
        endif
    endfor
endfunction

function! s:MoveLineDown(count)
    for i in range(a:count)
        if line('.') !=# line('$')
            normal! ddp
        else
            break
        endif
    endfor
endfunction
