"--------------------General Settings--------------------" 
set nocompatible
set noerrorbells
set foldenable
set clipboard=unnamedplus
set timeoutlen=500 " 500ms to do mapped commands
set ttimeout
set ttimeoutlen=100
set display+=lastline " don't show @ when the last line doesn't fit on the screen
set autoread " automatically read when files have been changed outside of vim
set history=500 " save last 500 commands
set undolevels=500 " number of possible undos; default is 1000
set splitbelow " horizontal split is automatically below
set splitright " vertical split is automatically right
set hidden " don't need to write a file to switch buffers
set noswapfile " no swap files
set nobackup
set nowritebackup
set updatetime=100
set formatoptions+=j " Delete comment character when joining commented lines
set termwinsize=20x200 " terminal buffer size
set lazyredraw " render changes once macro has finished
" highlight characters past 80 chars in a line
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"-----Statusline-----"
set laststatus=2 " show status bar
set statusline=\%F " full file path
set statusline+=%15{FugitiveStatusline()} " git branch
set statusline+=%= " left/right separator
set statusline+=%-15c " cursor column

"-----UI-----"
set noruler
set number " show current line number
set relativenumber " relative line numbering
set showcmd
set scrolloff=5 " 5 line buffer when scrolling up
set sidescrolloff=5 " 5 line buffer when scrolling to the side
set ttyfast
set signcolumn=yes " always show column to the left of numbers
set nowrap

"-----Tabs, indentation, etc.-----" 
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set smartindent
set backspace=indent,eol,start
set shiftwidth=4

"-----Searching-----"
set showmatch " show matching (, {, [, etc.
set incsearch  " show matches without needing <cr>
set path=.,,** " recursive :find searches relative to cwd
set wildmenu " <tab> for match menu in :e and :find
set smartcase " match case if capitals are in a search, otherwise don't
set nohlsearch " don't highlight searches

"-----netrw-----"
let g:netrw_banner = 0
let g:netrw_liststly=3
let g:netrw_list_hide='^\./$' " hide ./ in netrw
let g:netrw_hide=1

"-----Autocomplete-----"
set completeopt=menuone,longest,noinsert
set complete-=i

"-----Markdown-----"
" syntax highlighting in markdown code blocks
let g:markdown_fenced_languages = ['python', 'bash', 'c'] 

"--------------------Plugins--------------------"
call plug#begin('~/.vim/plugged')
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim' " fuzzy finding
Plug 'junegunn/vim-plug'
Plug 'morhetz/gruvbox' " theme
"Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete, linting, formatting
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
call plug#end()

"-----Colorscheme-----"
syntax enable
set background=dark
set termguicolors " colors are off in tmux without this
colorscheme gruvbox
set cursorline
set cursorlineopt=number " highlight current line number

"--------------------Mappings--------------------"
set pastetoggle=<F2> " toggle paste mode

"-----Normal Mode-----"
nnoremap ; :
nnoremap : ;
nnoremap <leader>; :!
nnoremap H ^
nnoremap L g_
nnoremap <leader>H H
nnoremap <leader>L L

"-----Leader Maps-----"
map <space> <leader>
nnoremap <leader>v :vert sfind<space>
nnoremap <leader>kp :!python %<cr>
nnoremap <leader>r :w <bar>source $MYVIMRC<cr>
nnoremap <leader>q :wq!<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>u :e ~/dotfiles/.vimrc<cr>
nnoremap <leader>f :find<space>
" fugitive
nnoremap <leader>gs :vert botright Git<cr>
nnoremap <leader>gd :Git diff<cr>
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>ga :Gdiffsplit<cr>
" toggle netrw
nnoremap <leader>t :10Lexplore<cr>
"terminal buffer
nnoremap <leader>T :term<cr>
" buffers
nnoremap <leader>d :bn<cr>
nnoremap <leader>s :bp<cr>
nnoremap <leader>x :bd!<cr>
" Windows
nnoremap <esc>h <c-w>h
nnoremap <esc>l <c-w>l
nnoremap <esc>j <c-w>j
nnoremap <esc>k <c-w>k
nnoremap <esc>q :q!<cr>
nnoremap <esc>o <c-w>o

"-----Insert Mode-----"
inoremap jk <esc>
inoremap kj <esc>
" give bracket pair with {<cr>
inoremap {<cr> {<cr>}<esc>O
" able to undo text deleted with c-w or c-u
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

"-----Autocommands-----"
" x to quit in help menu
autocmd Filetype help nnoremap <buffer> x :q<cr>
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro " don't continue comments on newlines

"-----Command Mode-----"
cnoremap jk <esc>
cnoremap kj <esc>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoreabbrev v vert
