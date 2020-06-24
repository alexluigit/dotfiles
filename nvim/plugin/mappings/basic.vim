" Do not jump to next when searching with *
nnoremap                  *               :keepjumps normal! mp*`p<cr>
xnoremap                  *               ymp:keepjumps normal! /\V<C-r>=escape(@",'/\')<cr><C-v><C-m>`p<cr>
" Better visual indenting
vnoremap                  <               <gv
vnoremap                  >               >gv
" Open file under cursor
nmap     <silent>         go              :silent! !open <cfile><CR>
" 6j movement should add to jumplist
nnoremap <expr>           k               (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr>           j               (v:count > 5 ? "m'" . v:count : '') . 'j'
" Verticle line move
vnoremap <silent>         J               :m '>+1<CR>gv=gv
vnoremap <silent>         K               :m '<-2<CR>gv=gv
" Don't add n and N movement to jumplist
noremap  <silent>         n               :keepjumps normal! n<cr>
noremap  <silent>         N               :keepjumps normal! N<cr>
" Disable EX mode
nnoremap                  Q               <Nop>
" Yank to end of line
noremap                   Y               y$
" <CR> to repeat last macro
nnoremap <silent> <expr> <CR>             empty(&buftype) ? '@@' : '<CR>'
" https://gist.github.com/ram535/b1b7af6cd7769ec0481eb2eed549ea23#file-gistfile1-vim-L4
nnoremap <silent>        <F1>             :call MonkeyTerminalToggle()<CR>
tnoremap <silent>        <F1>             <C-\><C-n>:call MonkeyTerminalToggle()<CR>
" Map <C-i> to <F6> in terminal emulator, it will solove <TAB> and <C-i> hijack
nnoremap                 <Tab>            za
nnoremap                 <F6>             <C-i>
" <C-:> , <C-'> map to F2, F3
nnoremap <silent>        <F2>             :tabprev<CR>
nnoremap <silent>        <F3>             :tabnext<CR>
" Window navigation and resize
nnoremap <silent>        <C-h>            :wincmd h<CR>
nnoremap <silent>        <C-j>            :wincmd j<CR>
nnoremap <silent>        <C-k>            :wincmd k<CR>
nnoremap <silent>        <C-l>            :wincmd l<CR>
nnoremap <silent>        <M-h>            :vert resize -5<CR>
nnoremap <silent>        <M-j>            :resize -5<CR>
nnoremap <silent>        <M-k>            :resize +5<CR>
nnoremap <silent>        <M-l>            :vert resize +5<CR>
" Emacs binding is useful here
cnoremap                 <C-a>            <Home>
cnoremap                 <C-e>            <End>
cnoremap                 <C-b>            <S-Left>
cnoremap                 <C-f>            <S-Right>
" If popup menu is visiable, use C-j,k to navigate
inoremap <silent> <expr> <C-j>            pumvisible() ? '<C-n>' : '<C-j>'
inoremap <silent> <expr> <C-k>            pumvisible() ? '<C-p>' : '<C-k>'
