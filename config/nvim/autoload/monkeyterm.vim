" Reuse the same terminal in neovim.
let s:win_id = -1
let s:buf_id = -1

function! s:term_open()
  if !bufexists(s:buf_id)
    new monkey_terminal | wincmd L | call termopen($SHELL, { 'detach': 1 })
    silent file Terminal\ 1
    let s:win_id = win_getid()
    let s:buf_id = bufnr('%')
    set nobuflisted " do not show this buffer when calling :buffers command
  else
    sp | wincmd L | buffer Terminal\ 1
    let s:win_id = win_getid()
  endif
  setl stl=%#Normal# nonu norelativenumber
  startinsert
endfunction

function! monkeyterm#toggle()
  if win_gotoid(s:win_id) | hide
  else | call s:term_open() | endif
endfunction

function! monkeyterm#exec()
  normal! yip
  let text=split(@0, "\n")
  if !win_gotoid(s:win_id)
    call s:term_open()
  endif
  startinsert | sleep 10m
  call feedkeys("\<c-l>")
  for t in text | call feedkeys(t."\<cr>") | continue | endfor
  call feedkeys("\<c-\>\<c-n>") | call feedkeys(":wincmd p\<cr>")
endfunction
