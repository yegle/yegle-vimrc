imap (<CR> ()<CR><ESC>O
imap {<CR> {}<CR><ESC>O

imap "" ""<ESC>i
imap '' ''<ESC>i
imap () ()<ESC>i
imap {} {}<ESC>i
imap [] []<ESC>i
imap <> <><ESC>i
imap $$ $$<ESC>i
imap %% %%<ESC>i<SPACE><SPACE><ESC>i
" fix spell errors by selecting first suggestion
imap ^L <Esc>[s1z=`]a

" easier window navigation
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

nnoremap <TAB><TAB> "=strftime("%Y-%m-%d")<CR>Pa<SPACE>

function LocationPrevious()
    if len(getqflist())
        try
            cprevious
        catch /^Vim\%((\a\+)\)\=:E553/
            clast
        endtry
    else
        try
            lprev
        catch /^Vim\%((\a\+)\)\=:E553/
            llast
        endtry
    endif
endfunction

function LocationNext()
    if len(getqflist())
        try
            cnext
        catch /^Vim\%((\a\+)\)\=:E553/
            cfirst
        endtry
    else
        try
            lnext
        catch /^Vim\%((\a\+)\)\=:E553/
            lfirst
        endtry
    endif
endfunction

function FormatBeanCountFile()
    let lineno=line('.')
    execute ":silent w"
    execute ":%!bean-format %"
    execute ":".lineno
endfunction

nmap ,, :call LocationPrevious()<CR>
nmap .. :call LocationNext()<CR>

map <C-n> :NERDTreeToggle<CR>
vnoremap // y/<C-R>"<CR>
nnoremap <C-p> :execute ":!bean-doctor context % " . line('.')<CR>
nnoremap <C-l> :call FormatBeanCountFile()<CR>
inoremap <TAB><TAB> <C-x><C-o>
