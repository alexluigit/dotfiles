function s:statusline_init() 
  let b:is_dirty             = strlen(system("git status -s")) > 0 ? 1 : 0
  let b:git_info             = '  ' . ' '. toupper(fugitive#head()) . ' '
  let b:file_head            = filereadable(expand("%"))?expand("%:h") . '/':''
  let b:file_title           = expand("%:t")
  let b:coc_current_function = ''
  let b:stl_ft               = WebDevIconsGetFileTypeSymbol()
endfunction

function! alex#statusline#focus()
  if alex#autocmds#should_use_statusline() 
    call s:statusline_init()
    setl stl=%#Dirty#%{b:is_dirty?get(b:,'git_info',''):''}%#Clean#%{b:is_dirty?'':get(b:,'git_info','')}
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
    setl stl=%#DirtyNC#%{b:is_dirty?get(b:,'git_info',''):''}%#CleanNC#%{b:is_dirty?'':get(b:,'git_info','')}
    setl stl+=%<
    setl stl+=%#FileHeadNC#\ %{b:file_head}
    setl stl+=%#FileModNC#%{&mod?get(b:,'file_title',''):''}%#FileUnModNC#%{&mod?'':get(b:,'file_title','')}
    setl stl+=\ %#FileModNC#%m%#FuncNC#
    setl stl+=%=%#StlFiletypeNC#%{b:stl_ft}
    setl stl+=\ \ \ %#StlColNC#\ %3l:%-3c\ %#PercentNC#\ %4L\ \|%5.(%p%%\ %)
  endif
endfunction
