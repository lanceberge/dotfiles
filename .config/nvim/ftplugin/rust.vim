" Snippets --------------------  {{{
inoremap <buffer> <silent> <A-k>main fn main() {<cr>}<esc>O
inoremap <buffer> <silent> <A-k>print println!("");<esc>F"i
inoremap <buffer> <silent> <A-k>fn fn  ([!]) {<cr>[!]<cr>}[!]<esc>2kha
inoremap <buffer> <silent> <A-k>fN fn  ([!]) -> [!] {<cr>[!]<cr>}[!]<esc>2kha
inoremap <buffer> <silent> <A-k>us [!]<esc>O;<esc>iuse std::
inoremap <buffer> <silent> <A-k>ife if  {<cr>[!]<cr>}<cr>else {<cr>[!]<cr>}[!]<esc>5kha
inoremap <buffer> <silent> <A-k>elif else if  {<cr>[!]<cr>}<esc>2kwela
inoremap <buffer> <silent> <A-k>iff <esc>:read $VIM_SNIPPETS_DIR/rust/iff<cr>kddela
" }}}
" Mappings --------------------  {{{
nnoremap <buffer> <silent> <leader>rb :!cargo build<cr>
nnoremap <buffer> <silent> <leader>rB :!cargo build -release<cr>
nnoremap <buffer> <silent> <leader>rc :!cargo check<cr>
nnoremap <buffer> <silent> <leader>rn :!cargo run<cr>
" run the machine code file
nnoremap <buffer> <silent> <leader>rN :execute '!./' . expand('%:r')<cr>
nnoremap <buffer> <silent> <leader>rC :!rustc %<cr>
" }}}
