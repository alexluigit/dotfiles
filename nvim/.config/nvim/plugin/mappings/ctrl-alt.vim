inoremap                 <C-l>            <del>
nnoremap <silent>        <C-f>            :BLines!<CR>
nnoremap <silent>        <C-p>            :Rg <C-r><C-a><CR>
nnoremap <silent>        <C-b>            <PageDown>  
nnoremap <silent>        <C-g>            <PageUp>  
nnoremap <silent>        <C-h>            :wincmd h<CR>
nnoremap <silent>        <C-j>            :wincmd j<CR>
nnoremap <silent>        <C-k>            :wincmd k<CR>
nnoremap <silent>        <C-l>            :wincmd l<CR>
nnoremap <silent>        <M-j>            :resize -2<CR>
nnoremap <silent>        <M-k>            :resize +2<CR>
nnoremap <silent>        <M-h>            :vertical resize -5<CR>
nnoremap <silent>        <M-l>            :vertical resize +5<CR>
tnoremap <silent>        <M-h>            <C-\><C-n>:vert resize -5<CR>i
tnoremap <silent>        <M-l>            <C-\><C-n>:vert resize +5<CR>i