" Vim configuration file

" Global settings
set autoindent
set autoread
set colorcolumn=80
set formatprg=par\ -w80
set hidden
set hlsearch
set incsearch
set lazyredraw
set nocompatible
set nostartofline
set novisualbell
set pastetoggle=<F2>
set scrolloff=3
set showfulltag
set showmatch
set showmode
set sidescrolloff=2
set ignorecase
set smartcase
set smartindent
set lazyredraw
set tabpagemax=50
set laststatus=2
set tags=.git/tags
set timeoutlen=300
set wildmenu
set wildmode=list:longest,list:full

syntax on
filetype plugin indent on
colorscheme darknight

" Color trailing whitespace
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" Delete trailing white space.
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
inoremap uu <ESC>

" Spelling settings
set dictionary=/usr/share/dict/words
map <F6> <ESC>:setlocal spell! spelllang=fr<CR>
map <F7> <ESC>:setlocal spell! spelllang=en<CR>

" Git Gutter
let g:gitgutter_sign_column_always = 1
let g:gitgutter_escape_grep = 1
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" Shortcuts
nmap <leader>d :bd<CR>
nmap <leader>w :w!<CR>
nmap :W :w
nmap <leader><space> :noh<CR>
nmap <leader>r iReviewed-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com><ESC>
nmap <leader>s iSigned-off-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com><ESC>

" Remove ^M
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
vmap	 s l
nnoremap t gj
nnoremap n gk
vnoremap t gj
vnoremap n gk
nnoremap l n

" Ctrl + \ - Open the definition in a vertical split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Comment code
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" Bubble single lines
nmap <S-N> ddkP
nmap <S-T> ddp
" Bubble multiple lines
vmap <S-N> xkP`[V`]
vmap <S-T> xp`[V`]

" vim-airlines option
let g:airline_theme='solarized'
let g:airline_left_sep=''
let g:airline_right_sep=''

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>
