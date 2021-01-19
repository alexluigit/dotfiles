augroup BetterFocus
  au!
  au VimEnter * call alex#autocmds#vim_enter()
  " Active | inactive windodw
  au BufEnter,FocusGained,VimEnter,WinEnter * call alex#window#focus()
  au FocusLost,WinLeave * call alex#window#blur()
  " Statusline
  au BufWinEnter,BufAdd,FocusGained,VimEnter,WinEnter * call alex#statusline#focus()
  au FocusLost,WinLeave * call alex#statusline#blur()
  " Don't show number in vifm/twf
  au TermEnter * setlocal nonu norelativenumber
augroup end

augroup Miscellaneous
  au!
  " Don't help me to auto comment newline
  au FileType * setlocal fo-=c fo-=r fo-=o
  " Remove trailing space on save
  au BufWritePre * StripWhitespace
  " If path doesn't exist, just create it
  au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
  " Highlight yanked content for 500 ms and send OSC52 seqs to tty
  au TextYankPost * call alex#autocmds#yank_post()
  " change layout when nvim window resize
  au VimResized * if &ft != 'man' | execute('wincmd =') | endif
  " Update signature help on jump placeholder.
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
