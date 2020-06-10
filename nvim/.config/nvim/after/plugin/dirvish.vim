" ----------  dirvish  ------------
let g:dirvish_mode = ':sort ,^.*[\/],'
augroup DirvishMapping
  autocmd!
  autocmd FileType dirvish nnoremap <nowait><buffer><silent> l :<C-U>.call dirvish#open('edit', 0)<CR>
  autocmd FileType dirvish nmap     <nowait><buffer><silent> h <Plug>(dirvish_up)
  autocmd FileType dirvish nmap     <nowait><buffer><silent> q <Plug>(dirvish_quit)
  autocmd FileType dirvish nnoremap <nowait><silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  autocmd FileType dirvish xnoremap <nowait><silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  " Seeing as g:WincentColorColumnFileTypeBlacklist doesn't work for this:
  " autocmd FileType dirvish set winhl=Normal:Normal,NormalNC:Normal
  autocmd FileType dirvish setlocal norelativenumber
augroup END
