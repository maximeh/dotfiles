call pathogen#infect()

"ranafoot de la compatibilité vi.." 
set nocompatible 

" wrap at 80c
set wrap
set tw=80
set formatoptions=qrn1
set colorcolumn=81

" Sets how many lines of history VIM has to remember
set history=1000

" Shell
set shell=/bin/zsh

"Set mapleader
let mapleader = ","

"voir les caractères invisibles" 
set list
set listchars=tab:▸\ ,eol:¬,trail:.
set showbreak=↪
" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
"----- Parametres fichiers "

" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"----- Parametres affichage VIM " 

" scroll lines au dessus et en dessous " 
set so=7

" activation wildmenu " 
set wildmenu 
set wildmode=list:longest
set wildignore+=*.pyc,.svn,.git

" affichage des commandes, du mode actuel et de la position du curseur" 
set showcmd 
set showmode 
set ruler 
set cursorline
set ttyfast

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

nnoremap / /\v
vnoremap / /\v
set ignorecase "Ignore case when searching
set smartcase
set hlsearch 
set incsearch "Make search act like search in modern browsers
set gdefault
set showmatch "Show matching bracets when text indicator is over them
" stop highlighting
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

syntax on " syntax hilight on
syntax sync fromstart
filetype plugin indent on

" joli theme toussa " 
set bg=dark
let g:zenburn_high_Contrast = 1
let g:liquidcarbon_high_contrast = 1
let g:molokai_original = 0
set t_Co=256 "use 256 colors
colorscheme molokai

"----- Parametres affichage des fichiers " 
 
" numerotation des lignes " 
set nu 
 
" largeur des tabulations "
set tabstop=4
set softtabstop=4
set expandtab " Always use spaces instead of tabs.
set smarttab " Automatically detect if you want to delete a <Tab>'s worth of spaces.

" largeur des indentations " 
set shiftwidth=4

" indentation automatique " 
set autoindent 
set smartindent 
set cindent 
 
set nolazyredraw "Don't redraw while executing macros 
set magic "Set magic on, for regular expressions
set matchtime=5 "How many tenths of a second to blink

set cot=menu,preview

" encodage et font"
set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types
" Set font according to system
set gfn=Monospace\ 10

" ----- Python section
filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
if has("gui_running")
    highlight SpellBad term=underline gui=undercurl guisp=Orange
endif 

" Auto completion via ctrl-space (instead of the nasty ctrl-x ctrl-o)
autocmd FileType python set omnifunc=pythoncomplete#Complete
inoremap <Nul> <C-x><C-o>
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

" ----- JavaScript section
au FileType javascript setl fen
au FileType javascript setl nocindent

" Autocompletion pour C
autocmd FileType c set omnifunc=ccomplete#Complete

" Autocompletion pour CSS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Autocompletion pour HTML
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
set ofu=syntaxcomplete#Complete

" Markdown
au BufNewFile,BufRead *.m*down setlocal filetype=markdown
" Use <leader>1/2/3 to add headings.
au Filetype markdown nnoremap <buffer> <leader>1 yypVr=
au Filetype markdown nnoremap <buffer> <leader>2 yypVr-
au Filetype markdown nnoremap <buffer> <leader>3 I### <ESC>

" Vim
au FileType help setlocal textwidth=78
au FocusLost * :wa

"----- Raccourcis Claviers " 
" tab' a la firefox " 
map    <C-n>                           :tabnext<cr> 
map    <C-p>                           :tabprev<cr> 
map    <C-t>                           :tabnew<cr>

map    <C-d>                           :q<cr>
map    <C-e>                           :tabnew\|:Explore<cr>

" vertical split
" split screen vertically
nnoremap <leader>\| <C-w>v\|<C-w>l\|:enew<cr>
" split screen horizontally
nnoremap <leader>- <C-w>n<C-w>k
" move around buffer
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Return to normal mode, easier than ESC
inoremap jj <ESC>

" Highlight word at cursor without changing position
nnoremap <leader>h *<C-O>

" Destroy infuriating keys

" Fuck you, help key.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
" Fuck you too, manual key.
nnoremap K <nop>
" Stop it, hash key.
inoremap # X<BS>#

" ----- eclipse like
map     <F10>                          :make           <cr> 
imap    <F10> <ESC>                    :make           <cr> 
map     <F11>                          :make   clean   <cr> 
imap    <F11> <ESC>                    :make   clean   <cr> 

" ---- toggle :paste mode (to retain indent when pasting code)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Bubble single lines
nmap <S-K> ddkP
nmap <S-J> ddp
" Bubble multiple lines
vmap <S-K> xkP`[V`]
vmap <S-J> xp`[V`]

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" ----- Abbrevs
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

" Remove the Windows ^M - when the encodings gets messed up
nnoremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

nnoremap <leader>R :RainbowParenthesesToggle<cr>
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

""""""""""""""
" tmux fixes "
""""""""""""""
" Handle tmux $TERM quirks in vim
if $TERM =~ '^screen-256color'
    map <Esc>OH <Home>
    map! <Esc>OH <Home>
    map <Esc>OF <End>
    map! <Esc>OF <End>
endif
