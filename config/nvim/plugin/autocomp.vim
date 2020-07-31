inoremap <expr><silent>   <Tab>           <SID>tab()
inoremap <expr><silent>   <CR>            <SID>enter()
inoremap <expr><silent>   <C-j>           <SID>ctrl_j()
inoremap <expr><silent>   <C-k>           <SID>ctrl_k()
imap                      <C-d>           <plug>Isurround
imap                      <C-x><C-k>      <plug>(fzf-complete-word)
imap                      <C-x><C-f>      <plug>(fzf-complete-path)
imap                      <C-x><C-l>      <plug>(fzf-complete-line)

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

function! s:ctrl_j() abort
  if pumvisible() | return "\<C-n>" | else | return "\<Esc>o" | endif
endfunction

function! s:ctrl_k() abort
  if pumvisible() | return "\<C-p>" | else | return "\<Esc>O" | endif
endfunction

let g:UltiSnipsEditSplit="vertical" " Edit snippets in vert split
let g:UltiSnipsSnippetDirectories=["ultisnips"] " Default path is uppercase
let g:UltiSnipsExpandTrigger = '<F4>' " <C-cr>
let g:UltiSnipsListSnippets = '<nop>'
let g:UltiSnipsJumpForwardTrigger = '<nop>'
let g:UltiSnipsJumpBackwardTrigger = '<nop>'
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

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
"   \ 'coc-snippets',
"   \ 'coc-git',
"   \ 'coc-prettier',
"   \ ]
