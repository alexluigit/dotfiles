set foldlevel=2
set conceallevel=2
imap     <buffer><silent>       <C-S>      - [ ]<Space><Esc>:noh<CR>a
nmap     <silent><buffer><expr> <C-S>      <SID>searchCheck() ? ':.s/\[ \]/\[x\]<CR>:silent noh<Bar>echo<CR>' : ':.s/\[x\]/\[ \]<CR>:silent noh<Bar>echo<CR>'
nmap     <silent><buffer>       <leader>i  :call todo#marker()<CR>
nmap     <silent><buffer>       <leader>o  :bd#<CR>$3bgF:bd#<CR>
inoremap <buffer><silent>       <Bar>      <C-r>=<SID>align()<CR>

function! s:searchCheck()
  return (search('\[ \]', 'nc', line('.')) || search('\[ \]', 'nbc', line('.')))
endfunction

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(":EasyAlign") && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    return "\<Bar>\<Esc>:normal! vip\<CR>:EasyAlign *\<Bar>\<cr>gi\<Esc>:normal f\<bar>\<cr>a"
  endif
  return "\<Bar>"
endfunction

function! MarkdownFold()
  let line = getline(v:lnum)

  " Regular headers
  let depth = match(line, '\(^#\+\)\@<=\( .*$\)\@=')
  if depth > 0
    " check syntax, it should be markdownH1-6
    let syncode = synstack(v:lnum, 1)
    if len(syncode) > 0 && synIDattr(syncode[0], 'name') =~ 'markdownH[1-6]'
        return ">" . depth
    endif
  endif

  " Setext style headings
  let prevline = getline(v:lnum - 1)
  let nextline = getline(v:lnum + 1)
  if (line =~ '^.\+$') && (nextline =~ '^=\+$') && (prevline =~ '^\s*$')
    return ">1"
  endif
  if (line =~ '^.\+$') && (nextline =~ '^-\+$') && (prevline =~ '^\s*$')
    return ">2"
  endif

  " frontmatter
  if v:lnum == 1 && line == '---'
    let b:markdown_frontmatter = 1
    return ">1"
  endif
  if (line == '---') && b:markdown_frontmatter
    unlet b:markdown_frontmatter
    return '<1'
  endif
  return "="
endfunction

set foldtext=MyFoldText()
fu! MyFoldText()
  let line = getline(v:foldstart)
  " markdown frontmatter -- just take the next line hoping it would be
  " title: Your title
  if line =~ '^----*$' | let line = getline(v:foldstart+1) | endif
  let indent = max([indent(v:foldstart)-v:foldlevel, 1])
  let lines = (v:foldend - v:foldstart + 1)
  let strip_line = substitute(line, '^//\|=\+\|["#]\|/\*\|\*/\|{{{\d\=\|title:\s*', '', 'g')
  let strip_line = substitute(strip_line, '^[[:space:]]*\|[[:space:]]*$', '', 'g')
  let text = strpart(strip_line, 0, winwidth(0) - v:foldlevel - indent - 6 - strlen(lines))
  if strlen(strip_line) > strlen(text) | let text = text.'…' | endif
  return repeat('▧ ', v:foldlevel) . repeat(' ', indent) . text .' ('. lines .')'
endfu
