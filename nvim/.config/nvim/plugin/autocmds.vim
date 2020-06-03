au! VimEnter * if argc() == 0 | exec("History") | endif
au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
" au! BufWritePost $MYVIMRC source $MYVIMRC
" au! BufWinEnter * call alex#general#root(expand("%"), &buftype)
au TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 500)
augroup Stline
  au!
  au FileType coc-explorer,floaterm setl nonu norelativenumber stl=%#Normal#
  au FileType fzf set showtabline=0
  au BufWinEnter,BufEnter,FocusGained * call Stl_Win_Enter() 
  au WinLeave,FocusLost * call Stl_Win_Leave()
augroup END
