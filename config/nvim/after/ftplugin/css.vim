setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
setlocal cindent foldmethod=syntax
nnoremap <buffer><silent><leader>w :silent! w<cr>:silent! !~/.local/bin/bravectl refresh<cr>
