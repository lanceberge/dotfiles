"--------------------Settings--------------------" 
" General-------------------- {{{
set runtimepath^=~/dotfiles/.vim
" let &packpath = &runtimepath
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
set formatoptions+=j " Delete comment character when joining commented lines
set lazyredraw " render changes once macro has finished
set autochdir " auto change to the directory of a file when switching files
set browsedir=buffer " netrw uses current files directory
set gdefault " default /g for substitutions
filetype indent plugin on " determine the type of a file based on contents
" highlight characters past 80 chars in a line
" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%81v', 100)
" }}}
" Undos -------------------- {{{
set undolevels=500 " number of possible undos; default is 1000
set undodir=~/dotfiles/.vim/undo " undos save between opening and closing vim
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
set incsearch  " show matches without needing <cr>
set path=.,, " :find searches relative to cwd
set wildmenu " <tab> for match menu in :e and :find
set ignorecase
set smartcase " match case if capitals are in a search, otherwise don't
set nohlsearch " don't highlight searches
" }}}
" Netrw -------------------- {{{
let g:netrw_banner = 0
let g:netrw_liststly=3
" let g:netrw_list_hide='^\./$' " hide ./ in netrw
" let g:netrw_hide=1
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
call plug#begin('~/dotfiles/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator' " navigate tmux panes and vim windows with C-{h,j,k,l}
Plug 'junegunn/fzf.vim' " fuzzy finding
Plug 'junegunn/vim-plug'
Plug 'morhetz/gruvbox' " theme
"Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete, linting, formatting
Plug 'tpope/vim-commentary' " comment with gc{motion}
Plug 'tpope/vim-fugitive' " git support
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar' " improves netrw
Plug 'tpope/vim-surround' " s as a motion for surrounding characters
Plug 'wellle/targets.vim' " adds new text obects, also all text objects work outside of the object like ci' does
call plug#end()
" }}}
" Colorscheme -------------------- {{{
syntax enable
set background=dark
set termguicolors " colors are off in tmux without this
colorscheme gruvbox
" }}}
" FZF -------------------- {{{
let g:fzf_preview_window = '' " no preview window
" set layout to bottom of screen and roughly 20% of it's height
let g:fzf_layout = { 'down': '~20%' }
" }}}
" Folding -------------------- {{{
set foldnestmax=10 " deepest fold is 10 levels
set foldignore=
" }}}

"--------------------Mappings--------------------"
" General -------------------- {{{
set pastetoggle=<F2> " toggle paste mode
noremap H ^
noremap L $
noremap <leader><c-h> H
noremap <leader><c-l> L
noremap ; :
noremap : ;
" }}}
" Normal Mode -------------------- {{{
nnoremap <leader>; :!
" C-l to clear highlight search (taken from tpope's sensible)
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nnoremap <leader><cr> <c-^>
" }}}
" Inserts/registers --------------------  {{{
nnoremap y; mqA;<esc>`q| " append a semicolon to the end of a line
nnoremap yf o" }}}<esc>O"  <esc>20i-<esc>A {{{<esc>F"a<space>| " add fold markers below cursor
nnoremap yF O" }}}<esc>O"  <esc>20i-<esc>A {{{<esc>F"a<space>| " add fold markers above cursor
nnoremap ysf }O" }}}<esc>{o"  <esc>20i-<esc>A {{{<esc>F"a<space>| " add fold markers around a body of text
nnoremap <silent>yp :let @" = fnamemodify('', ':p')<c-f>0ci'| " copy a file path in cwd
" }}}
" Leader Maps -------------------- {{{
map <space> <leader>
nnoremap <leader>v :vert sfind<space>
nnoremap <leader>q :update<bar>q!<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>ve :e ~/dotfiles/.config/nvim/init.vim<cr>
nnoremap <leader>vs :w <bar>source ~/dotfiles/.config/nvim/init.vim<cr>
nnoremap <leader>kf :find<space>
nnoremap <leader>s :source %<cr>
" toggle netrw
nnoremap <leader>t :10Lexplore<cr>
"terminal buffer
nnoremap <leader>T :term<cr>
nnoremap <leader>u :call QuickfixToggle()<cr>
" QuickfixToggle ---------- {{{
let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}}
" }}}
" Vim Plug -------------------- {{{
nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pc :PlugClean<cr>
nnoremap <leader>pu :PlugUpdate<cr>
nnoremap <leader>pU :PlugUpgrade<cr>
nnoremap <leader>ps :PlugStatus<cr>
" }}}
" Searching -------------------- {{{
" center search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
" 'very magic' searches by default - better support for regular expressions
noremap ? ?\v
noremap / /\v
" }}}
" Vim-Tmux-Navigator -------------------- {{{
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
" }}}
" Fugitive -------------------- {{{
nnoremap <silent><leader>gs :Git<cr>:wincmd o<cr>| " open git in its own buffer
nnoremap <silent><leader>gd :vert botright Git diff<cr>
nnoremap <silent><leader>gl :Git log<cr>
nnoremap <silent><leader>ga :Gdiffsplit<cr>
" }}}
" FZF -------------------- {{{
" IsInsideGitRepo ----------  {{{
function! IsInsideGitRepo()
  let result=systemlist('git rev-parse --is-inside-work-tree')
  if v:shell_error
    return 0
  else
    return 1
  fi
endfunction
" }}}
" GFilesOrFiles ----------  {{{
function! GFilesOrFiles()
    if IsInsideGitRepo()
        GFiles
    else
        Files
    endif
endfunction
" }}}
nnoremap <leader>F :Files<cr>
nnoremap <leader>f :call GFilesOrFiles()<cr>
nnoremap <leader>gL :Commits<cr>
nnoremap <leader>gl :BCommits<cr>
nnoremap <leader>kn :Notes<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>L :Lines<cr>
nnoremap <leader>l :BLines<cr>
nnoremap <leader>kc :Commands<cr>
nnoremap <leader>km :Marks<cr>
nnoremap <leader>kt :BTags<cr>
nnoremap <leader>kT :Tags<cr>
nnoremap <leader>kH :History<cr>
nnoremap <leader>kw :Windows<cr>
nnoremap <leader>kh :Helptags<cr>
nmap <A-m> <plug>(fzf-maps-n)
imap <A-m> <plug>(fzf-maps-i)
xmap <A-m> <plug>(fzf-maps-x)
omap <A-m> <plug>(fzf-maps-o)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}
" Windows/buffers -------------------- {{{
nnoremap <silent> <leader>x :bd!<cr>
nnoremap <A-q> :q!<cr>
nnoremap <silent>  <A-o> :wincmd o<cr>
nnoremap <silent> <A-=> :wincmd =<cr>
nnoremap <silent> <A-+> :wincmd +<cr>
nnoremap <silent> <A--> :wincmd -<cr>
nnoremap <silent> <A-s> :wincmd s<cr>
nnoremap <silent> <A-v> :wincmd v<cr>
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
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>
" }}}
" Insert Mode -------------------- {{{
inoremap jk <esc>
" give bracket pair with {<cr>
inoremap {<cr> {<cr>}<esc>O
" able to undo text deleted with c-w or c-u
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
" }}}
" Command Mode-------------------- {{{
cnoremap jk <esc>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoreabbrev v vert
" }}}
" Visual Mode-------------------- {{{
vnoremap jk <esc>
" }}}

"--------------------Autocommands--------------------"
" All Filetypes -------------------- {{{
augroup all
    autocmd!
    " don't continue comments on newlines
    autocmd BufNewFile,BufRead * setlocal formatoptions-=cro 
    " auto source .vimrc when writing it
    " autocmd BufWritePost ~/dotfiles/.config/nvim/init.vim source ~/dotfiles/.config/nvim/init.vim
augroup END
" }}}
" Insert Mode -------------------- {{{
" highlight line in insert mode, number otherwise
augroup insert_mode
    autocmd!
    autocmd InsertEnter * set cursorline
    autocmd InsertLeave * set nocursorline
augroup END
" }}}
