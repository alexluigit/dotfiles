let mapleader = ' '
nmap     <silent>         go          :silent! !xdg-open <cfile><CR>
" Window navigation and resize
" Note: <C-:>, <C-'>, <C-Cr> map to F2, F3, F4 in terminal emulator
noremap  <silent>        <c-h>        :GlobalNavigate h<CR>
noremap  <silent>        <c-j>        :GlobalNavigate j<CR>
noremap  <silent>        <c-k>        :GlobalNavigate k<CR>
noremap  <silent>        <c-l>        :GlobalNavigate l<CR>
nnoremap <silent>        <m-h>        :vert resize -5<CR>
nnoremap <silent>        <m-i>        :vert resize +5<CR>
nnoremap <silent>        <m-n>        :resize -5<CR>
nnoremap <silent>        <m-e>        :resize +5<CR>
" Emacs keybinding
cnoremap                 <c-a>        <Home>
cnoremap                 <F5>         <End>
cnoremap                 <F6>         <Left>
cnoremap                 <c-o>        <Right>
cnoremap                 <c-d>        <Del>
inoremap                 <c-a>        <Home>
inoremap                 <F5>         <End>
inoremap                 <F6>         <Left>
inoremap                 <c-o>        <Right>
inoremap                 <c-d>        <Del>
