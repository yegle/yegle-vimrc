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
