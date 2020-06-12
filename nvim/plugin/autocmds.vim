  augroup Window
    au!
    au VimEnter * if argc() == 0 | set stl=%#Normal# | exec("Files") | endif
    " Statusline
    autocmd BufWinEnter,FocusGained,VimEnter,WinEnter * call alex#statusline#focus()
    autocmd FocusLost,WinLeave * call alex#statusline#blur() 
    " Active | inactive window
    autocmd BufEnter,FocusGained,VimEnter,WinEnter * call alex#window#focus()
    autocmd FocusLost,WinLeave * call alex#window#blur()
    " Miscs
    au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
    au TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 500)
    if exists("g:tty") 
      au TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif 
    else | set clipboard=unnamedplus
    endif
  augroup END
