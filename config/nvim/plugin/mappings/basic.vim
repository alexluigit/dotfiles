let mapleader=" "

nmap                     <C-b>        <C-v>
nmap     <silent>         go          :silent! !xdg-open <cfile><CR>
nmap     <silent>         gx          :TODO:openInBrowser
" Window navigation and resize
" Note: <C-:>, <C-'>, <C-Cr> map to F2, F3, F4 in terminal emulator
nnoremap <silent>        <C-h>        :wincmd h<CR>
nnoremap <silent>        <F3>         :wincmd l<CR>
nnoremap <silent>        <C-j>        :wincmd j<CR>
nnoremap <silent>        <C-k>        :wincmd k<CR>
nnoremap <silent>        <M-h>        :vert resize -5<CR>
nnoremap <silent>        <M-'>        :vert resize +5<CR>
nnoremap <silent>        <M-j>        :resize -5<CR>
nnoremap <silent>        <M-k>        :resize +5<CR>
" Emacs keybinding
cnoremap                 <C-b>        <Left>
cnoremap                 <C-f>        <Right>
cnoremap                 <F6>         <Home>
cnoremap                 <C-o>        <End>
cnoremap                 <C-n>        <Down>
cnoremap                 <C-e>        <Up>
cnoremap                 <F2>         <Del>
inoremap                 <C-b>        <Left>
inoremap                 <C-f>        <Right>
inoremap                 <F6>         <Home>
inoremap                 <C-o>        <End>
inoremap                 <F2>         <Del>
