if exists("g:loaded_bspwm_navigator") | finish | endif
let g:loaded_bspwm_navigator = 1

function! s:BspwmAwareNavigate(direction)
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
    let cmd = 'bspc node -f ' . bspc_direction . '.local'
    call system(cmd)
  endif
endfunction

command! -nargs=? BspwmNavigate call s:BspwmAwareNavigate(<f-args>)
