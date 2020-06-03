nnoremap                  *               :keepjumps normal! mp*`p<cr>
xnoremap                  *               ymp:keepjumps normal! /\V<C-r>=escape(@",'/\')<cr><C-v><C-m>`p<cr>
vnoremap                  <               <gv
vnoremap                  >               >gv
xmap                      af              <Plug>(coc-funcobj-a)
omap                      af              <Plug>(coc-funcobj-a)
xmap                      ac              <Plug>(coc-classobj-a)
nmap     <silent>         go              :silent! !open <cfile><CR>
omap                      ac              <Plug>(coc-classobj-a)
nmap     <silent>         gd              <Plug>(coc-definition)
nmap     <silent>         gy              <Plug>(coc-type-definition)
nmap     <silent>         gr              <Plug>(coc-references)
nmap     <silent>         gi              <Plug>(coc-implementation)
nmap                      [g              <Plug>(coc-git-prevchunk)
nmap                      ]g              <Plug>(coc-git-nextchunk)
xmap                      if              <Plug>(coc-funcobj-i)
omap                      if              <Plug>(coc-funcobj-i)
xmap                      ic              <Plug>(coc-classobj-i)
omap                      ic              <Plug>(coc-classobj-i)
inoremap                  jj              <Esc>
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
inoremap          <expr> <CR>             exists('*complete_info') ? complete_info()['selected'] != '-1' ? '<C-y>' : '<C-g>u<CR>' : pumvisible() ? '<C-y>' : '<C-g>u<CR>'
nnoremap <silent> <expr> <CR>             empty(&buftype) ? '@@' : '<CR>'
inoremap <silent> <expr> <TAB>            pumvisible() ? '<C-n>' : alex#general#checkbs() ? '<TAB>' : coc#refresh()
inoremap <silent> <expr> <S-TAB>          pumvisible() ? '<C-p>' : '<C-h>'
nnoremap                 <Tab>            za
nnoremap <silent>        <F4>             :Helptags<CR>
nnoremap                 <F6>             <C-i>
