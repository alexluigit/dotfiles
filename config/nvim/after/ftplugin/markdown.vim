" Set folding for 3-backtick markdown divider block
set foldmethod=marker foldmarker={{{,}}}
set foldlevel=1

nmap <buffer> <C-S> <Plug>BujoAddnormal
imap <buffer> <C-S> <Plug>BujoAddinsert
nmap <buffer> <F4> <Plug>BujoChecknormal
imap <buffer> <F4> <Plug>BujoCheckinsert
nmap <silent><buffer> <leader>tf :call alex#utils#todo_marker()<CR>
nmap <silent><buffer> <leader>f :bd#<CR>gF:bd#<CR>
