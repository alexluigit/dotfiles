command! -bang -nargs=* Files
\ call fzf#run(fzf#wrap({'source': 'fd -t f -H',
\ 'options': [ '-m', '--prompt', 'Files> ', '--preview', '~/.config/nvim/pack/bundle/opt/fzf.vim/bin/preview.sh {}'] } ))
command! -bang -nargs=* All
\ call fzf#run(fzf#wrap({'source': 'fd -t f -H --ignore-file ~/.config/fd/fdignore . "$HOME"',
\ 'options': [ '-m', '--prompt', 'All> ', '--preview', '~/.config/nvim/pack/bundle/opt/fzf.vim/bin/preview.sh {}'] } ))
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
\   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
\           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%:hidden', '?'),
\   <bang>0)
command! -bang -nargs=* GGrep
\ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0,
\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

if !exists('s:loaded')
  let s:loaded = {}
endif
function! s:ffn(fn, path) abort
  let ns = tr(matchstr(a:path, '^\a\a\+:'), ':', '#')
  let fn = ns . a:fn
  if len(ns) && !exists('*' . fn) && !has_key(s:loaded, ns) && len(findfile('autoload/' . ns[0:-2] . '.vim', escape(&rtp, ' ')))
    exe 'runtime! autoload/' . ns[0:-2] . '.vim'
    let s:loaded[ns] = 1
  endif
  if len(ns) && exists('*' . fn)
    return fn
  else
    return a:fn
  endif
endfunction

function! s:fcall(fn, path, ...) abort
  return call(s:ffn(a:fn, a:path), [a:path] + a:000)
endfunction
command! -bar -bang Delete
\ let s:file = fnamemodify(bufname(<q-args>),':p') |
\ execute 'bdelete<bang>' |
\ if !bufloaded(s:file) && s:fcall('delete', s:file) |
\   echoerr 'Failed to delete "'.s:file.'"' |
\ endif |
\ unlet s:file
