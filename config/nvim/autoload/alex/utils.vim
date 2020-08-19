function! alex#utils#syntax_group() abort
  if !exists("*synstack") | return | endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

function! alex#utils#live_reload() abort
  exec "nnoremap <silent><leader>w :silent! w<cr>:silent! !~/.local/bin/bravectl refresh<cr>"
endfunction
