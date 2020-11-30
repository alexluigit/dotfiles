let s:ownsyntax_blacklist = [ '', 'man', 'qf', 'vue' ]
function! s:ownsyntax() abort
  if index(s:ownsyntax_blacklist, &filetype) != -1 | return 0 | endif
  " if !empty(&buftype) | return 0 | endif
  return &buflisted
endfunction

function! alex#window#focus()
  if s:ownsyntax()
    ownsyntax on
    exec("ColorizerAttachToBuffer")
  endif
endfunction

function! alex#window#blur()
  if s:ownsyntax()
    " exec("ColorizerDetachFromBuffer")
    ownsyntax off
  endif
endfunction
