nnoremap <silent>       E                :call CocAction('doHover')<CR>
nmap     <silent>       gd               <Plug>(coc-definition)
nmap     <silent>       gy               <Plug>(coc-type-definition)
nmap     <silent>       gr               <Plug>(coc-references)
nmap     <silent>       gm               <Plug>(coc-implementation)
inoremap <expr><silent> <Tab>            <SID>tab()
inoremap <expr><silent> <CR>             <SID>enter()
inoremap <expr><silent> <C-n>            <SID>pumNext()
inoremap <expr><silent> <C-e>            <SID>pumPrev()
nmap     <silent>       <C-s>            <Plug>(coc-range-select)
xmap     <silent>       <C-s>            <Plug>(coc-range-select)
snoremap <silent><expr> <Down>           coc#float#has_scroll() ? coc#float#scroll(1) : "\<Down>"
snoremap <silent><expr> <Up>             coc#float#has_scroll() ? coc#float#scroll(0) : "\<Up>"
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

function! s:enter() abort
  let symbols = [ '}', ']' ]
  let nextchar = getline('.')[col('.') - 1]
  if nextchar =~# '\s' | let nextchar = getline('.')[col('.')] | endif
  if index(symbols, nextchar) != -1 | return "\<CR>\<Esc>O"
  else | return "\<CR>" | endif
endfunction

function! s:tab() abort
  if pumvisible() | return coc#_select_confirm() | endif
  if coc#expandableOrJumpable() " then try to expand or jump
    return "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
  endif
  let lastcol = col('.') - 1
  let lastchar = getline('.')[col('.') - 2]
  if !lastcol || lastchar =~# '\s' | return "\<Tab>" | endif
  return coc#refresh()
endfunction

function! s:pumNext() abort
  if pumvisible() | return "\<C-n>" | else | return "\<Esc>o" | endif
endfunction

function! s:pumPrev() abort
  if pumvisible() | return "\<C-p>" | else | return "\<Esc>O" | endif
endfunction

" " extensions
" let g:coc_global_extensions = [
"   \ 'coc-tsserver',
"   \ 'coc-rls',
"   \ 'coc-vimlsp',
"   \ 'coc-python',
"   \ 'coc-json',
"   \ 'coc-yaml',
"   \ 'coc-tailwindcss',
"   \ 'coc-snippets',
"   \ 'coc-git',
"   \ 'coc-prettier',
"   \ ]
