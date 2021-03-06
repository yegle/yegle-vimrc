"
" if you are not using vim-reset, just link `~/.vimrc` to `_vimrc` file
"

let VIMCONFIG_DIR = $VIMCONFIG_DIR

if VIMCONFIG_DIR == ""
    let VIMCONFIG_DIR = $HOME."/.vim"
endif

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'w0rp/ale'
Plugin 'lukaszb/vim-web-indent'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-markdown'
Plugin 'yegle/python_match'
Plugin 'tpope/vim-unimpaired'
Plugin 'derekwyatt/vim-scala'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'luochen1990/rainbow'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'
Plugin 'raymond-w-ko/vim-lua-indent'
Plugin 'exu/pgsql.vim'
Plugin 'nathangrigg/vim-beancount'
Plugin 'Valloric/YouCompleteMe'
Plugin 'leafgarland/typescript-vim'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'hashivim/vim-terraform'

call vundle#end()            " required
filetype plugin indent on    " required

set autoindent
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile SConstruct set filetype=python
set fileencodings=ucs-bom,utf8,gbk,GB18030,Big5,latin1

syntax on
set background=dark
set colorcolumn=80
highlight ColorColumn ctermbg=Red
set ts=4
set smarttab
set expandtab
set shiftwidth=4
set backspace=2
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
set viminfo='1000,f1,<500
if version >= 700
    set cursorline
    set cursorcolumn
endif
set incsearch
set hlsearch

" enable modeline
set modeline

" Add folding
exec ":source " . VIMCONFIG_DIR . "/fold.vim"

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

" highlight whitespace at EOL
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

"hi CursorLine   cterm=NONE ctermbg=lightblue

exec ":source " . VIMCONFIG_DIR . "/map.vim"

autocmd! BufNewFile * call LoadTemplate()
autocmd BufRead,BufNewFile,FileReadPost * silent! call LoadLanguageSpecificSettings()

function LoadTemplate()
    let skel = g:VIMCONFIG_DIR . "/skel/tmpl." . expand("%:e")
    if filereadable(skel)
        exec ":0r " . skel
        exec "normal G"
        let old_undolevels = &undolevels
        set undolevels=-1
        exe "normal a \<BS>\<Esc>"
        let &undolevels = old_undolevels
        unlet old_undolevels
    endif
endfunction

function LoadLanguageSpecificSettings()
    let lang = g:VIMCONFIG_DIR . "/lang/" . expand("%:e") . ".vim"
    if filereadable(lang)
        exec ":source " . lang
    endif
endfunction

let g:ycm_auto_trigger = 1
let g:ycm_python_binary_path = '/Users/ych/.py2kvenv/bin/python'
let g:ycm_path_to_python_interpreter = '/Users/ych/.py2kvenv/bin/python'

autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window ".expand("%"))
au BufRead,BufNewFile /etc/nginx/* if &ft == '' | setfiletype nginx | endif
let g:go_fmt_command = "goimports"

" Close Omni-Cmopletion tip window when a selection is made
autocmd CompleteDone * pclose
