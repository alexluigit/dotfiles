inoremap <expr><silent>   <Tab>           <SID>tab()
inoremap <expr><silent>   <CR>            <SID>enter()
inoremap <expr><silent>   <C-j>           <SID>ctrl_j()
inoremap <expr><silent>   <C-k>           <SID>ctrl_k()
imap                      <C-x><C-k>      <plug>(fzf-complete-word)
imap                      <C-x><C-f>      <plug>(fzf-complete-path)
imap                      <C-x><C-l>      <plug>(fzf-complete-line)

" Prevent UltiSnips from removing our carefully-crafted mappings.
let g:UltiSnipsMappingsToIgnore = ['autocomp']
let g:UltiSnipsEditSplit="vertical" " Edit snippets in vert split
let g:UltiSnipsSnippetDirectories=["ultisnips"] " Default path is uppercase
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsListSnips = '<nop>'
let g:UltiSnipsJumpForwardTrigger = '<nop>'
let g:UltiSnipsJumpBackwardTrigger = '<nop>'
let g:coc_snippet_next = '<nop>'
let g:coc_snippet_prev = '<nop>'

function! s:tab() abort
  call UltiSnips#ExpandSnippetOrJump()
  if pumvisible() | return coc#_select_confirm() | endif
  let lastcol = col('.') - 1
  let lastchar = getline('.')[col('.') - 2]
  if !lastcol || lastchar =~# '\s' | return "\<Tab>" | endif
  return coc#refresh()
endfunction

""--------------------------------------------------------------------------""
"                                  sy                                        "
""--------------------------------------------------------------------------""






















" augroup AlexAutocomplete
"   autocmd!
"   autocmd! User UltiSnipsEnterFirstSnippet
"   autocmd User UltiSnipsEnterFirstSnippet call alex#autocomp#setup_mappings()
"   autocmd! User UltiSnipsExitLastSnippet
"   autocmd User UltiSnipsExitLastSnippet call alex#autocomp#teardown_mappings()
" augroup END

function! s:ctrl_j() abort
  if pumvisible() | return "\<C-n>" | endif
  if coc#jumpable() " then try to jump
    return "\<C-r>=coc#rpc#request('snippetNext',[])\<CR>"
    " return "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
  endif
  return "\<C-j>"
endfunction

function! s:ctrl_k() abort
  if pumvisible() | return "\<C-p>" | endif
  if coc#jumpable()
    return "\<C-r>=coc#rpc#request('snippetPrev',[])\<CR>"
  endif
  return "\<C-k>"
endfunction

function! s:enter() abort
  let symbols = [ '}', ']' ]
  let nextchar = getline('.')[col('.') - 1]
  if nextchar =~# '\s' | let nextchar = getline('.')[col('.')] | endif
  if index(symbols, nextchar) != -1 | return "\<CR>\<Esc>O"
  else | return "\<CR>" | endif
endfunction

" let g:coc_snippet_next = '<tab>'
" let g:coc_snippet_prev = '<C-b>'

" function! s:tab() abort
"   if pumvisible() | return coc#_select_confirm() | endif
"   if coc#expandableOrJumpable() " then try to expand or jump
"     return "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
"   endif
"   let lastcol = col('.') - 1
"   let lastchar = getline('.')[col('.') - 2]
"   if !lastcol || lastchar =~# '\s' | return "\<Tab>" | endif
"   return coc#refresh()
" endfunction

" function! s:enter() abort
"   let symbols = [ '}', ']' ]
"   let nextchar = getline('.')[col('.') - 1]
"   if nextchar =~# '\s' | let nextchar = getline('.')[col('.')] | endif
"   if index(symbols, nextchar) != -1 | return "\<CR>\<Esc>O"
"   else | return "\<CR>" | endif
" endfunction

" function! s:ctrl_j() abort
"   if pumvisible() | return "\<C-n>" | endif
"   return "\<Esc>o"
" endfunction
"
" function! s:ctrl_k() abort
"   if pumvisible() | return "\<C-p>" | endif
"   return "\<Esc>O"
" endfunction

" " extensions
" let g:coc_global_extensions = [
"   \ 'coc-tsserver',
"   \ 'coc-rls',
"   \ 'coc-vimlsp',
"   \ 'coc-python',
"   \ 'coc-json',
"   \ 'coc-yaml',
"   \ 'coc-tailwindcss',
"   \ 'coc-ultisnips',
"   \ 'coc-git',
"   \ 'coc-prettier',
"   \ ]
