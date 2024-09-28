"""""""""""""""""""""""""""""Plugins""""""""""""""""""""""""""""""
" Vim Plug {{{
nnoremap <leader>pi :w<bar>PlugInstall<cr>
nnoremap <leader>pc :w<bar>PlugClean<cr>
nnoremap <leader>pu :w<bar>PlugUpdate<cr>
nnoremap <leader>pU :w<bar>PlugUpgrade<cr>
nnoremap <leader>ps :w<bar>PlugStatus<cr>

call plug#begin('~/dotfiles/.config/nvim/plugged')
" Plug 'junegunn/fzf.vim' " fuzzy finding
Plug 'junegunn/vim-plug'
Plug 'justinmk/vim-sneak' " s for two character searches, like how f is for one character searches
Plug 'morhetz/gruvbox' " theme
" Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets' " snippets
Plug 'tpope/vim-commentary' " comment with gc{motion}
Plug 'tpope/vim-fugitive' " git support
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround' " s as a motion for surrounding characters
Plug 'wellle/targets.vim' " adds new text obects, also all text objects work outside of the object like ci' does
" Language specific
call plug#end()
" }}}
" FZF {{{
nnoremap <leader>. :call GFilesOrFiles()<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fgL :Commits<cr>
nnoremap <leader>fgl :BCommits<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fL :Lines<cr>
nnoremap <leader>fl :BLines<cr>
nnoremap <leader>fc :Commands<cr>
nnoremap <leader>fm :Marks<cr>
nnoremap <leader>ft :BTags<cr>
nnoremap <leader>fT :Tags<cr>
nnoremap <leader>fH :History<cr>
nnoremap <leader>fw :Windows<cr>
nnoremap <leader>fh :Helptags<cr>
nnoremap <leader>fs :Snippets<cr>
" }}}
" Snippets {{{
let g:UltiSnipsExpandTrigger="<A-j>"
let g:UltiSnipsJumpForwardTrigger="<A-j>"
let g:UltiSnipsJumpBackwardTrigger="<A-k>"
" }}}
" Fugitive {{{
" open git in its own buffer
nnoremap <silent> <leader>gs :Git<cr>:wincmd o<cr>
nnoremap <silent> <leader>gd :vert botright Git diff<cr>
nnoremap <silent> <leader>gl :Git log<cr>
" }}}

""""""""""""""""""""""""""""""Settings""""""""""""""""""""""""""""""
" General {{{
set noerrorbells
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
set lazyredraw " render changes once macro has finished
set autochdir " auto change to the directory of a file when switching files
set gdefault " default /g for substitutions
filetype plugin indent on " determine the type of a file based on contents
set virtualedit=block
" }}}
" Undos {{{
set undodir=$XDG_CONFIG_HOME/nvim/undo " undos save between opening and closing vim
set undofile
" }}}
" UI {{{
set noruler
set number " show current line number
set relativenumber " relative line numbering
set showcmd
set scrolloff=5 " 5 line buffer when scrolling up
set sidescrolloff=5 " 5 line buffer when scrolling to the side
set nowrap
" }}}
" Tabs, Indentation, etc. {{{
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set smartindent
set backspace=indent,eol,start
set shiftwidth=4
" }}}
" Searching {{{
" center search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
set incsearch  " show matches without needing <cr>
set ignorecase
set smartcase " match case if capitals are in a search, otherwise don't
set nohlsearch " don't highlight searches
" }}}
" Colorscheme {{{
syntax enable
set background=dark
colorscheme gruvbox
" }}}
" Folding {{{
set foldignore= " folding ignores nothing
" }}}

""""""""""""""""""""""""""""""Mappings""""""""""""""""""""""""""""""
" General Leader Maps {{{
map <space> <leader>
nnoremap <silent> <leader>ve :e ~/dotfiles/.config/nvim/init.vim<cr>
nnoremap <silent> <leader>vs :w <bar>source ~/dotfiles/.config/nvim/init.vim<cr>
nnoremap <leader>; :!
" reindent
nnoremap <silent> <leader>= magg=G`a
" }}}
" Not Mode Specific {{{
noremap H _
noremap L $
noremap ; :
noremap : ;
" }}}
" g and y Prefix {{{
" repeat last macro
nmap gm @@
nnoremap Y y$
" split a line at the cursor and move it below the current line
nnoremap gs i<cr><esc>
" split a line at the cursor and move it above the current line
nmap gS i<cr><esc>[e
" }}}
" Windows, Buffers, Tabs, Sessions {{{
" Windows {{{
nnoremap <silent> <c-h> :wincmd h<cr>
nnoremap <silent> <c-j> :wincmd j<cr>
nnoremap <silent> <c-k> :wincmd k<cr>
nnoremap <silent> <c-l> :wincmd l<cr>
nnoremap <leader>w <c-w>
" save and quit window
nnoremap <leader>wq :x<cr>
" delete window
nnoremap <silent> <leader>wd :q!<cr>
nnoremap <silent> <A-o> :wincmd o<cr>
" Buffers {{{
nnoremap <silent> <leader>bd :bd!<cr>
nnoremap <silent> <leader>bs :w<cr>
" }}}
" Sessions {{{
" quit and make session
nnoremap <leader>q :wa!<bar>mksession! $XDG_CONFIG_HOME/nvim/sessions/Session.vim<bar>qa!<cr>
" load session
nnoremap <leader>vl :so $XDG_CONFIG_HOME/nvim/sessions/<c-d>
" }}}
" }}}
" Brackets {{{
" Brackets & toggles(taken from tpope's unimpaired - I didn't need the whole plugin)
" insert a newline above the current line
nnoremap <silent> [<space> O<esc>j
nnoremap <silent> ]<space> o<esc>
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]b :bnext<cr>
nnoremap [oh :set nohlsearch<cr>
nnoremap ]oh :set hlsearch<cr>
" }}}
" Insert, Visual, Command Mode {{{
" Insert Mode {{{
inoremap jk <esc>
" able to undo text deleted with c-w or c-u
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
" delete until the end of the next word (like <c-w> but in the other direction)
inoremap <c-e> <esc>ldei
" }}}
" Command Mode {{{
cnoremap jk <esc>
cnoremap <A-j> <down>
cnoremap <A-k> <up>
cnoremap <A-m> %
cnoremap ; <cr>
" }}}
" }}}
" Netrw {{{
" toggle netrw
nnoremap <silent> <leader>on :10Lexplore<cr>
" }}}
