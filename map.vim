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

function LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  endtry
endfunction

function LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  endtry
endfunction

nmap ,, :call LocationPrevious()<CR>
nmap .. :call LocationNext()<CR>
