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
au BufRead,BufNewFile *.md set filetype=markdown
set fileencodings=ucs-bom,utf8,gbk,GB18030,Big5,latin1

syntax on
set ts=4
set smarttab
set expandtab
set shiftwidth=4
set backspace=2
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
set viminfo='1000,f1,<500
if version >= 700
    set cursorline
endif
autocmd! BufNewFile * silent! call LoadTemplate()
set incsearch
set hlsearch

" enable modeline
set modeline

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" enabling some warning for python
let python_highlight_all=1

" highlight whitespace at EOL
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

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
