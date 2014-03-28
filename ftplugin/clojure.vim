imap <Leader>vt <Esc>mz<Leader>vtg`zl
map <Leader>cr :call VimuxRunCommand("lein repl")<CR>

"For Speclj
setlocal lispwords+=describe
setlocal lispwords+=it
setlocal lispwords+=around
setlocal lispwords+=should=
setlocal lispwords+=should-throw
