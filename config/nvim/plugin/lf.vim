function! s:Lf(path, split)
  let s:lf_exe = a:split == 'vs' ? 'lf' : 'lfrun'
  let s:current = expand("%")
  let s:split = a:split
  let s:callback = {'tempname': tempname()}

  function! s:callback.on_exit(id, exit_status, event) dict abort
    bd!
    if filereadable(self.tempname)
      let names = readfile(self.tempname)
      exec s:split . ' ' . fnameescape(names[0])
    else
      exec 'edit ' . s:current
    endif
  endfunction

  let cmd = s:lf_exe . ' -selection-path=' . s:callback.tempname . ' ' .shellescape(a:path)
  if s:split == 'vs' | wincmd n | wincmd L | else | enew | endif
  setlocal nonumber norelativenumber nocursorline nocursorcolumn signcolumn=no listchars= stl= ft=
  ownsyntax off
  call termopen(cmd, s:callback) | file lf:open
  startinsert
endfunction

command! Lf call s:Lf(expand("%"), 'edit')
command! LfVS call s:Lf(expand("%"), 'vs')
let g:loaded_netrwPlugin = 'disable'
