function! alex#lazy#idleboot() abort
  " Make sure we automatically call alex#lazy#idleboot() only once.
  augroup Idleboot | autocmd! | augroup END
  " Make sure we run deferred tasks exactly once.
  doautocmd User AlexDefer
  autocmd! User AlexDefer
endfunction

" Generic mechanism for scheduling a unit of deferable work.
function! alex#lazy#defer(evalable) abort
  if has('autocmd') && has('vim_starting')
    " Note that these commands are not defined in a group, so that we can call
    " this function multiple times. We rely on lazy#idleboot to ensure that
    " this event is only fired once.
    execute 'autocmd User AlexDefer ' . a:evalable
  else
    execute a:evalable
  endif
endfunction

let s:deoplete_init_done=0
function! alex#lazy#deoplete_init() abort
  if s:deoplete_init_done || !has('nvim') | return | endif
  let s:deoplete_init_done=1 | call deoplete#enable()
  call deoplete#custom#source('file', 'rank', 2000)
  call deoplete#custom#source('ultisnips', 'rank', 1000)
  call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
endfunction
