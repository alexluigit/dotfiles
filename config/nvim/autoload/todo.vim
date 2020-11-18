function! todo#marker() abort
  let s:filename = expand('#')
  let s:current_line = line('.')
  let @a = " [Ref](" . s:filename . ":" . g:todo_marker . ")"
  call append('.', @a)
  normal! J
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

function todo#open(mods, ...)
  let g:todo_marker = line('.')
  let general_bool = a:0
  let todo_path = s:GetTodoFilePath(general_bool)
"   mods - allows a user to use <mods> (see :h mods)
  exe a:mods . " " . g:bujo#window_width "vs  " . todo_path
  setl nonu norelativenumber
endfunction

function s:GetTodoFilePath(general)
  if a:general || !alex#git#isGitRepo()
    return g:bujo#todo_file_path . "/todo.md"
  else
    let repo_name = alex#git#toplevel()
    let todo_path = g:bujo#todo_file_path . "/" . repo_name
    if empty(glob(todo_path))
      call mkdir(todo_path)
    endif
    return todo_path . "/todo.md"
  endif
endfunction
