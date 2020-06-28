let s:statusline_ft_blacklist = [ 'fzf', 'diff', 'fugitiveblame', 'qf' ]
function! alex#statusline#allow() abort
  if index(s:statusline_ft_blacklist, &filetype) != -1 | return | endif
  if !empty(&buftype) | return | endif
  return &buflisted
endfunction

function! alex#statusline#init() abort
  let b:branch               = !empty(fugitive#head()) ? (' ' . ' '. toupper(fugitive#head()) . ' ') : ''
  let b:file_head            = filereadable(expand("%"))?expand("%:h") . '/':''
  let b:file_title           = expand("%:t")
  let b:current_function = '' " TODO: maybe put autocomplete preview here
  let b:stl_ft               = WebDevIconsGetFileTypeSymbol()
  return
endfunction

let s:mode_map = { 'v': 'V', 'V': 'V', "\<C-v>": 'V', 's': 'S', 'S': 'S', "\<C-s>": 'S' }
function! alex#statusline#mode() abort
  return get(s:mode_map, mode(), '')
endfunction

function! alex#statusline#focus()
  if alex#statusline#allow()
    call alex#statusline#init()
    setl stl=%#NormalColor#%10{(mode()=='n'&&!empty(b:branch))?get(b:,'branch',''):(empty(b:branch)&&mode()=='n')?'NORMAL\ \ ':''}
    setl stl+=%#InsertColor#%10{(mode()=='i')?'INSERT\ \ ':''}
    setl stl+=%#ReplaceColor#%10{(mode()=='R')?'REPLAC\ \ ':''}
    setl stl+=%#CommandColor#%10{(mode()=='c')?'COMMND\ \ ':''}
    setl stl+=%#VisualColor#%10{(alex#statusline#mode()=='V')?'VISUAL\ \ ':''}
    setl stl+=%#SelectColor#%10{(alex#statusline#mode()=='S')?'SELECT\ \ ':''}
    setl stl+=%<
    setl stl+=%#FileHead#\ %{b:file_head}
    setl stl+=%#FileMod#%{&mod?get(b:,'file_title',''):''}%#FileUnMod#%{&mod?'':get(b:,'file_title','')}
    setl stl+=\ %#FileMod#%m
    setl stl+=%#Func#\ %{get(b:,'current_function','')}
    setl stl+=%=%#StlFiletype#\ %{b:stl_ft}
    setl stl+=\ \ \ %#StlCol#\ %3l:%-3c\ %#Percent#\ %4L\ \|%5.(%p%%\ %)
  endif
endfunction

function! alex#statusline#blur()
  if alex#statusline#allow()
    setl stl=%#ModeNC#%{get(b:,'git_info','')}
    setl stl+=%<
    setl stl+=%#FileHeadNC#\ %{b:file_head}
    setl stl+=%#FileModNC#%{&mod?get(b:,'file_title',''):''}%#FileUnModNC#%{&mod?'':get(b:,'file_title','')}
    setl stl+=\ %#FileModNC#%m%#FuncNC#
    setl stl+=%=%{b:stl_ft}
    setl stl+=\ \ \ \ %3l:%-3c\ \ %4L\ \|%5.(%p%%\ %)
  endif
endfunction
