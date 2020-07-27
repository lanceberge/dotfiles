" Snippets {{{
" Miscellaneous
inoremap <buffer> <silent> <A-k>print println!("");<esc>F"i
inoremap <buffer> <silent> <A-k>str; String::from("")<esc>F"ci"
inoremap <buffer> <silent> <A-k>struct struct  {<cr>[!]<cr>}[!]<esc>2k0ela
inoremap <buffer> <silent> <A-k>enum enum  {<cr>[!]<cr>}[!]<esc>2k0ela

" Use statements
inoremap <buffer> <silent> <A-k>us [!]<esc>O;<esc>iuse std::

" Functions/Methods
inoremap <buffer> <silent> <A-k>fn fn ([!]) {<cr>[!]<cr>}[!]<esc>2k0ela
inoremap <buffer> <silent> <A-k>fN fn ([!]) -> [!] {<cr>[!]<cr>}[!]<esc>2k0ela
inoremap <buffer> <silent> <A-k>main fn main() {<cr>}[!]<esc>O
inoremap <buffer> <silent> <A-k>impl impl  {<cr>[!]<cr>}[!]<esc>3k0ela

" Control Flow
inoremap <buffer> <silent> <A-k>if; if  {<cr>[!]<cr>}[!]<esc>2k0ela
inoremap <buffer> <silent> <A-k>ife if  {<cr>[!]<cr>}<cr>else {<cr>[!]<cr>}[!]<esc>5kha
inoremap <buffer> <silent> <A-k>elif else if  {<cr>[!]<cr>}[!]<esc>2kwela
inoremap <buffer> <silent> <A-k>iff <esc>:read $VIM_SNIP_DIR/rust/iff<cr>kdd9==ela
inoremap <buffer> <silent> <A-k>while while  {<cr>[!]<cr>}[!]<esc>2k0ela
inoremap <buffer> <silent> <A-k>for for  in [!] {<cr>[!]<cr>}[!]<esc>2k0ela

" Annotations
inoremap <buffer> <silent> <A-k>adc #![allow(dead_code)]
inoremap <buffer> <silent> <A-k>auv #![allow(unused_variables)]
inoremap <buffer> <silent> <A-k>drv #[derive()]<esc>F(ci(
" }}}
" Mappings {{{
nnoremap <buffer> <silent> <leader>rb :w <bar> !cargo build<cr>
nnoremap <buffer> <silent> <leader>rB :w <bar> !cargo build -release<cr>
nnoremap <buffer> <silent> <leader>rc :w <bar> !cargo check<cr>
nnoremap <buffer> <silent> <leader>rn :w <bar> !cargo run<cr>
" run the machine code file
nnoremap <buffer> <silent> <leader>rN :w <bar> execute '!./' . expand('%:r')<cr>
nnoremap <buffer> <silent> <leader>rC :w <bar> !rustc %<cr>
" }}}
