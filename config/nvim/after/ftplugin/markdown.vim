setl foldlevel=1
imap     <buffer>         <C-S>      -[]<Space>
nmap     <buffer><expr>   <C-S>      <SID>SearchCheck() ? ':.s/\[\]/\[x\]<Enter>' : ':.s/\[x\]/\[\]<Enter>'
nmap     <silent><buffer> <leader>ta gaip*<bar>
nmap     <silent><buffer> <leader>tm :call todo#marker()<CR>
nmap     <silent><buffer> <leader>fo :bd#<CR>gF:bd#<CR>
inoremap <buffer><silent> <Bar>      <C-r>=<SID>align()<CR>

function! s:SearchCheck()
  return (search('\[\]', 'nc', line('.')) || search('\[\]', 'nbc', line('.')))
endfunction

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(":EasyAlign") && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    return "\<Bar>\<Esc>:normal! vip\<CR>:EasyAlign *\<Bar>\<cr>gi\<Esc>:normal f\<bar>\<cr>a"
  endif
  return "\<Bar>"
endfunction
