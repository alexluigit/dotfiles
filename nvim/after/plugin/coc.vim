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
nnoremap <silent>         K               :call CocAction('doHover')<cr>
nmap     <silent>         <C-s>           <Plug>(coc-range-select)
inoremap <silent> <expr>  <C-l>           coc#refresh()
inoremap <silent> <expr>  <TAB>           pumvisible() ? coc#_select_confirm() : '<TAB>'  
nmap     <silent>         <leader>j       <Plug>(coc-diagnostic-next)
nmap     <silent>         <leader>k       <Plug>(coc-diagnostic-prev)
nmap                      <leader>a       <Plug>(coc-codeaction)

" extensions
" let g:coc_global_extensions = [
"   \ 'coc-snippets',
"   \ 'coc-tsserver',
"   \ 'coc-emoji',
"   \ 'coc-yaml',
"   \ 'coc-python',
"   \ 'coc-prettier',
"   \ 'coc-vimlsp',
"   \ 'coc-json',
"   \ 'coc-git'
"   \ ]
