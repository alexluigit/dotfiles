if exists("g:loaded_global_navigator") | finish | endif
let g:loaded_global_navigator = 1

function! s:GlobalAwareNavigate(direction)
  let nr = winnr()
  execute 'wincmd ' . a:direction
  let at_tab_page_edge = (nr == winnr())
  if at_tab_page_edge
    if a:direction ==? 'h'
        let bspc_direction = 'west'
    elseif a:direction ==? 'j'
        let bspc_direction = 'south'
    elseif a:direction ==? 'k'
        let bspc_direction = 'north'
    elseif a:direction ==? 'l'
        let bspc_direction = 'east'
    endif
    if empty($TMUX)
      let cmd = 'xvimux ' .bspc_direction. ' true true'
    else
      let cmd = 'xvimux ' .bspc_direction. ' true'
    endif
    call system(cmd)
  endif
endfunction

command! -nargs=? GlobalNavigate call s:GlobalAwareNavigate(<f-args>)
