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
" Map <F1> to toggle a side terminal window
" https://gist.github.com/ram535/b1b7af6cd7769ec0481eb2eed549ea23#file-gistfile1-vim-L4
nnoremap <silent>        <F1>         :call MonkeyTerminalToggle()<CR>
tnoremap <silent>        <F1>          <C-\><C-n>:call MonkeyTerminalToggle()<CR>
" Toggle comment using tcomment_vim
nmap                     <C-c>        gc
xmap                     <C-c>        gc
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
cnoremap                 <C-a>        <Home>
cnoremap                 <C-e>        <End>
cnoremap                 <C-b>        <S-Left>
cnoremap                 <C-f>        <S-Right>
" Map <cmd-hjkl> to arrow keys in karabiner or other mapping programs
nnoremap <silent>        <Up>         :cprevious<CR>
nnoremap <silent>        <Down>       :cnext<CR>
nnoremap <silent>        <Left>       :cpfile<CR>
nnoremap <silent>        <Right>      :cnfile<CR>
" If popup menu is visiable, use C-j,k to navigate
inoremap <silent> <expr> <C-j>        pumvisible() ? '<C-n>' : '<C-j>'
inoremap <silent> <expr> <C-k>        pumvisible() ? '<C-p>' : '<C-k>'
