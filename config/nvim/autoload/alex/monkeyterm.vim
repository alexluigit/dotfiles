" Reuse the same terminal in neovim.
let s:monkey_terminal_window = -1
let s:monkey_terminal_buffer = -1
let s:monkey_terminal_job_id = -1

function! alex#monkeyterm#open()
  " Check if buffer exists, if not create a window and a buffer
  if !bufexists(s:monkey_terminal_buffer)
    " Creates a window call monkey_terminal
    new monkey_terminal
    " Moves to the window the right the current one
    wincmd L
    let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })
     " Change the name of the buffer to "Terminal 1"
     silent file Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
     let s:monkey_terminal_buffer = bufnr('%')
    " The buffer of the terminal won't appear in the list of the buffers
    " when calling :buffers command
    set nobuflisted
  else
    if !win_gotoid(s:monkey_terminal_window)
    sp
    " Moves to the window below the current one
    wincmd L
    buffer Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
    endif
  endif
  setl stl=%#Normal# nonu norelativenumber
  startinsert
endfunction

function! alex#monkeyterm#toggle()
  if win_gotoid(s:monkey_terminal_window)
    call alex#monkeyterm#close()
  else
    call alex#monkeyterm#open()
  endif
endfunction

function! alex#monkeyterm#close()
  if win_gotoid(s:monkey_terminal_window)
    " close the current window
    hide
  endif
endfunction

function! alex#monkeyterm#exec(cmd)
  if !win_gotoid(s:monkey_terminal_window)
    call alex#monkeyterm#open()
  endif
  " clear current input
  call jobsend(s:monkey_terminal_job_id, "clear\n")
  " run cmd
  call jobsend(s:monkey_terminal_job_id, a:cmd . "\n")
  normal! G
  wincmd p
endfunction


" This an example on how specify command with different types of files.
" augroup go
"   autocmd!
"   autocmd BufRead,BufNewFile *.go set filetype=go
"   autocmd FileType go nnoremap <F5> :call alex#monkeyterm#Exec('go run ' . expand('%'))<cr>
" augroup END
