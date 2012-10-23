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

" I like to stick to lines under 80 columns
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

"Set mapleader
let mapleader = ","

"voir les caractères invisibles"
set list

" Show tabs and trailing spaces.
" Ctrl-K >> for »
" Ctrl-K .M for ·
" Ctrk-K 0M for ●
" Ctrk-K sB for ▪
" (use :dig for list of digraphs)
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

"Delete trailing white space.
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

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
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l
nnoremap <S-D> <C-w><C-r>

" Map alt to control, much easier with a typematrix
inoremap <A> <C>

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

" Comment code
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" Bubble single lines
nmap <S-N> ddkP
nmap <S-T> ddp
" Bubble multiple lines
vmap <S-N> xkP`[V`]
vmap <S-T> xp`[V`]

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

" powerline
let g:Powerline_symbols = 'fancy'
set laststatus=2
set fillchars+=stl:\ ,stlnc:\

" Dvorak the keymap
nnoremap t j
nnoremap n k
nnoremap s l
vmap     s l
nnoremap t gj
nnoremap n gk
vnoremap t gj
vnoremap n gk
nnoremap j :
nnoremap J :
nnoremap l n
nnoremap L N

nnoremap - $
nnoremap _ ^

" fast escaping
imap jj <ESC>

"map up/down arrow keys to unimpaired commands
nmap <Up> [e
nmap <Down> ]e
vmap <Up> [egv
vmap <Down> ]egv

"map left/right arrow keys to indendation
nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv

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


" Autocompletion

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" NERDTree
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeMapOpenInTab='j'

let NERDTreeIgnore=['.*\.o$']
let NERDTreeIgnore+=['.*\~$']
let NERDTreeIgnore+=['.*\.out$']
let NERDTreeIgnore+=['.*\.so$', '.*\.a$']
