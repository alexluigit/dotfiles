" fugitive / diff
nnoremap <silent>       <leader>d        :Gdiff<CR>
nnoremap <silent>       <leader>da       :diffget //2<CR>
nnoremap <silent>       <leader>dg       :diffget //3<CR>
nnoremap <silent>       <leader>dt       :windo diffthis<CR>
nnoremap <silent>       <leader>do       :diffoff<CR>
nnoremap <silent>       <leader>g        :vertical Gstatus<bar>bd#<CR>

" buftabs
nnoremap <silent>       <leader><space>  <C-^>
nmap                    <leader>1        <Plug>BufTabLine.Go(1)
nmap                    <leader>2        <Plug>BufTabLine.Go(2)
nmap                    <leader>3        <Plug>BufTabLine.Go(3)
nmap                    <leader>4        <Plug>BufTabLine.Go(4)
nmap                    <leader>5        <Plug>BufTabLine.Go(5)

" f for file [ f: "f"ind | r: "r"ename | "s": snippets | "a": all | t: "type"]
nnoremap <silent>       -                :EditVifm <bar> setl statusline=%#Normal#<cr>
nnoremap <silent>       <leader>v        :vs <bar> :EditVifm <bar> setl statusline=%#Normal#<cr>
nnoremap <silent>       <leader>f/       :call Twf()<CR>
nnoremap <silent>       <leader>ff       yiw:BLines<CR>
xnoremap <silent>       <leader>ff       ygv:<C-u>BLines <C-r>0<CR>
nnoremap <silent>       <leader>fa       :Lines<CR>
nnoremap                <leader>fr       :Rename<Space>
nnoremap <silent>       <leader>fs       :CocCommand snippets.openSnippetFiles<CR>
nnoremap <silent>       <leader>ft       :Filetypes<CR>

" p for project [ w: "w"ord ]
nnoremap <silent>       <F2>             :Files<CR>
nnoremap                <leader>pw       :CocSearch <C-r>=expand("<cword>")<CR>
xnoremap <silent>       <leader>pw       y:CocSearch <C-r>0<CR>/<C-r>0<CR>

" t for toggle [ o: "o"nly | n: "n"umber | t: "t"odo ]
nnoremap <silent>       <leader>to       :tabedit %<cr>
nnoremap <silent>       <leader>tn       :set relativenumber!<CR>
nnoremap <silent>       <leader>tt       :Todo<cr>

" miscellaneous
nnoremap <silent>       <leader>;        :Commands<CR>
nnoremap <silent>       <leader>c        :BCommits!<CR>
nnoremap <silent>       <leader>h        :Helptags<CR>
nmap     <silent>       <F4>             gcc
xmap     <silent>       <F4>             gc
nmap                    <F5>             :call alex#utils#syntax_group()<CR>
xmap                    ga               <Plug>(EasyAlign)
nmap                    ga               <Plug>(EasyAlign)
nnoremap                <leader>b        :Buffers<CR>
nnoremap <silent>       <leader>k        :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR>
nnoremap <silent><expr> <leader>q        len(getbufinfo({'buflisted':1})) > 1 ? ':bd<CR>' : ':q<CR>'
nnoremap                <leader>r        :%s///gc<left><left><left>
xnoremap                <leader>r        :s///gc<left><left><left>
nnoremap <silent>       <leader>w        :silent! w<CR>
nnoremap <silent>       <leader>x        :silent! x<CR>
