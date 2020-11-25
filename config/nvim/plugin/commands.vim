command! -bang -nargs=* Files
\ call fzf#run(fzf#wrap({'source': 'fd -t f -H',
\ 'options': [ '-m', '--prompt', 'Files> ', '--preview', '~/.config/nvim/pack/bundle/opt/fzf.vim/bin/preview.sh {}'] } ))

command! -bang -nargs=* All
\ call fzf#run(fzf#wrap({'source': 'fd -t f -H --ignore-file ~/.config/fd/ignore . "$HOME"',
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

command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

command! StripWhitespace %s/\s\+$//e
