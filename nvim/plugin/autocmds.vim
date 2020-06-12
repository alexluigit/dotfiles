  augroup Window
    au!
    au VimEnter * if argc() == 0 | set stl=%#Normal# | exec("Files") | endif
    " Statusline
    autocmd BufWinEnter,FocusGained,VimEnter,WinEnter * if alex#autocmds#should_use_statusline() | call alex#statusline#focus() | endif
    autocmd FocusLost,WinLeave * if alex#autocmds#should_use_statusline() | call alex#statusline#blur() | endif
    " Active | inactive window
    autocmd BufEnter,FocusGained,VimEnter,WinEnter * if alex#autocmds#should_use_ownsyntax() | call alex#autocmds#window_focus() | endif
    autocmd FocusLost,WinLeave * if alex#autocmds#should_use_ownsyntax() | call alex#autocmds#window_blur() | endif
    " Miscs
    au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
    au TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 500)
    if exists("g:tty") 
      au TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif 
    else | set clipboard=unnamedplus
    endif
  augroup END
