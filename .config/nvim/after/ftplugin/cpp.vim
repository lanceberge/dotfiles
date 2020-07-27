" Run Command --------------------  {{{
nnoremap <buffer> <silent> <leader>rn :call <SID>Compile()<cr>

" A function to run cpp scripts. Either shows the output, or 
" the error stack in a new buffer if it fails to compile
function! s:Compile()
    write
    let l:filename = expand('%:r') " the file name without the cpp extension
    " Save a newline separated list of the output of compiling the file with g++
    let l:output = split(system("g++ -o " . l:filename . " " . l:filename . '.cpp'), '\v\n')
    " if the g++ output length isn't 0, there's an error, so we
    " open a new buffer, set it to no filetype, and append the output
    if len(l:output) !=# 0
        silent edit output
        setlocal buftype=nofile
        nnoremap <buffer> q :bd<cr>
        call append(0, l:output)
        normal! gg
    else
        " run the file if there are no compiler errors
        execute '!./' . l:filename
    endif
endfunction
" }}}
" Snippets --------------------  {{{
inoremap <buffer> <A-k>iis #include <iostream><cr>
" }}}
