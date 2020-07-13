let mapleader=" "
" fzf
nnoremap <silent>       <C-f>            :call TryGFiles()<CR>
nnoremap <silent>       <C-p>            :Rg<CR>
nnoremap <silent>       <leader>/        :call Twf()<CR>
nnoremap <silent>       <leader>:        :Commands<CR>
nnoremap <silent>       <leader>.        :Filetypes<CR>
nnoremap <silent>       <leader>b        :Buffers<CR>
nnoremap <silent>       <leader>c        :BCommits!<CR>
nnoremap <silent>       <leader>f        :Lines!<CR>
nnoremap <silent>       <leader>h        :Helptags<CR>
nnoremap <silent>       <leader>l        :BLines<CR>
nnoremap <silent>       <leader>s        :Snippets<CR>
imap                    <c-x><c-k>       <plug>(fzf-complete-word)
imap                    <c-x><c-f>       <plug>(fzf-complete-path)
imap                    <c-x><c-l>       <plug>(fzf-complete-line)
" fugitive / diff
nnoremap <silent>       <leader>d        :Gdiff<CR>
nnoremap <silent>       <leader>da       :diffget //2<CR>
nnoremap <silent>       <leader>dg       :diffget //3<CR>
nnoremap <silent>       <leader>dt       :windo diffthis<CR>
nnoremap <silent>       <leader>g        :Git<CR>
" miscellaneous
nnoremap <silent>       <leader><space>  <C-^>
nnoremap                <leader>e        :Rename<space>
nnoremap <silent>       <leader>n        :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>
nnoremap <silent>       <leader>o        :tabedit %<cr>
nnoremap <silent>       <leader>p        "+P
nnoremap <silent>       <leader>q        :q<CR>
nnoremap                <leader>r        :%s///gc<left><left><left>
xnoremap                <leader>r        :s///gc<left><left><left>
nnoremap <silent>       <localleader>s   :UltiSnipsEdit<CR>
nnoremap <silent>       <leader>t        :ColorizerToggle<CR>
nnoremap <silent>       <leader>u        <C-r>
nnoremap <silent>       <leader>v        :vert sb#<CR>
nnoremap <silent>       <leader>w        :silent! w<CR>
nnoremap <silent>       <leader>x        :silent! x<CR>
