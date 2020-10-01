" search / replace
nnoremap <silent>       <C-f>            yiw:BLines<CR>
xnoremap <silent>       <C-f>            ygv:<C-u>BLines <C-r>0<CR>
nnoremap <silent>       <C-p>            :call TryGFiles()<CR>
nnoremap                <leader>pw       :CocSearch <C-r>=expand("<cword>")<CR>
xnoremap <silent>       <leader>pw       y:CocSearch <C-r>0<CR>/<C-r>0<CR>
nnoremap                <leader>r        :%s///gc<left><left><left>
xnoremap                <leader>r        :s///gc<left><left><left>

" find things
nnoremap <silent>       <leader>/        :call Twf()<CR>
nnoremap <silent>       <leader>;        :Commands<CR>
nnoremap <silent>       <leader>.        :Filetypes<CR>
nnoremap <silent>       <leader>b        :Buffers<CR>
nnoremap <silent>       <leader>c        :BCommits!<CR>
nnoremap <silent>       <leader>f        :Lines!<CR>
nnoremap <silent>       <leader>h        :Helptags<CR>

" navigation
nmap     <silent>       <leader>j        <Plug>(coc-diagnostic-next)
nmap     <silent>       <leader>k        <Plug>(coc-diagnostic-prev)
nmap     <silent>       gd               <Plug>(coc-definition)
nmap     <silent>       gy               <Plug>(coc-type-definition)
nmap     <silent>       gr               <Plug>(coc-references)
nmap     <silent>       gm               <Plug>(coc-implementation)

" fugitive / diff
nnoremap <silent>       <leader>d        :Gdiff<CR>
nnoremap <silent>       <leader>da       :diffget //2<CR>
nnoremap <silent>       <leader>dg       :diffget //3<CR>
nnoremap <silent>       <leader>dt       :windo diffthis<CR>
nnoremap <silent>       <leader>g        :Git<CR>

" miscellaneous
xmap                    ga               <Plug>(EasyAlign)
nmap                    ga               <Plug>(EasyAlign)
nnoremap <silent>       K                :call CocAction('doHover')<CR>
nmap     <silent>       <C-s>            <Plug>(coc-range-select)
xmap     <silent>       <C-s>            <Plug>(coc-range-select)
nnoremap <silent>       <leader><space>  <C-^>
nnoremap                <leader>a        :CocAction<CR>
nnoremap                <leader>e        :CocCommand workspace.renameCurrentFile<CR>
nnoremap <silent>       <leader>n        :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR>
nnoremap <silent>       <leader>o        :tabedit %<cr>
nnoremap <silent>       <leader>p        :r !xclip -o -sel clip<CR>
nnoremap <silent>       <leader>q        :q<CR>
nnoremap <silent>       <leader>s        :CocCommand snippets.openSnippetFiles<CR>
nnoremap <silent>       <leader>t        :set relativenumber!<CR>
nnoremap <silent>       <leader>v        :vert sb#<CR>
nnoremap <silent>       <leader>w        :silent! w<CR>
nnoremap <silent>       <leader>x        :silent! x<CR>
nmap                    <F5>             :call alex#utils#syntax_group()<CR>
