" nnoremap gr :set operatorfunc=<SID>GrepOperator<cr>g@
" vnoremap gr :<c-u>call <SID>GrepOperator(visualmode())<cr>

" function! s:GrepOperator(type)
"     let saved_unnamed_register = @@

"     if a:type ==# 'v'
"         normal! `<v`>y
"     elseif a:type ==# 'char'
"         normal! `[y`]
"     else
"         return
"     endif

"     silent execute "grep! -R " . shellescape(@@) . " ."
"     redr!
"     copen

"     let @@ = saved_unnamed_register
" endfunction
