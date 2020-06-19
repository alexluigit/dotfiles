augroup Window
  au!
  au VimEnter * if argc() == 0 | set stl=%#Normal# | execute("Files") | endif
  " Statusline
  au BufWinEnter,FocusGained,VimEnter,WinEnter * call alex#statusline#focus()
  au FocusLost,WinLeave * call alex#statusline#blur() 
  " Active | inactive windodw
  au BufEnter,FocusGained,VimEnter,WinEnter * call alex#window#focus()
  au FocusLost,WinLeave * call alex#window#blur()
  " Don't show number in vifm/twf
  au TermEnter * setlocal nonu norelativenumber
  " If path doesn't exist, just create it
  au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
  " Highlight yanked content for 500 ms
  au TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 500)
  " Only usee Osc52Yank when tty variable has been passed in
  if exists("g:tty") | au TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
  else | set clipboard=unnamedplus | endif
  " Change to US input source when leaving insert mode
  au InsertLeave * silent execute('!xkbswitch -s 1')
augroup END
