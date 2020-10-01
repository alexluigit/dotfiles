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

augroup Coc
  au!
  au FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

augroup Idleboot
  au!
  if has('vim_starting')
    au CursorHold,CursorHoldI * call alex#lazy#idleboot() " Lazy load some plugin
  endif
augroup end

augroup Miscellaneous
  au!
  " Remove trailing space on save
  au BufWritePre * %s/\s\+$//e
  " If path doesn't exist, just create it
  au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
  " Highlight yanked content for 500 ms and send OSC52 seqs to tty
  au TextYankPost * call alex#autocmds#yank_post()
  " Don't help me to auto comment newline
  au FileType * setlocal fo-=c fo-=r fo-=o
  " fzf-cycle helper
  au Filetype fzf let g:term_meta = get(b:, 'term_title', '')
  " <tab> key fold/unfold patch in fugitive
  au Filetype fugitive nmap <buffer> <Tab> =
  au Filetype vue,javascript,typescript,html,css,sass call alex#utils#live_reload()
  " change layout when nvim window resize
  au VimResized * if !exists("g:manpager") | execute('wincmd =') | endif
augroup end
