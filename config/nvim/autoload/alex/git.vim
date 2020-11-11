function! alex#git#cd(path) abort
   let dir = fnamemodify(a:path, ':p:h')
   if !empty(&buftype) || !isdirectory(dir)
     return
   else
     let root = finddir('.git', dir .';')
     if !empty(root) | execute 'tcd' fnameescape(fnamemodify(root, ':h')) | endif
   endif
endfunction

function! alex#git#isGitRepo() abort
  call system('git rev-parse --is-inside-work-tree')
  return !v:shell_error
endfunction

function! alex#git#toplevel()
  let absolute_path = system("git rev-parse --show-toplevel")
  let repo_name = split(absolute_path, "/")
  let repo_name_clean = split(repo_name[-1], '\v\n')[0]
  return repo_name_clean
endfunction
