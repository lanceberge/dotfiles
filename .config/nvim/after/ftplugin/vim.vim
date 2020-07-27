" Settings {{{
setlocal foldmethod=marker
setlocal foldenable
" }}}
" Remaps {{{
" add fold markers below cursor
nnoremap <buffer> yf o" }}}<esc>O"<esc>A {{{<esc>F"a<space>
" add fold markers above cursor
nnoremap <buffer> yF O" }}}<esc>O"<esc>A {{{<esc>F"a<space>
" }}}
" Autocommands {{{
augroup auto_source " automatically source all vim files on write
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> source %
augroup END
" }}}
" Snippets {{{
inoremap <buffer> <silent> <A-k>func function!<cr>endfunction<esc>kA<space>
inoremap <buffer> <silent> <A-k>snip inoremap <buffer> <silent> <A- <bs>k>
inoremap <buffer> <silent> <A-k>bs <space><buffer> <silent><space>
" }}}
