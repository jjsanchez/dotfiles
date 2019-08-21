
" UI Layout {{{
set number rnu          " show line numbers
" }}}

" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}

" Folding {{{
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10   " start with fold level of 1
" }}}

" Line Shortcuts {{{ 
nnoremap gV `[v`]      " highlight last inserted text
" }}}

" Leader Shortcuts {{{
let mapleader=","       " leader is comma
inoremap jk <esc>       " jk is escape
" }}}
