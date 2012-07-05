"
" if you are not using vim-reset, just link `~/.vimrc` to `_vimrc` file
"

let vimconfig_dir = $VIMCONFIG_DIR

if vimconfig_dir == ""
    let $VIMCONFIG_DIR=$HOME."/.vim"
endif

set autoindent
set nocompatible
filetype plugin indent on
au BufRead,BufNewFile *.tpl set filetype=smarty 
set fileencodings=ucs-bom,gbk,utf8,GB18030,Big5,latin1

syntax on
set ts=4
set smarttab
set expandtab
set shiftwidth=4
set backspace=2
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
set viminfo='1000,f1,<500
set cursorline
autocmd! BufNewFile * silent! call LoadTemplate()
set incsearch
set hlsearch
"hi CursorLine   cterm=NONE ctermbg=lightblue

so ${VIMCONFIG_DIR}/map.vim

function LoadTemplate()
     0r $VIMCONFIG_DIR/skel/tmpl.%:e
     exec "normal G"
     let old_undolevels = &undolevels
     set undolevels=-1
     exe "normal a \<BS>\<Esc>"
     let &undolevels = old_undolevels                                                                                     
     unlet old_undolevels
endfunction
