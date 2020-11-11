" Get custom configs
let g:bujo#todo_file_path = get(g:, "bujo#todo_file_path", $HOME . "/.cache/bujo")
let g:bujo#window_width = get(g:, "bujo#window_width", 50)

" Make bujo directory if it doesn't exist"
if empty(glob(g:bujo#todo_file_path))
  call mkdir(g:bujo#todo_file_path)
endif

command! -nargs=? Todo :call todo#open(<q-mods>, <f-args>)

augroup todo
  au!
  au BufNewFile todo.md call todo#addTemplate("~/.local/share/assets/template/todo")
  au BufEnter todo.md setl foldlevel=99
  au BufWritePost todo.md :3s/Date: \zs.*/\=strftime('%Y %b %d %X')/g
augroup end
