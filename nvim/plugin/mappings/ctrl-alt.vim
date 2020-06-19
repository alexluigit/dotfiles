nnoremap <silent>        <C-b>            :Buffer<CR>  
nnoremap <silent>        <C-f>            :GFiles<CR>
nnoremap <silent>        <C-h>            :wincmd h<CR>
nnoremap <silent>        <C-j>            :wincmd j<CR>
nnoremap <silent>        <C-k>            :wincmd k<CR>
nnoremap <silent>        <C-l>            :wincmd l<CR>
nnoremap <silent>        <C-p>            :Rg<CR>
nnoremap <silent>        <C-s>            :All<CR>
nnoremap <silent>        <M-h>            :vert resize -5<CR>
nnoremap <silent>        <M-j>            :resize -5<CR>
nnoremap <silent>        <M-k>            :resize +5<CR>
nnoremap <silent>        <M-l>            :vert resize +5<CR>
cnoremap                 <C-a>            <Home>
cnoremap                 <C-e>            <End>
inoremap <silent> <expr> <C-j>            pumvisible() ? '<C-n>' : '<C-j>'
inoremap <silent> <expr> <C-k>            pumvisible() ? '<C-p>' : '<C-k>'
