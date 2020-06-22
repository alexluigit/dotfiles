function! alex#statusline#init() abort
  let b:git_info             = '  ' . ' '. toupper(fugitive#head()) . ' '
  let b:file_head            = filereadable(expand("%"))?expand("%:h") . '/':''
  let b:file_title           = expand("%:t")
  let b:coc_current_function = ''
  let b:stl_ft               = WebDevIconsGetFileTypeSymbol()
  return
endfunction

let s:mode_map = {
      \     'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'V', 'V': 'V', "\<C-v>": 'V',
      \     'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL' }
function! alex#statusline#mode() abort
  return get(s:mode_map, mode(), '')
endfunction

function! alex#statusline#focus()
  if alex#autocmds#should_use_statusline() 
    call alex#statusline#init()
    setl stl=%#NormalColor#%{(mode()=='n')?get(b:,'git_info',''):''}
    setl stl+=%#InsertColor#%{(mode()=='i')?get(b:,'git_info',''):''}
    setl stl+=%#ReplaceColor#%{(mode()=='R')?get(b:,'git_info',''):''}
    setl stl+=%#CommandColor#%{(mode()=='c')?get(b:,'git_info',''):''}
    setl stl+=%#VisualColor#%{(alex#statusline#mode()=='V')?get(b:,'git_info',''):''}
    setl stl+=%<
    setl stl+=%#FileHead#\ %{b:file_head}
    setl stl+=%#FileMod#%{&mod?get(b:,'file_title',''):''}%#FileUnMod#%{&mod?'':get(b:,'file_title','')}
    setl stl+=\ %#FileMod#%m
    setl stl+=%#Func#\ %{strlen(b:coc_current_function)==0?'':'\:'}
    setl stl+=\ %#Func#%{get(b:,'coc_current_function','')}
    setl stl+=%=%#StlFiletype#\ %{b:stl_ft}
    setl stl+=\ \ \ %#StlCol#\ %3l:%-3c\ %#Percent#\ %4L\ \|%5.(%p%%\ %)
  endif
endfunction

function! alex#statusline#blur()
  if alex#autocmds#should_use_statusline() 
    setl stl=%#ModeNC#%{get(b:,'git_info','')}
    setl stl+=%<
    setl stl+=%#FileHeadNC#\ %{b:file_head}
    setl stl+=%#FileModNC#%{&mod?get(b:,'file_title',''):''}%#FileUnModNC#%{&mod?'':get(b:,'file_title','')}
    setl stl+=\ %#FileModNC#%m%#FuncNC#
    setl stl+=%=%{b:stl_ft}
    setl stl+=\ \ \ \ %3l:%-3c\ \ %4L\ \|%5.(%p%%\ %)
  endif
endfunction
