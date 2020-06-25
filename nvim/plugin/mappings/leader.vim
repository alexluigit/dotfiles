let mapleader=" "

nnoremap <silent>       <C-f>            :call TryGFiles()<CR>
nnoremap <silent>       <C-p>            :Rg<CR>
nnoremap <silent>       <leader>/        :call Twf()<CR>
nnoremap <silent>       <leader>:        :Commands<CR>
nnoremap <silent>       <leader>.        :Filetypes<CR>
nnoremap <silent>       <leader>b        :Buffers<CR>
nnoremap <silent>       <leader>c        :BCommits!<CR>
nnoremap <silent>       <localleader>c   :Commits!<CR>
nnoremap <silent>       <leader>f        :Lines!<CR>
nnoremap <silent>       <leader>h        :Helptags<CR>
nnoremap <silent>       <leader>l        :BLines<CR>
nnoremap <silent>       <leader>s        :Snippets<CR>
imap                    <c-x><c-k>       <plug>(fzf-complete-word)
imap                    <c-x><c-f>       <plug>(fzf-complete-path)
imap                    <c-x><c-l>       <plug>(fzf-complete-line)
" fugitive
nnoremap <silent>       <leader>d        :Gdiff<CR>
nnoremap <silent>       <leader>g        :Git<CR>
nnoremap <silent>       <leader>gd       :diffget //2<CR>
nnoremap <silent>       <leader>gj       :diffget //3<CR>
" Miscellaneous
nnoremap <silent>       <leader><space>  <C-^>
nnoremap                <leader>e        :e <C-r>=expand("%p:h")<CR>/
nnoremap <silent>       <leader>n        :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>
nnoremap <silent>       <leader>p        "+P
nnoremap <silent>       <leader>q        :q<CR>
nnoremap                <leader>r        :%s///gc<left><left><left>
xnoremap                <leader>r        :s///gc<left><left><left>
nnoremap <silent>       <localleader>s   :UltiSnipsEdit<CR>
nnoremap <silent>       <leader>t        :tabedit %<cr>
nnoremap <silent>       <localleader>t   :ColorizerToggle<CR>
nnoremap <silent>       <leader>u        <C-r>
nnoremap <silent>       <leader>v        :vert sb#<CR>
nnoremap <silent>       <leader>w        :silent! w<CR>
nnoremap <silent>       <leader>x        :silent! x<CR>

" Turn on when useful
" nnoremap <silent>       <leader>dt       :windo diffthis
