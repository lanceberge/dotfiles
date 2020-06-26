"--------------------General Settings--------------------" 
" General-------------------- {{{
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
set autochdir " auto change to the directory of a file when switching files
set browsedir=buffer " netrw uses current files directory
filetype indent plugin on " determine the type of a file based on contents
" highlight characters past 80 chars in a line
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
" }}}
" Undos -------------------- {{{
set undolevels=500 " number of possible undos; default is 1000
set undodir=~/.vim/undo " undos save between opening and closing vim
set undofile
" }}}
" Statusline -------------------- {{{
set laststatus=2 " show status bar
set statusline=\%F " full file path
set statusline+=%15{FugitiveStatusline()} " git branch
set statusline+=%= " left/right separator
set statusline+=%-15c " cursor column
" }}}
" UI -------------------- {{{
set noruler
set number " show current line number
set relativenumber " relative line numbering
set showcmd
set scrolloff=5 " 5 line buffer when scrolling up
set sidescrolloff=5 " 5 line buffer when scrolling to the side
set ttyfast
set signcolumn=yes " always show column to the left of numbers
set nowrap
" }}}
" Tabs, Indentation, etc. -------------------- {{{
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set smartindent
set backspace=indent,eol,start
set shiftwidth=4
" }}}
" Searching -------------------- {{{
set showmatch " show matching (, {, [, etc.
set incsearch  " show matches without needing <cr>
set path=.,,** " recursive :find searches relative to cwd
set wildmenu " <tab> for match menu in :e and :find
set smartcase " match case if capitals are in a search, otherwise don't
set nohlsearch " don't highlight searches
" center search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
" 'very magic' searches by default - better support for regular expressions
nnoremap ? ?\v
nnoremap / /\v
" }}}
" Netrw -------------------- {{{
let g:netrw_banner = 0
let g:netrw_liststly=3
let g:netrw_list_hide='^\./$' " hide ./ in netrw
let g:netrw_hide=1
" }}}
" Autocomplete -------------------- {{{
set completeopt=menuone,longest,noinsert
set complete-=i
" }}}
" Markdown -------------------- {{{
" syntax highlighting in markdown code blocks
let g:markdown_fenced_languages = ['python', 'bash', 'c'] 
" }}}
" Plugins -------------------- {{{
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim' " fuzzy finding
Plug 'junegunn/vim-plug'
Plug 'morhetz/gruvbox' " theme
"Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete, linting, formatting
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
call plug#end()
" }}}
" Colorscheme -------------------- {{{
syntax enable
set background=dark
set termguicolors " colors are off in tmux without this
colorscheme gruvbox
set cursorline
set cursorlineopt=number " highlight current line number
" }}}
" FZF -------------------- {{{
set rtp+=~/.fzf
let g:fzf_preview_window = '' " no preview window
" set layout to bottom of screen and roughly 20% of it's height
let g:fzf_layout = { 'down': '~20%' }
" }}}

"--------------------Mappings--------------------"
" General -------------------- {{{
set pastetoggle=<F2> " toggle paste mode
" C-l to clear highlight search (taken from tpope's sensible)
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" }}}
" Normal Mode -------------------- {{{
nnoremap ; :
nnoremap : ;
nnoremap <leader>; :!
nnoremap H ^
nnoremap L $
nnoremap <leader>H H
nnoremap <leader>L L
" }}}
" Leader Maps -------------------- {{{
map <space> <leader>
nnoremap <leader>v :vert sfind<space>
nnoremap <leader>kp :!python %<cr>
nnoremap <leader>r :normal! gg=G<cr>| " reformat
nnoremap <leader>R :w <bar>source ~/dotfiles/.vimrc<cr>
nnoremap <leader>q :wq!<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>u :e ~/dotfiles/.vimrc<cr>
nnoremap <leader>kf :find<space>
" toggle netrw
nnoremap <leader>t :10Lexplore<cr>
"terminal buffer
nnoremap <leader>T :term<cr>
" }}}
" Vim Plug -------------------- {{{
nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pc :PlugClean<cr>
nnoremap <leader>pu :PlugUpdate<cr>
nnoremap <leader>pU :PlugUpgrade<cr>
nnoremap <leader>ps :PlugStatus<cr>
" }}}
" Fugitive -------------------- {{{
nnoremap <leader>gs :vert botright Git<cr>
nnoremap <leader>gd :Git diff<cr>
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>ga :Gdiffsplit<cr>
" }}}
" FZF -------------------- {{{
nnoremap <leader>F :Files<cr>
nnoremap <leader>f :GFiles<cr>
nnoremap <leader>GL :Commits<cr>
nnoremap <leader>gl :BCommits<cr>
nnoremap <leader>kn :Notes<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader><esc>l :Lines<cr>
nnoremap <leader>l :BLines<cr>
nnoremap <leader>m :Maps<cr>
nnoremap <leader>kc :Commands<cr>
nnoremap <leader>km :Marks<cr>
nnoremap <leader>kt :BTags<cr>
nnoremap <leader>KT :Tags<cr>
nnoremap <leader>kh :History<cr>
nnoremap <leader>kw :Windows<cr>
" }}}
" Windows/buffers -------------------- {{{
nnoremap <leader>x :bd!<cr>
nnoremap <esc>h <c-w>h
nnoremap <esc>l <c-w>l
nnoremap <esc>j <c-w>j
nnoremap <esc>k <c-w>k
nnoremap <esc>q :q!<cr>
nnoremap <esc>o <c-w>o
" }}}
" Brackets -------------------- {{{
" Brackets & toggles(taken from tpope's unimpaired - I didn't need the whole plugin)
nnoremap <silent> [<space> O<esc>
nnoremap <silent> ]<space> o<esc>
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]b :bnext<cr>
nnoremap <silent> [B :bfirst<cr>
nnoremap <silent> ]B :blast<cr>
nnoremap [oh :set nohlsearch<cr>
nnoremap ]oh :set hlsearch<cr>
nnoremap yoh :set hlsearch!<cr>
nnoremap [ow :set nowrap<cr>
nnoremap ]ow :set wrap<cr>
nnoremap yow :set wrap!<cr>
nnoremap [ou :set colorcolumn=<cr>
nnoremap ]ou :set colorcolumn=80<cr>
nnoremap [oi :set ignorecase<cr>
nnoremap ]oi :set ignorecase<cr>
nnoremap yoi :set ignorecase!<cr>
" }}}
" Move Line Up/Down -------------------- {{{
function! MoveLineUp(count) " only doesn't work on last line
    let c = a:count
    for i in range(c)
        :normal! ddkP
    endfor
endfunction

function! MoveLineDown(count)
    let c = a:count
    for i in range(c)
        :normal! ddp
    endfor
endfunction

" <count>[e to move current line up <count> times, ]e for down
nnoremap  <silent> ]e :<c-u>call MoveLineDown(v:count1)<cr>
nnoremap <silent> [e :<c-u>call MoveLineUp(v:count1)<cr>
" }}}
" Insert Mode -------------------- {{{
inoremap jk <esc>
" inoremap kj <esc>
" give bracket pair with {<cr>
inoremap {<cr> {<cr>}<esc>O
" able to undo text deleted with c-w or c-u
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
" }}}

"--------------------Autocommands--------------------"
" Help Menu -------------------- {{{
" q to quit in help menu
augroup help_menu
    autocmd!
    autocmd Filetype help nnoremap <buffer> q :q<cr> | nnoremap <buffer> K 5k
                \ | nnoremap <buffer> J 5j
augroup END
" }}}
" Automatically Source -------------------- {{{
augroup auto_source
    autocmd!
    autocmd BufNewFile,BufRead * setlocal formatoptions-=cro " don't continue comments on newlines
    autocmd BufWritePost ~/dotfiles/.vimrc source ~/dotfiles/.vimrc " auto source 
    " .vimrc when writing it
augroup END
" }}}
" Insert Mode -------------------- {{{
" highlight line in insert mode, number otherwise
augroup insert_mode
    autocmd!
    autocmd InsertEnter * set cursorlineopt=both
    autocmd InsertLeave * set cursorlineopt=number
augroup END
" }}}
" Python file settings -------------------- {{{
augroup python
    autocmd!
    autocmd Filetype python iabbrev <buffer> iff if:<cr>
augroup END
" }}}
" Vimscript settings -------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd Filetype vim setlocal foldmethod=marker
augroup END
" }}}
" Command Mode-------------------- {{{
cnoremap jk <esc>
" cnoremap kj <esc>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoreabbrev v vert
" }}}
