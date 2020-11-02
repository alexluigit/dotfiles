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

" InGitRepository() tells us if the directory we are currently working in
" is a git repository. It makes use of the 'git rev-parse --is-inside-work-tree'
" command. This command outputs true to the shell if so, and a STDERR message
" otherwise.
"
" We will use this function to know whether we should open a specific
" project's todo list, or a global todo list.
function s:InGitRepository()
  :silent let bool = system("git rev-parse --is-inside-work-tree")

  " The git function will return true with some leading characters
  " if we are in a repository. So, we split off those characters
  " and just check the first word.
  if split(bool, '\v\n')[0] == 'true'
    return 1
  endif
endfunction


" GetToplevelFolder() gives us a clean name of the git repository that we are
" currently working in
function s:GetToplevelFolder()
  let absolute_path = system("git rev-parse --show-toplevel")
  let repo_name = split(absolute_path, "/")
  let repo_name_clean = split(repo_name[-1], '\v\n')[0]
  return repo_name_clean
endfunction


" GetBujoFilePath() returns which file path we will be using. If we are in a
" git repository, we return the directory for that specific git repo.
" Otherwise, we return the general file path.
"
" If we are passed an argument, it means that the user wants to open the
" general bujo file, so we also return the general file path in that case
function s:GetBujoFilePath(general)
  if a:general || !s:InGitRepository()
    return g:bujo#todo_file_path . "/todo.md"
  else
    let repo_name = s:GetToplevelFolder()
    let todo_path = g:bujo#todo_file_path . "/" . repo_name
    if empty(glob(todo_path))
      call mkdir(todo_path)
    endif
    return todo_path . "/todo.md"
  endif
endfunction


" todo#open() opens the respective todo.md file from $HOME/.cache/bujo
" If we are in a git repository, we open the todo.md for that git repository.
" Otherwise, we open the global todo file.
"
" Paramaters :
"
"   mods - allows a user to use <mods> (see :h mods)
"
"   ... - any parameter after calling :Todo will mean that the user wants
"   us to open the general file path. We check this with a:0
function todo#open(mods, ...)
  let g:todo_marker = line('.')
  let general_bool = a:0
  let todo_path = s:GetBujoFilePath(general_bool)
  exe a:mods . " " . g:bujo#window_width "vs  " . todo_path
endfunction
