let mapleader=" "
nnoremap <silent>        <leader><space>  <C-^>
nnoremap <silent>        <leader>.        :e $MYVIMRC<CR>
nnoremap <silent>        <leader>:        :Commands<CR>
nnoremap <silent>        <leader>b        :Buffers<CR>
nnoremap <silent>        <leader>c        :BCommits!<CR>
nnoremap <silent>        <localleader>c   :Commits!<CR>
nnoremap <silent>        <leader>d        :q!<CR>
nnoremap <silent>        <leader>e        :CocCommand explorer<CR>
nnoremap                 <localleader>e   :edit <C-R>=expand('%:p:h') . '/'<CR>
nnoremap <silent>        <leader>f        :Files<CR>
nnoremap <silent>        <localleader>f   :All<CR>
nnoremap <silent>        <leader>g        :G<CR>
nnoremap <silent>        <leader>gd       :diffget //2<CR>
nnoremap <silent>        <leader>gj       :diffget //3<CR>
nnoremap <silent>        <leader>h        :History<CR>
nmap     <silent>        <leader>hi       <Plug>(coc-git-chunkinfo)
nmap     <silent>        <leader>hu       <Plug>(coc-git-chunkundo)
nmap     <silent>        <leader>j        <Plug>(coc-diagnostic-next)
nmap     <silent>        <leader>k        <Plug>(coc-diagnostic-prev)
nnoremap <silent>        <leader>o        :wincmd o<CR>
noremap  <silent>        <leader>p        "+P
nnoremap <silent>        <leader>q        :q<CR>
nmap                     <leader>qf       <Plug>(coc-fix-current)
nnoremap                 <leader>r        :%s///gc<left><left><left>
xnoremap                 <leader>r        :s///gc<left><left><left>
nnoremap <silent>        <leader>s        :vert sb#<CR>
nnoremap <silent>        <leader>t        :let @/ = ''<CR>
nnoremap <silent>        <leader>x        :x<CR>
noremap  <silent>        <leader>y        "+y
nnoremap <silent>        <leader>w        :w<CR>
