command! -bang -nargs=* GGrep
\ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0,
\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
command! -bang -nargs=* All
\ call fzf#run(fzf#wrap({'source': 'fd -t f -H -I -E .git . "$HOME"', 
\ 'options': [ '--preview', '~/.config/nvim/pack/bundle/opt/fzf.vim/bin/preview.sh {}'] } ))
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --hidden --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
  \ {'source': 'find '.(empty(<f-args>) ? '.' : <f-args>).' -type d',
  \  'sink': 'cd'}))
command! -nargs=0 Lcd call alex#git#dir()
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%:hidden', '?'),
  \   <bang>0)
