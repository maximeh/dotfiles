" Vim configuration file
call pathogen#infect()

" Global settings
set autoindent
set autoread
set backspace=eol,start,indent
set expandtab
set hidden
set hlsearch
set incsearch
set infercase
set iskeyword=@,48-57,_,192-255,-
set lazyredraw
set ls=2
set nocompatible
set nocp
set nostartofline
set novisualbell
set nrformats-=octal
set pastetoggle=<F2>
set ruler
set scrolloff=3
set showcmd
set showfulltag
set showmatch
set showmode
set sidescrolloff=2
set smartcase
set smartindent
set sts=2
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.out,.toc
set sw=2
set tabstop=2
set tabpagemax=200
set t_Co=256
set textwidth=0
set ttimeout
set ttimeoutlen=50
set ttyfast
set wildignore=*.o,*~,*.swp,*.class
set wildmenu
set wildmode=full

filetype plugin indent on
set ofu=syntaxcomplete#Complete
au BufRead,BufNewFile *.go setlocal filetype=go
syntax on
colorscheme solarized

highlight Normal ctermbg=none
highlight ExtraWhitespace ctermbg=darkred guibg=darkgreen

highlight SignColumn ctermbg=black
let g:gitgutter_highlights = 1

match Special /\%80v.\+/
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

"Delete trailing white space.
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

let mapleader = ","
let g:mapleader = ","

au filetype c,cpp map <F9> :make<CR>
au filetype java map <F10> :Java %<CR>

" Nice statusbar
set laststatus=2

" Spelling settings
set dictionary=/usr/share/dict/words
map <F6> <ESC>:setlocal spell! spelllang=fr<CR>
map <F7> <ESC>:setlocal spell! spelllang=en<CR>

" Git Gutter
au VimEnter * GitGutterDisable
map <F3> <ESC>:GitGutterToggle<CR>

" Shortcuts
map <Tab> :bn<CR>
map <S-Tab> :bp<CR>
nmap <leader>d :bd<CR>
nmap <leader>w :w!<CR>
nmap :W :w
nmap <leader><space> :noh<CR>
nmap <leader>r iReviewed-by Maxime Hadjinlian <maxime.hadjinlian@gmail.com><ESC>
nmap <leader>s iSigned-off-by Maxime Hadjinlian <maxime.hadjinlia@gmail.com><ESC>
nmap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" vertical split
" split screen vertically
nnoremap <leader>\| <C-w>v\|<C-w>l\|:enew<cr>
" split screen horizontally
nnoremap <leader>- <C-w>n<C-w>k
" move around buffer
nnoremap <leader><Left> <C-w>h
nnoremap <leader><Down> <C-w>j
nnoremap <leader><Up> <C-w>k
nnoremap <leader><Right> <C-w>l
nnoremap <S-D> <C-w><C-r>
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
nnoremap - $
nnoremap _ ^
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

" Comment code
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" Bubble single lines
nmap <S-N> ddkP
nmap <S-T> ddp
" Bubble multiple lines
vmap <S-N> xkP`[V`]
vmap <S-T> xp`[V`]

" Vimrc editing and autoreload on save
nmap <leader>e :e! ~/.vimrc<CR>
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

au FileType make setlocal noexpandtab
au FileType c,cpp setlocal formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,:// noexpandtab
au FileType python setlocal ts=4 sts=4 sw=4 expandtab autoindent
au FileType java setlocal ts=4 sts=4 sw=4 noexpandtab
au FileType gitconfig setlocal noexpandtab
au FileType gitcommit setlocal tw=72

au BufRead *.tex setlocal tw=80
au BufRead .letter,/tmp/mutt*,*.txt,.signature*,signature* setlocal tw=72 foldmethod=manual

" vim-airlines option
let g:airline_theme='solarized'

" Ctrl-P options
" http://kien.github.com/ctrlp.vim/
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_max_files = 50000
let g:ctrlp_user_command = 'find %s -type f'

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
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
