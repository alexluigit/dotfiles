" ------------  fzf  ---------------
function s:newtabsplit(...) abort
  if argc() > 0 | exec "argd *" | endif
  for file in a:000[0]
    exec "arga " . file 
  endfor
  tabnew | vert sall
  exec "argd *"
  call alex#git#dir(expand("%"))
endfunction
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
let g:fzf_action = {
  \ 'ctrl-t': function('s:newtabsplit'),
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" let g:fzf_buffers_jump = 1
