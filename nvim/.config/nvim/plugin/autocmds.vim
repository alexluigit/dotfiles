au! VimEnter * if argc() == 0 | exec "History" | endif
au! BufWritePost $MYVIMRC source $MYVIMRC
au! BufWinEnter * call alex#general#root(expand("%"), &buftype)

augroup Stline
  au!
  au FileType coc-explorer,floaterm setl nonu norelativenumber stl=%#Normal#
  au FileType fzf set showtabline=0
  au BufWinEnter,BufEnter * call Stl_Win_Enter()
  au WinLeave * call Stl_Win_Leave()
augroup END
