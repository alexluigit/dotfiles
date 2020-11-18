let mapleader = ' '
nmap                     <c-b>        <C-v>
nmap     <silent>         go          :silent! !xdg-open <cfile><CR>
" Window navigation and resize
" Note: <C-:>, <C-'>, <C-Cr> map to F2, F3, F4 in terminal emulator
nnoremap <silent>        <c-h>        :wincmd h<CR>
nnoremap <silent>        <F3>         :wincmd l<CR>
nnoremap <silent>        <c-n>        :wincmd j<CR>
nnoremap <silent>        <c-e>        :wincmd k<CR>
nnoremap <silent>        <m-h>        :vert resize -5<CR>
nnoremap <silent>        <m-'>        :vert resize +5<CR>
nnoremap <silent>        <m-n>        :resize -5<CR>
nnoremap <silent>        <m-e>        :resize +5<CR>
" Emacs keybinding
cnoremap                 <c-a>        <Home>
cnoremap                 <F3>         <End>
cnoremap                 <F6>         <Left>
cnoremap                 <c-o>        <Right>
cnoremap                 <c-d>        <Del>
inoremap                 <c-a>        <Home>
inoremap                 <F3>         <End>
inoremap                 <F6>         <Left>
inoremap                 <c-o>        <Right>
inoremap                 <c-d>        <Del>
