function! alex#utils#syntax_group() abort
  if !exists("*synstack") | return | endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
