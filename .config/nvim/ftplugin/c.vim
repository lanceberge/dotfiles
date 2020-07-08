" TODO Put anything for just c and not cpp in nvim/after/ftplugin/c
" because cpp files source the c ftplugin

" Snippets
inoremap <buffer> <c-s>for for (int i = 1; i < z; i++) {<cr>}<esc>O <bs><esc>k:s/ i/ 
inoremap <buffer> <c-s>main int main()<cr>{<cr>[!]<cr>}<cr>[!]<esc>4k/(<cr>ci(
