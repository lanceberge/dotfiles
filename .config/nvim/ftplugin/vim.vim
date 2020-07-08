setlocal foldmethod=marker
setlocal foldenable

" add fold markers below cursor
nnoremap <buffer> yf o" }}}<esc>O"  <esc>20i-<esc>A {{{<esc>F"a<space>
" add fold markers above cursor
nnoremap <buffer> yF O" }}}<esc>O"  <esc>20i-<esc>A {{{<esc>F"a<space>
" add fold markers around a body of text
nnoremap <buffer> ysf }O" }}}<esc>{o"  <esc>20i-<esc>A {{{<esc>F"a<space>

augroup auto_source " automatically source all vim files on write
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> source %
augroup END

" Snippets
inoremap <buffer> <c-s>func function!<cr>endfunction<esc>kA<space>
