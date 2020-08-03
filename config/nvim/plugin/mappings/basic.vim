let mapleader=" "

nmap                     <C-b>        <C-v>
nmap     <silent>         go          :silent! !xdg-open <cfile><CR>
nmap     <silent>         gx          :TODO:openInBrowser
vnoremap <silent>         J           :m '>+1<CR>gv=gv
vnoremap <silent>         K           :m '<-2<CR>gv=gv
nnoremap <silent>         -           :EditVifm <bar> setl statusline=%#Normal#<cr>
" <C-:>, <C-'>, <C-Cr> map to F2, F3, F4 in terminal emulator
nnoremap <silent>        <F2>         :tabprev<CR>
nnoremap <silent>        <F3>         :tabnext<CR>
nnoremap <silent>        <F4>         :cclose<CR>
" Window navigation and resize
nnoremap <silent>        <C-h>        :wincmd h<CR>
nnoremap <silent>        <C-j>        :wincmd j<CR>
nnoremap <silent>        <C-k>        :wincmd k<CR>
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
cnoremap                 <C-j>        <Down>
cnoremap                 <C-k>        <Up>
inoremap                 <C-b>        <Left>
inoremap                 <C-f>        <Right>
inoremap                 <F2>         <S-Left>
inoremap                 <F3>         <S-Right>
inoremap                 <F6>         <Home>
inoremap                 <C-o>        <End>
