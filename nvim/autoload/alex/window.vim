function! alex#window#focus()
  if alex#autocmds#should_use_ownsyntax()
    ownsyntax on
  endif
endfunction

function! alex#window#blur()
  if alex#autocmds#should_use_ownsyntax()
    ownsyntax off
  endif
endfunction
