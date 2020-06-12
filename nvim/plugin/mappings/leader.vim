let mapleader=" "
nnoremap <silent>        <leader><space>  <C-^>
nnoremap <silent>        <leader>:        :Commands<CR>
nnoremap <silent>        <leader>.        :call Twf()<CR>
nnoremap <silent>        <leader>,        :Commands<CR>
nnoremap <silent>        <leader>b        :Buffers<CR>
nnoremap <silent>        <leader>c        :Commits!<CR>
nnoremap <silent>        <localleader>c   :BCommits!<CR>
nnoremap                 <leader>d        :!mkdir %
nnoremap                 <leader>e        :e %
nnoremap <silent>        <leader>f        :BLines!<CR>
nnoremap <silent>        <localleader>f   :Lines!<CR>
nnoremap <silent>        <leader>g        :Git<CR>
nnoremap <silent>        <leader>gd       :diffget //2<CR>
nnoremap <silent>        <leader>gj       :diffget //3<CR>
nnoremap <silent>        <leader>h        :History<CR>
nnoremap <silent>        <leader>n        :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>
nnoremap <silent>        <leader>o        :wincmd o<CR>
noremap  <silent>        <leader>p        "+P
nnoremap <silent>        <leader>q        :q<CR>
nnoremap                 <leader>r        :%s///gc<left><left><left>
xnoremap                 <leader>r        :s///gc<left><left><left>
nnoremap <silent>        <leader>s        :vert sb#<CR>
nnoremap <silent>        <leader>t        :ColorizerToggle<CR>
nnoremap <silent>        <leader>w        :w<CR>
nnoremap <silent>        <leader>x        :x<CR>
