 function! alex#git#dir(path) abort
   let dir = fnamemodify(a:path, ':p:h')
   if !empty(&buftype) || !isdirectory(dir)
     return
   else
     let root = finddir('.git', dir .';')
     if !empty(root) | execute 'tcd' fnameescape(fnamemodify(root, ':h')) | endif
   endif
 endfunction
