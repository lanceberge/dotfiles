setlocal foldmethod=marker
setlocal foldenable

augroup auto_source " automatically source all vim files on write
    autocmd! BufWritePost <buffer>
    autocmd BufWritePost <buffer> source %
augroup END
