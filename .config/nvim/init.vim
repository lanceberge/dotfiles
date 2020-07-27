"--------------------Settings--------------------" 
" General-------------------- {{{
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
" }}}
" Undos -------------------- {{{
set undolevels=500 " number of possible undos; default is 1000
set undodir=$XDG_CONFIG_HOME/nvim/undo " undos save between opening and closing vim
set undofile
" }}}
" Statusline -------------------- {{{
set laststatus=2 " show status bar
set statusline=\%f " relative file path
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
let g:netrw_list_hide='^\.\.\=/\=$' " hide ./ and ../ in netrw
" }}}
" Autocomplete -------------------- {{{
set completeopt=menuone,longest
set omnifunc=syntaxcomplete#Complete
" keep a menu item highlighted
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>c-n>" : ""<CR>' 
" keep menu item always highlighted by simulating <Up> on pu visible
inoremap <expr> <C-p> pumvisible() ? '<C-p>' :
  \ '<C-p><C-r>=pumvisible() ? "\<lt>c-p>" : ""<CR>'
" }}}
" Markdown -------------------- {{{
" syntax highlighting in markdown code blocks
let g:markdown_fenced_languages = ['python', 'bash', 'c'] 
" }}}
" Plugins -------------------- {{{
call plug#begin('~/dotfiles/.config/nvim/plugged')
Plug 'christoomey/vim-tmux-navigator' " navigate tmux panes and vim windows with C-{h,j,k,l}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim' " fuzzy finding
Plug 'junegunn/vim-plug'
Plug 'justinmk/vim-sneak' " s for two character searches, like how f is for one character searches
Plug 'morhetz/gruvbox' " theme
Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets' " snippets
Plug 'tpope/vim-commentary' " comment with gc{motion}
Plug 'tpope/vim-fugitive' " git support
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround' " s as a motion for surrounding characters
Plug 'wellle/targets.vim' " adds new text obects, also all text objects work outside of the object like ci' does
" Language specific
Plug 'neovimhaskell/haskell-vim'
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
" Sneak --------------------  {{{
" <A-;> and <A-,> for next in f and sneak searches, as ; is mapped to :
map <A-;> <Plug>Sneak_;
map <A-,> <Plug>Sneak_,
" }}}
" Folding -------------------- {{{
set foldignore= " folding ignores nothing
" }}}
" Formatoptions -------------------- {{{
augroup formatoptions
    autocmd!
    " don't continue comments on newlines, autocommand needed because this is
    " set by the vim rtp after the vimrc is sourced
    autocmd Filetype * setlocal formatoptions=jql 
augroup END
" }}}

"--------------------Mappings--------------------"
" General -------------------- {{{
set pastetoggle=<F2> " toggle paste mode
noremap H ^
noremap L $
noremap <silent> <leader><c-h> H
noremap <silent> <leader><c-l> L
noremap ; :
noremap : :!
" noremap <A-;> ;
" noremap <A-,> ,
nnoremap Y y$
" }}}
" Normal Mode -------------------- {{{
" A-l to clear highlight search (taken from tpope's sensible)
" nnoremap <silent> <A-l> :nohlsearch<c-r>=has('diff')?'<bar>diffupdate':''<cr><cr><c-l>
" }}}
" Inserts/registers --------------------  {{{
" append a semicolon to the end of a line
nnoremap <silent> y; :call setline('.', getline('.') . ';')<cr>
" copy the path of a file in cwd by specifying the filename
nnoremap yp :let @+ = fnamemodify('', ':p')<c-f>0ci'
" split a line at the cursor and move it below the current line
nnoremap gs i<cr><esc>
" split a line at the cursor and move it above the current line
nmap gS i<cr><esc>[e
" }}}
" Leader Maps -------------------- {{{
map <space> <leader>
nnoremap <silent> <leader>ve :e ~/dotfiles/.config/nvim/init.vim<cr>
nnoremap <silent> <leader>vs :w <bar>source ~/dotfiles/.config/nvim/init.vim<cr>
" toggle netrw
nnoremap <silent> <leader>on :10Lexplore<cr>
" reindent
nnoremap <silent> <leader>= magg=G`a
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
" Navigate tmux panes and vim windows as one with c-{h,j,k,l}
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
" }}}
" Fugitive -------------------- {{{
" open git in its own buffer
nnoremap <silent> <leader>gs :Git<cr>:wincmd o<cr>
nnoremap <silent> <leader>gd :vert botright Git diff<cr>
nnoremap <silent> <leader>gl :Git log<cr>
nnoremap <silent> <leader>ga :Gdiffsplit<cr>
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
nmap <leader>fMn <plug>(fzf-maps-n)
nmap <leader>fMi <plug>(fzf-maps-i)
nmap <leader>fMx <plug>(fzf-maps-x)
nmap <leader>fMo <plug>(fzf-maps-o)
imap <A-x><A-f> <plug>(fzf-complete-path)
imap <A-x><A-l> <plug>(fzf-complete-buffer-line)
imap <A-x><A-L> <plug>(fzf-complete-line)
" }}}
" Windows -------------------- {{{
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
" Buffers --------------------  {{{
nnoremap <silent> <leader>bd :bd!<cr>
nnoremap <silent> <leader>bs :w<cr>
nnoremap <silent> <leader>bq :w<bar>bd!<cr>
" }}}
" Tabs --------------------  {{{
nnoremap <silent> <leader>tn :tabnew<cr>
nnoremap <silent> <leader>td :tabclose<cr>
" }}}
" Sessions --------------------  {{{
" quit and make session
nnoremap <leader>q :bufdo update<bar>mksession! $XDG_CONFIG_HOME/nvim/sessions/Session.vim<bar>qa!<cr>
nnoremap <leader>vq :exec "bufdo update<bar>mksession! $XDG_CONFIG_HOME/nvim/sessions/" . 
            \expand('%:t') . ".vim<bar>qa!"<cr>
" load session
nnoremap <leader>vl :so $XDG_CONFIG_HOME/nvim/sessions/Session.vim<cr>
nnoremap <leader>vL :so $XDG_CONFIG_HOME/nvim/sessions/<c-d>
" }}}
" Brackets -------------------- {{{
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
" }}}
" Insert Mode -------------------- {{{
inoremap jk <esc>
" able to undo text deleted with c-w or c-u
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
" delete until the end of the next word (like <c-w> but in the other direction)
inoremap <c-e> <esc>ldei
" }}}
" Command Mode-------------------- {{{
cnoremap jk <esc>
cnoremap <A-j> <down>
cnoremap <A-k> <up>
cnoremap <A-m> %
cnoreabbrev v vert
" }}}
" Visual Mode-------------------- {{{
vnoremap jk <esc>
" }}}
" Tags --------------------  {{{
nnoremap <silent> <leader>gt :silent exec "!ctags -R"<cr>
" }}}
" Snippets --------------------  {{{
" [!] to mark the next point to jump to in custom snippets, then <A-j> to edit it
nnoremap <silent> <A-j> :call search('[!]')<cr>ca[
inoremap <silent> <A-j> <esc>:call search('[!]')<cr>ca[
" <A-J> to clear all [!]
nnoremap <silent> <A-J> ma:%s/\[!\]//g<cr>`a
inoremap <silent> <A-J> <esc>ma:%s/\[!\]//g<cr>`a
" }}}
" Commenting --------------------  {{{
" comment until the end of the line using tpope's commentary
nmap gC i<cr><esc>gcckJ
" }}}
" Terminal --------------------  {{{
" open terminal
nnoremap <silent> <leader>ot :terminal<cr>i
nnoremap <silent> <leader>ovt :vsplit term://zsh<cr>i
" go to normal mode
tnoremap <esc> <c-\><c-n>
" }}}
