let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'

function! TryGFiles() abort
  if alex#git#isGitRepo() == 0 | execute('GitFiles') | else | execute("Files") | endif
endfunction

function! s:newtabsplit(...) abort
  if argc() > 0 | exec "argd *" | endif
  for file in a:000[0] | exec "arga " . file | endfor
  tabnew | vert sall | exec "argd *"
  call alex#git#cd(expand("%"))
endfunction

function! s:fzf_cycle(...)
  if alex#git#isGitRepo() == 0 | let s:tryGFiles = "GitFiles" | else | let s:tryGFiles = "Files" | endif
  let s:commands = [s:tryGFiles, "Hist", "All"]
  for cmd in s:commands
    if stridx(get(g:, 'term_meta', ''), cmd) > 0 
      let s:next = s:commands[(index(s:commands, cmd) + 1) % len(s:commands)] 
      execute s:next | call feedkeys('i') | return
    endif
  endfor
endfunction

let g:fzf_action = {
  \ 'ctrl-t': function('s:newtabsplit'),
  \ 'ctrl-n': function('s:fzf_cycle'),
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-l': 'e',
  \ 'ctrl-z': 'arga' } " ctrl-z in fzf window is a bug?

" Define Files to have --prompt for fzf_cycle
command! -bang -nargs=* Files
\ call fzf#run(fzf#wrap({'source': 'fd -t f -H', 
\ 'options': [ '--prompt', 'Files> ', '--preview', '~/.config/nvim/pack/bundle/opt/fzf.vim/bin/preview.sh {}'] } ))
command! -bang -nargs=* All
\ call fzf#run(fzf#wrap({'source': 'fd -t f -H -I -E .git . "$HOME"', 
\ 'options': [ '--prompt', 'All> ', '--preview', '~/.config/nvim/pack/bundle/opt/fzf.vim/bin/preview.sh {}'] } ))
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
\   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
\           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%:hidden', '?'),
\   <bang>0)
command! -bang -nargs=* GGrep
\ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0,
\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
" let g:fzf_buffers_jump = 1
" let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
"   \ {'source': 'find '.(empty(<f-args>) ? '.' : <f-args>).' -type d',
"   \  'sink': 'cd'}))
