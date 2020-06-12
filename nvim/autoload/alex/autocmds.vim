let g:statusline_ft_blacklist = [ '', 'fzf', 'diff', 'fugitiveblame', 'qf' ]
" let g:ownsyntax_blacklist = [ '', 'dirvish' ]
let g:ownsyntax_blacklist = [ '' ]
function! alex#autocmds#should_use_statusline() abort
  if index(g:statusline_ft_blacklist, &filetype) != -1 | return 0 | endif
  if !empty(&buftype) | return 0 | endif
  return &buflisted
endfunction

function! alex#autocmds#should_use_ownsyntax() abort
  if index(g:ownsyntax_blacklist, &filetype) != -1 | return 0 | endif
  " if !empty(&buftype) | return 0 | endif
  return &buflisted
endfunction
