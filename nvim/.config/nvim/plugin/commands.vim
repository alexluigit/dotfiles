command! -bang -nargs=* GGrep
\ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0,
\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
command! -bang -nargs=* All
\ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/i*}" "$HOME"', 
\ 'options': [ '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}'] } ))
