" Vim configuration file

" Global settings
set autoindent
set autoread
set backspace=indent,eol,start
set colorcolumn=80
set formatprg=par\ -w80
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set nocompatible
set nostartofline
set novisualbell
set number
set pastetoggle=<F2>
set relativenumber
set scrolloff=3
set showfulltag
set showmatch matchtime=3
set showmode
set sidescrolloff=2
set signcolumn=yes
set smartcase
set smartindent
set tabpagemax=50
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

inoremap } }<Left><c-o>%<c-o>:sleep 500m<CR><c-o>%<c-o>a
inoremap ] ]<Left><c-o>%<c-o>:sleep 500m<CR><c-o>%<c-o>a
inoremap ) )<Left><c-o>%<c-o>:sleep 500m<CR><c-o>%<c-o>a

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

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" Lightline
let g:lightline = {
\ 'colorscheme': 'dark',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction
