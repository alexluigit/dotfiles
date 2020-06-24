call alex#autocmds#defer('call alex#autocmds#deoplete_init()')

let g:UltiSnipsExpandTrigger = '<C-t>'
let g:UltiSnipsEditSplit="vertical" " Edit snippets in vert split

let g:ulti_expand_or_jump_res = 0 " Set once for HandleTab function
function! HandleTab() abort
  " First, try to expand or jump on UltiSnips.
  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0 | return "" | endif
  " Then, check if we're in a completion menu
  if pumvisible() | return "\<C-n>" | endif
  " Then check if we're indenting.
  let col = col('.') - 1
  if !col || getline('.')[col - 1] =~ '\s'
    return "\<Tab>"
  endif
  " Finally, trigger deoplete completion.
  return deoplete#manual_complete()
endfunction

inoremap <silent> <Tab> <C-R>=HandleTab()<CR>
