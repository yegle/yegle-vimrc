"
" if you are not using vim-reset, please set VIMCONFIG_DIR here:
" example:
"
" let VIMCONFIG_DIR=$HOME/.vim
"
"

set autoindent
set nocompatible
filetype plugin indent on
au BufRead,BufNewFile *.tpl set filetype=smarty 
au BufRead,BufNewFile *.md set filetype=markdown
"set fileencodings=utf8,GB18030,Big5,latin1

syntax on
set ts=4
set smarttab
set expandtab
set shiftwidth=4
set backspace=2
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
set viminfo='1000,f1,<500
set cursorline
autocmd! BufNewFile * silent! 0r $VIMCONFIG_DIR/skel/tmpl.%:e
set incsearch
set hlsearch
"hi CursorLine   cterm=NONE ctermbg=lightblue

so ${VIMCONFIG_DIR}/map.vim
