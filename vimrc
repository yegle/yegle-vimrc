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
Plugin 'lukaszb/vim-web-indent'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-markdown'
Plugin 'yegle/python_match'
Plugin 'evanmiller/nginx-vim-syntax'
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
Plugin 'leafgarland/typescript-vim'
Plugin 'scrooloose/syntastic'

call vundle#end()            " required
filetype plugin indent on    " required

let GOOGLE_CONFIG = "/usr/share/vim/google/google.vim"

if filereadable(GOOGLE_CONFIG)
    exec ":source ".GOOGLE_CONFIG
    Glug piper
    Glug g4
    Glug youcompleteme-google
    Glug codefmt gofmt_executable="goimports"
    Glug codefmt-google enable_gclfmt

    Glug syntastic-google checkers=`{'python': 'gpylint'}`
    " Configure to taste. See ":help syntastic".
    "autocmd FileType python AutoFormatBuffer pyformat
    "autocmd FileType bzl AutoFormatBuffer buildifier

    "autocmd FileType borg AutoFormatBuffer gclfmt
    "autocmd FileType gcl AutoFormatBuffer gclfmt
    autocmd FileType go AutoFormatBuffer gofmt
endif


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
set viminfo='1000,f1,<1000
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

let g:syntastic_cpp_compiler_options = ' -std=c++11'

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

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = "!!"
let g:syntastic_style_warning_symbol = "!!"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_typescript_checkers = ['tsc', 'tslint']
let g:ycm_auto_trigger = 1

autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window ".expand("%"))
au BufRead,BufNewFile /etc/nginx/* if &ft == '' | setfiletype nginx | endif

" Close Omni-Cmopletion tip window when a selection is made
autocmd CompleteDone * pclose

autocmd VimLeavePre * call system("tmux rename-window 'zsh'")
