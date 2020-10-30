function! alex#utils#syntax_group() abort
  if !exists("*synstack") | return | endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

function! alex#utils#live_reload() abort
  exec "nnoremap <silent><leader>w :silent! w<cr>:silent! !~/.local/bin/bravectl refresh<cr>"
endfunction

function! alex#utils#todo_launch() abort
  let g:todo_marker = line('.')
  exec "Todo"
endfunction

function! alex#utils#todo_marker() abort
  let s:filename = expand('#')
  let s:current_line = line('.')
  let @a = "[Ref](" . s:filename . ":" . g:todo_marker . ")"
  call append('.', @a)
endfunction
