  augroup Window
    au!
    au VimEnter * if argc() == 0 | set stl=%#Normal# | execute("Files") | endif
    " Statusline
    au BufWinEnter,FocusGained,VimEnter,WinEnter * call alex#statusline#focus()
    au FocusLost,WinLeave * call alex#statusline#blur() 
    " Active | inactive window
    au BufEnter,FocusGained,VimEnter,WinEnter * call alex#window#focus()
    au FocusLost,WinLeave * call alex#window#blur()
    " Miscs
    au TermOpen * setlocal nonu norelativenumber
    au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
    au TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 500)
    if exists("g:tty") 
      au TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif 
    else | set clipboard=unnamedplus
    endif
  augroup END
