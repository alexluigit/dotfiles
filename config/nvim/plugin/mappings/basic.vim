" Open file/link under cursor
nmap     <silent>         go          :silent! !open <cfile><CR>
nmap     <silent>         gx          :TODO:openInBrowser
" Start interactive EasyAlign
xmap                      ga          <Plug>(EasyAlign)
nmap                      ga          <Plug>(EasyAlign)
" Verticle line move
vnoremap <silent>         J           :m '>+1<CR>gv=gv
vnoremap <silent>         K           :m '<-2<CR>gv=gv
" Vifm replace netrw
nnoremap <silent>         -           :EditVifm <bar> setl statusline=%#Normal#<cr>
" <CR> to repeat last macro
nnoremap <silent> <expr> <CR>         empty(&buftype) ? '@@' : '<CR>'
" Window navigation and resize
nnoremap <silent>        <C-h>        :wincmd h<CR>
nnoremap <silent>        <Down>       :wincmd j<CR>
nnoremap <silent>        <Up>         :wincmd k<CR>
nnoremap <silent>        <C-l>        :wincmd l<CR>
nnoremap <silent>        <M-h>        :vert resize -5<CR>
nnoremap <silent>        <M-j>        :resize -5<CR>
nnoremap <silent>        <M-k>        :resize +5<CR>
nnoremap <silent>        <M-l>        :vert resize +5<CR>
" Emacs keybinding
cnoremap                 <C-b>        <Left>
cnoremap                 <C-f>        <Right>
cnoremap                 <F2>         <S-Left>
cnoremap                 <F3>         <S-Right>
cnoremap                 <F6>         <Home>
cnoremap                 <C-o>        <End>
inoremap                 <C-b>        <Left>
inoremap                 <C-f>        <Right>
inoremap                 <F2>         <S-Left>
inoremap                 <F3>         <S-Right>
inoremap                 <F6>         <Home>
inoremap                 <C-o>        <End>
