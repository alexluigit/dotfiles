nnoremap                  *               :keepjumps normal! mp*`p<cr>
xnoremap                  *               ymp:keepjumps normal! /\V<C-r>=escape(@",'/\')<cr><C-v><C-m>`p<cr>
vnoremap                  <               <gv
vnoremap                  >               >gv
nmap     <silent>         go              :silent! !open <cfile><CR>
nnoremap <expr>           k               (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr>           j               (v:count > 5 ? "m'" . v:count : '') . 'j'
vnoremap <silent>         J               :m '>+1<CR>gv=gv
vnoremap <silent>         K               :m '<-2<CR>gv=gv
noremap  <silent>         n               :keepjumps normal! n<cr>
noremap  <silent>         N               :keepjumps normal! N<cr>
nnoremap                  Q               q
nnoremap                  q               <Nop>
vnoremap                  X               "_d
noremap                   Y               y$
nnoremap <silent> <expr> <CR>             empty(&buftype) ? '@@' : '<CR>'
nnoremap                 <Tab>            za
nnoremap                 <F6>             <C-i>
