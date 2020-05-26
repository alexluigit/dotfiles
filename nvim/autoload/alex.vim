 function! alex#root(path, buftype) abort
   let dir = fnamemodify(a:path, ':p:h')
   if !empty(a:buftype) || !isdirectory(dir)
     return
   else
     let root = finddir('.git', dir .';')
     if !empty(root) | execute 'lcd' fnameescape(fnamemodify(root, ':h')) | endif
   endif
 endfunction
