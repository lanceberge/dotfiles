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
set browsedir=buffer " netrw uses current files directory
set gdefault " default /g for substitutions
filetype plugin indent on " determine the type of a file based on contents
set shortmess=as
set virtualedit=block
if has('vim')
    set termwinsize=20x200
    set ttyfast
    set viminfo+=n~/.vim/viminfo
endif
" }}}
" Undos {{{
set undolevels=500 " number of possible undos; default is 1000
set undodir=$XDG_CONFIG_HOME/nvim/undo " undos save between opening and closing vim
set undofile
" }}}
" Statusline {{{
set laststatus=2 " show status bar
set statusline=\%f " relative file path
set statusline+=%= " left/right separator
set statusline+=%-15c " cursor column
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
set pastetoggle=<F2> " toggle paste mode
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
nnoremap <silent> * *zz
nnoremap <silent> # #zz
" 'very magic' searches by default - better support for regular expressions
noremap ? ?\v
noremap / /\v
set incsearch  " show matches without needing <cr>
set path=.,, " :find searches relative to cwd
set wildmenu " <tab> for match menu in :e and :find
set ignorecase
set smartcase " match case if capitals are in a search, otherwise don't
set nohlsearch " don't highlight searches
" A-l to clear highlight search (taken from tpope's sensible)
" nnoremap <silent> <A-l> :nohlsearch<c-r>=has('diff')?'<bar>diffupdate':''<cr><cr><c-l>
" }}}
" Autocomplete {{{
set completeopt=menuone,longest
set omnifunc=syntaxcomplete#Complete
" keep a menu item highlighted
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>c-n>" : ""<CR>' 
" keep menu item always highlighted by simulating <Up> on pu visible
inoremap <expr> <C-p> pumvisible() ? '<C-p>' :
  \ '<C-p><C-r>=pumvisible() ? "\<lt>c-p>" : ""<CR>'
" }}}
" Colorscheme {{{
syntax enable
set background=dark
" }}}
" Folding {{{
set foldignore= " folding ignores nothing
" }}}
" Formatoptions {{{
augroup formatoptions
    autocmd!
    " don't continue comments on newlines, autocommand needed because this is
    " set by the vim rtp after the vimrc is sourced
    autocmd Filetype * setlocal formatoptions=jql
    autocmd Filetype * let g:gruvbox_invert_selection=0
augroup END
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
noremap H ^
noremap L $
noremap <silent> <leader><c-h> H
noremap <silent> <leader><c-l> L
noremap ; :
noremap : ;
" }}}
" g and y Prefix {{{
" repeat last macro
nmap gm @@
nnoremap Y y$
" append a semicolon to the end of a line
nnoremap <silent> y; :call setline('.', getline('.') . ';')<cr>
" copy the path of a file in cwd by specifying the filename
nnoremap yp :let @+ = fnamemodify('', ':p')<c-f>0ci'
" split a line at the cursor and move it below the current line
nnoremap gs i<cr><esc>
" split a line at the cursor and move it above the current line
nmap gS i<cr><esc>[e
" comment until the end of the line using tpope's commentary
nmap gC i<cr><esc>gcckJ
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
nnoremap <silent> <A-=> :wincmd =<cr>
nnoremap <silent> <A-]> :wincmd +<cr>
nnoremap <silent> <A-[> :wincmd -<cr>
" }}}
" Buffers {{{
nnoremap <silent> <leader>bd :bd!<cr>
nnoremap <silent> <leader>bs :w<cr>
nnoremap <silent> <leader>bq :update<bar>bd!<cr>
" }}}
" Tabs {{{
nnoremap <silent> <leader>tn :tabnew<cr>
nnoremap <silent> <leader>td :tabclose<cr>
" }}}
" Sessions {{{
" quit and make session
nnoremap <leader>q :wa!<bar>mksession! $XDG_CONFIG_HOME/nvim/sessions/Session.vim<bar>qa!<cr>
nnoremap <leader>vq :exec "wa!<bar>mksession! $XDG_CONFIG_HOME/nvim/sessions/" . 
            \expand('%:t') . ".vim<bar>qa!"<cr>
" load session
nnoremap <leader>vl :so $XDG_CONFIG_HOME/nvim/sessions/<c-d>
nnoremap <leader>vL :so $XDG_CONFIG_HOME/nvim/sessions/Session.vim<cr>
" }}}
" }}}
" Brackets {{{
" Brackets & toggles(taken from tpope's unimpaired - I didn't need the whole plugin)
" insert a newline above the current line
nnoremap <silent> [<space> O<esc>j
nnoremap <silent> ]<space> o<esc>
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]b :bnext<cr>
nnoremap <silent> [B :bfirst<cr>
nnoremap <silent> ]B :blast<cr>
nnoremap <silent> [t :tabprevious<cr>
nnoremap <silent> ]t :tabnext<cr>
nnoremap <silent> [T :tabfirst<cr>
nnoremap <silent> ]T :tablast<cr>
nnoremap [oh :set nohlsearch<cr>
nnoremap ]oh :set hlsearch<cr>
nnoremap [ow :set nowrap<cr>
nnoremap ]ow :set wrap<cr>
nnoremap [oi :set ignorecase<cr>
nnoremap ]oi :set noignorecase<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>
nnoremap [osr :set nosplitright<cr>
nnoremap ]osr :set splitright<cr>
nnoremap [osb :set nosplitbelow<cr>
nnoremap ]osb :set splitbelow<cr>
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
cnoreabbrev v vert
" }}}
" }}}
" Tags {{{
nnoremap <silent> <leader>gt :silent exec "!ctags -R"<cr>
" }}}
" Netrw {{{
" toggle netrw
nnoremap <silent> <leader>on :10Lexplore<cr>
" }}}
" Terminal {{{
if has ('nvim')
    " open terminal
    nnoremap <silent> <leader>ot :terminal<cr>i
    nnoremap <silent> <leader>ovt :vsplit term://zsh<cr>i
    " go to normal mode
    tnoremap <esc> <c-\><c-n>

    " no line numbers for terminal
    augroup terminal
        autocmd!
        autocmd TermOpen * setlocal norelativenumber|setlocal nonumber
    augroup END
endif
" }}}
