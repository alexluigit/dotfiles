augroup Window
  au!
  au VimEnter * if argc() == 0 | set stl=%#Normal# | call TryGFiles() | endif
  " Active | inactive windodw
  au BufEnter,FocusGained,VimEnter,WinEnter * call alex#window#focus()
  au FocusLost,WinLeave * call alex#window#blur()
  " Statusline
  au BufWinEnter,BufAdd,FocusGained,VimEnter,WinEnter * call alex#statusline#focus()
  au FocusLost,WinLeave * call alex#statusline#blur() 
  " Don't show number in vifm/twf
  au TermEnter * setlocal nonu norelativenumber
augroup END

augroup Idleboot
  au!
  if has('vim_starting')
    au CursorHold,CursorHoldI * call alex#autocmds#idleboot() " Lazy load some plugin
  endif
augroup END

augroup Others
  au!
  " Remove trailing space on save
  au BufWritePre * %s/\s\+$//e
  " If path doesn't exist, just create it
  au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
  " Highlight yanked content for 500 ms
  au TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 500)
  " Only usee Osc52Yank when tty variable has been passed in
  if exists("g:tty") | au TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
  else | set clipboard=unnamedplus | endif
  " Change to US input source when leaving insert mode
  au InsertLeave * silent execute('!xkbswitch -s 1')
  " Don't help me to auto comment newline 
  au FileType * setlocal fo-=c fo-=r fo-=o
  " fzf-cycle helper
  au Filetype fzf let g:term_meta = get(b:, 'term_title', '')
  " Close preview window when complete finishes
  au CompleteDone * pclose
augroup END
