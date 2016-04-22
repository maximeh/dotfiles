"============================================================================
"File:        jaws.vim
"Description: vim plugin to load per folder/repository settings
"Origin:      http://www.vimninjas.com/2012/08/30/local-vimrc/
"
"============================================================================

if exists("g:loaded_jaws_plugin")
    finish
endif
let g:loaded_jaws_plugin = 1

" Load .vimrc.local if found in git directory
if filereadable('.git/.vimrc.local')
  source .git/.vimrc.local
else
  if filereadable('.vimrc.local')
    source .vimrc.local
  endif
endif

" vim: set et sts=4 sw=4:
