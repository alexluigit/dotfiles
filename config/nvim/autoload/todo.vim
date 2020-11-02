function! todo#launch() abort
  let g:todo_marker = line('.')
  exec "Todo"
endfunction

function! todo#marker() abort
  let s:filename = expand('#')
  let s:current_line = line('.')
  let @a = "[Ref](" . s:filename . ":" . g:todo_marker . ")"
  call append('.', @a)
endfunction

function! todo#addTemplate(tmpl_file)
    exe "0read " . a:tmpl_file
    let substDict = {}
    let substDict["name"] = split(expand('%:p:h:t'), '\v\n')[0]
    let substDict["date"] = strftime("%Y %b %d %X")
    exe '%s/<<\([^>]*\)>>/\=substDict[submatch(1)]/g'
    set nomodified
    normal G
endfunction
