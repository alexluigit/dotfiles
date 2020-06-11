let g:coc_data_home = '~/.config/nvim/coc'
" textobj
xmap                      af              <Plug>(coc-funcobj-a)
omap                      af              <Plug>(coc-funcobj-a)
xmap                      ac              <Plug>(coc-classobj-a)
omap                      ac              <Plug>(coc-classobj-a)
xmap                      if              <Plug>(coc-funcobj-i)
omap                      if              <Plug>(coc-funcobj-i)
xmap                      ic              <Plug>(coc-classobj-i)
omap                      ic              <Plug>(coc-classobj-i)
" keybind
nmap     <silent>         gd              <Plug>(coc-definition)
nmap     <silent>         gy              <Plug>(coc-type-definition)
nmap     <silent>         gr              <Plug>(coc-references)
nmap     <silent>         gi              <Plug>(coc-implementation)
nmap                      [g              <Plug>(coc-git-prevchunk)
nmap                      ]g              <Plug>(coc-git-nextchunk)
nmap     <silent>        <leader>j        <Plug>(coc-diagnostic-next)
nmap     <silent>        <leader>k        <Plug>(coc-diagnostic-prev)
nmap                     <leader>qf       <Plug>(coc-fix-current)
inoremap          <expr> <CR>             exists('*complete_info') ? complete_info()['selected'] != '-1' ? '<C-y>' : '<C-g>u<CR>' : pumvisible() ? '<C-y>' : '<C-g>u<CR>'
inoremap <silent> <expr> <TAB>            pumvisible() ? '<C-n>' : <SID>check_backspace() ? '<TAB>' : coc#refresh()
inoremap <silent> <expr> <S-TAB>          pumvisible() ? '<C-p>' : '<C-h>'

function! s:check_backspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
