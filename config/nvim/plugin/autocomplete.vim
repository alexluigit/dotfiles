nmap     <silent>         gd              <Plug>(coc-definition)
nmap     <silent>         gy              <Plug>(coc-type-definition)
nmap     <silent>         gr              <Plug>(coc-references)
nmap     <silent>         gm              <Plug>(coc-implementation)
nnoremap <silent>         K               :call CocAction('doHover')<cr>
nmap     <silent>         <C-s>           <Plug>(coc-range-select)
nmap     <silent>         <leader>j       <Plug>(coc-diagnostic-next)
nmap     <silent>         <leader>k       <Plug>(coc-diagnostic-prev)
inoremap <silent> <expr>  <tab>           pumvisible() ? coc#_select_confirm() : '<tab>'
inoremap <silent>         <C-j>           <C-R>=(<SID>ctrl_j())<CR>
inoremap <silent>         <C-k>           <C-R>=(<SID>ctrl_k())<CR>

let g:UltiSnipsExpandTrigger = '<nop>'
let g:UltiSnipsJumpForwardTrigger = '<nop>'
let g:UltiSnipsJumpBackwardTrigger = '<nop>'
let g:UltiSnipsEditSplit="vertical" " Edit snippets in vert split
let g:UltiSnipsSnippetDirectories=["ultisnips"] " Default path is uppercase

let g:ulti_jump_forwards_res = 0
function! s:ctrl_j() abort
  if pumvisible() | return "\<C-n>" | endif
  call UltiSnips#JumpForwards()
  if g:ulti_jump_forwards_res > 0 | return "" | endif
  return coc#refresh()
endfunction

let g:ulti_jump_backwards_res = 0
function! s:ctrl_k() abort
  if pumvisible() | return "\<C-p>" | endif
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res > 0 | return "" | endif
  return coc#refresh()
endfunction

" " extensions
" let g:coc_global_extensions = [
"   \ 'coc-tsserver',
"   \ 'coc-vimlsp',
"   \ 'coc-python',
"   \ 'coc-json',
"   \ 'coc-yaml',
"   \ 'coc-tailwindcss',
"   \ 'coc-ultisnips',
"   \ 'coc-git',
"   \ 'coc-prettier',
"   \ ]
"
" ---------------- deoplete + ultisnip ------------------
" let s:deoplete_init_done=0
" function! s:deoplete_init() abort
"   if s:deoplete_init_done || !has('nvim') | return | endif
"   let s:deoplete_init_done=1 | call deoplete#enable()
"   call deoplete#custom#source('file', 'rank', 2000)
"   call deoplete#custom#source('ultisnips', 'rank', 1000)
"   call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" endfunction

" call alex#lazy#defer('call <SID>deoplete_init()')
"
" let g:UltiSnipsExpandTrigger = '<C-t>'
" let g:UltiSnipsEditSplit="vertical" " Edit snippets in vert split
"
" let g:ulti_expand_or_jump_res = 0 " Set once for HandleTab function
" function! HandleTab() abort
"   " First, try to expand or jump on UltiSnips.
"   call UltiSnips#ExpandSnippet()
"   if g:ulti_expand_res > 0 | return "" | endif
"   " Then, check if we're in a completion menu
"   if pumvisible() | return "\<C-n>" | endif
"   " Then check if we're indenting.
"   let col = col('.') - 1
"   if !col || getline('.')[col - 1] =~ '\s'
"     return "\<Tab>"
"   endif
"   " Finally, trigger deoplete completion.
"   return deoplete#manual_complete()
" endfunction
"
" inoremap <silent> <Tab> <C-R>=HandleTab()<CR>
"
" " Close preview window when complete finishes
" au! CompleteDone * if pumvisible() == 0 | pclose | endif
