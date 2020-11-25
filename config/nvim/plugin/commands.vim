command! -bang -nargs=* Files
\ call fzf#run(fzf#wrap({'source': 'fd -t f -H',
\ 'options': [ '-m', '--prompt', 'Files> ', '--preview', '~/.config/nvim/pack/bundle/opt/fzf.vim/bin/preview.sh {}'] } ))

command! -bang -nargs=* All
\ call fzf#run(fzf#wrap({'source': 'fd -t f -H --ignore-file ~/.config/fd/ignore . "$HOME"',
\ 'options': [ '-m', '--prompt', 'All> ', '--preview', '~/.config/nvim/pack/bundle/opt/fzf.vim/bin/preview.sh {}'] } ))

command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

command! StripWhitespace %s/\s\+$//e
