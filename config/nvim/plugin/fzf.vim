let g:fzf_tags_command = 'ctags -R'
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
let $FZF_DEFAULT_OPTS = '--layout=reverse --bind=ctrl-e:up,ctrl-a:beginning-of-line,f3:end-of-line,down:preview-down,up:preview-up --inline-info'

function! s:newtabsplit(...) abort
  if argc() > 0 | exec "argd *" | endif
  for file in a:000[0] | exec "arga " . file | endfor
  tabnew | vert sall | exec "argd *"
  call alex#git#cd(expand("%"))
endfunction

function! s:fzf_cycle(...)
  let s:commands = ["Files", "Hist", "All"]
  for cmd in s:commands
    if stridx(get(g:, 'term_meta', ''), cmd) > 0
      let s:next = s:commands[(index(s:commands, cmd) + 1) % len(s:commands)]
      execute s:next | setl norelativenumber | return
    endif
  endfor
endfunction

let g:fzf_action = {
  \ 'ctrl-t': function('s:newtabsplit'),
  \ 'ctrl-c': function('s:fzf_cycle'),
  \ 'f5':     'vsplit',
  \ 'ctrl-s': 'split',
  \ 'ctrl-l': 'vsplit',
  \ 'ctrl-z': 'arga' } " ctrl-z in fzf window is a bug?
