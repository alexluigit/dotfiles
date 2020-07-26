" let s:expansion_active = 0
"
" function! alex#autocomp#setup_mappings() abort
"   " Overwrite the mappings that UltiSnips sets up during expansion.
"   execute 'snoremap <buffer> <silent> ' . g:UltiSnipsJumpForwardTrigger .
"         \ ' <Esc>:call alex#autocomp#expand_or_jump("N")<CR>'
"   execute 'snoremap <buffer> <silent> ' . g:UltiSnipsJumpBackwardTrigger .
"         \ ' <Esc>:call alex#autocomp#expand_or_jump("P")<CR>'
"   execute 'inoremap <buffer> <silent> ' . g:UltiSnipsJumpForwardTrigger .
"         \ ' <C-R>=alex#autocomp#expand_or_jump("N")<CR>'
"   execute 'inoremap <buffer> <silent> ' . g:UltiSnipsJumpBackwardTrigger .
"         \ ' <C-R>=alex#autocomp#expand_or_jump("P")<CR>'
"   let s:expansion_active = 1
" endfunction
"
" function! alex#autocomp#teardown_mappings() abort
"   let s:expansion_active = 0
" endfunction
"
" let g:ulti_jump_backwards_res = 0
" let g:ulti_jump_forwards_res = 0
" let g:ulti_expand_res = 0
"
" function! alex#autocomp#expand_or_jump(direction) abort
"   call UltiSnips#ExpandSnippet()
"   if g:ulti_expand_res == 0
"     " No expansion occurred.
"     if pumvisible()
"       " Pop-up is visible, let's select the next (or previous) completion.
"       if a:direction ==# 'N'
"         return "\<C-N>"
"       else
"         return "\<C-P>"
"       endif
"     else
"       if s:expansion_active
"         if a:direction ==# 'N'
"           call UltiSnips#JumpForwards()
"           if g:ulti_jump_forwards_res == 0
"             " We did not jump forwards.
"             return "\<Tab>"
"           endif
"         else
"           call UltiSnips#JumpBackwards()
"         endif
"       else
"         if a:direction ==# 'N'
"           " return alex#autocomp#smart_tab()
"           return 'hello'
"         endif
"       endif
"     endif
"   endif
"
"   " No popup is visible, a snippet was expanded, or we jumped, or we failed to
"   " jump backwards, so nothing to do.
"   return ''
" endfunction

