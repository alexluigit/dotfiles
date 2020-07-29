let s:ownsyntax_blacklist = [ '', 'man', 'qf']
function! alex#window#allow_ownsyntax() abort
  if index(s:ownsyntax_blacklist, &filetype) != -1 | return 0 | endif
  " if !empty(&buftype) | return 0 | endif
  return &buflisted
endfunction

function! alex#window#focus()
  if alex#window#allow_ownsyntax()
    ownsyntax on
    exec("ColorizerAttachToBuffer")
  endif
endfunction

function! alex#window#blur()
  if alex#window#allow_ownsyntax()
    " exec("ColorizerDetachFromBuffer")
    ownsyntax off
  endif
endfunction
