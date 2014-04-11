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

function LocationListNavOrJustOne(cmd)
    redir => output
    silent! exec a:cmd
    redir END
    if match(output, "E553: No more items") >= 0
        exec ':ll'
    else
        echom output
    endif
endfunction

nmap ,, :call LocationListNavOrJustOne(":lprev")<CR>
nmap .. :call LocationListNavOrJustOne(":lnext")<CR>
