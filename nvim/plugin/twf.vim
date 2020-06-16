function! TwfExit(path)
  function! TwfExitClosure(job_id, data, event) closure
    bd!
    try
      let out = filereadable(a:path) ? readfile(a:path) : []
    finally
      silent! call delete(a:path)
    endtry
    if !empty(out)
      execute 'edit! ' . out[0]
    endif
  endfunction
  return funcref('TwfExitClosure')
endfunction

function! Twf()
  to vnew
  let temp = tempname()
  call termopen('twf ' . @# . ' > ' . temp, { 'on_exit': TwfExit(temp) })
  set ft=fzf
  startinsert
endfunction
