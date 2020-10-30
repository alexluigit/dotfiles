" search / replace
nnoremap <silent>       <C-f>            yiw:BLines<CR>
xnoremap <silent>       <C-f>            ygv:<C-u>BLines <C-r>0<CR>
nnoremap <silent>       <F2>             :Files<CR>
nnoremap                <leader>pw       :CocSearch <C-r>=expand("<cword>")<CR>
xnoremap <silent>       <leader>pw       y:CocSearch <C-r>0<CR>/<C-r>0<CR>
nnoremap                <leader>r        :%s///gc<left><left><left>
xnoremap                <leader>r        :s///gc<left><left><left>

" macros
nnoremap <silent>       -                :EditVifm <bar> setl statusline=%#Normal#<cr>
nnoremap <silent>       <leader>/        :call Twf()<CR>
nnoremap <silent>       <leader>;        :Commands<CR>
nnoremap <silent>       <leader>.        :Filetypes<CR>
nnoremap <silent>       <leader>b        :Buffers<CR>
nnoremap <silent>       <leader>c        :BCommits!<CR>
nnoremap <silent>       <leader>f        :Lines<CR>
nnoremap <silent>       <leader>h        :Helptags<CR>

" navigation
nmap     <silent>       <leader>n        <Plug>(coc-diagnostic-next)
nmap     <silent>       <leader>e        <Plug>(coc-diagnostic-prev)
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

" buftabs
nnoremap <silent>       <leader><space>  <C-^>
nmap                    <leader>1        <Plug>BufTabLine.Go(1)
nmap                    <leader>2        <Plug>BufTabLine.Go(2)
nmap                    <leader>3        <Plug>BufTabLine.Go(3)
nmap                    <leader>4        <Plug>BufTabLine.Go(4)
nmap                    <leader>5        <Plug>BufTabLine.Go(5)
nmap                    <leader>6        <Plug>BufTabLine.Go(6)
nmap                    <leader>7        <Plug>BufTabLine.Go(7)
nmap                    <leader>8        <Plug>BufTabLine.Go(8)
nmap                    <leader>9        <Plug>BufTabLine.Go(9)
nmap                    <leader>0        <Plug>BufTabLine.Go(10)

" t for toggle [ to: "o"nly | tn: "n"umber | tt: "t"odo ]
nnoremap <silent>       <leader>to       :tabedit %<cr>
nnoremap <silent>       <leader>tn       :set relativenumber!<CR>
nnoremap <silent>       <leader>tt       :call alex#utils#todo_launch()<cr>

" miscellaneous
nmap     <silent>       <F4>             gcc
xmap     <silent>       <F4>             gc
nmap                    <F5>             :call alex#utils#syntax_group()<CR>
xmap                    ga               <Plug>(EasyAlign)
nmap                    ga               <Plug>(EasyAlign)
nnoremap <silent>       E                :call CocAction('doHover')<CR>
nmap     <silent>       <C-s>            <Plug>(coc-range-select)
xmap     <silent>       <C-s>            <Plug>(coc-range-select)
nnoremap                <leader>a        :CocAction<CR>
nnoremap                <leader>j        :Rename<Space>
nnoremap <silent>       <leader>k        :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR>
nnoremap <silent><expr> <leader>q        len(getbufinfo({'buflisted':1})) > 1 ? ':bd<CR>' : ':q<CR>'
nnoremap <silent>       <leader>s        :CocCommand snippets.openSnippetFiles<CR>
nnoremap <silent>       <leader>v        :VsplitVifm <bar> setl statusline=%#Normal#<cr>
nnoremap <silent>       <leader>w        :silent! w<CR>
nnoremap <silent>       <leader>x        :silent! x<CR>
