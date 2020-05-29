" ----------- colors ---------------
  " hi Dirty guifg=#30302C guibg=#df5f87 gui=bold
  " hi Clean guifg=#30302C guibg=#87af87 gui=bold
  " hi FileHead guifg=#949484 guibg=#4e4e43
  " hi FileUnMod guifg=#e8e8d3 guibg=#4e4e43 gui=bold
  " hi FileMod guifg=#61adef guibg=#4e4e43 gui=bold
  " hi Func guifg=#d7875f guibg=#30302C gui=bold,italic
  " hi StlFiletype guifg=#808070 guibg=#30302C
  " hi StlCol guifg=#a8a897 guibg=#4e4e43
  " hi Percent guifg=#30302C guibg=#949484 gui=bold
  " " Non-current window
  " hi DirtyNC guifg=#3b4252 guibg=#B48EAD gui=bold
  " hi CleanNC guifg=#3b4252 guibg=#a3be8c gui=bold
  " hi FileHeadNC guifg=#8e939e guibg=#434c5e
  " hi FileUnModNC guifg=#eceff4 guibg=#434c5e gui=bold
  " hi FileModNC guifg=#5e81ac guibg=#434c5e gui=bold
  " hi FuncNC guifg=#d08770 guibg=#3b4252 gui=bold,italic
  " hi StlFiletypeNC guifg=#b9bcc2 guibg=#3b4252
  " hi StlColNC guifg=#c2c7d1 guibg=#4c566a
  " hi PercentNC guifg=#242933 guibg= #616e88 gui=bold
" ----------- Windows --------------
" augroup Stline
"   au!
"   au FileType coc-explorer,floaterm setl nonu norelativenumber stl=%#Normal#
"   au FileType fzf set showtabline=0
"   au BufWinEnter,BufEnter * call Stl_Win_Enter()
"   au WinLeave * call Stl_Win_Leave()
" augroup END
function! Stl_Win_Enter()
  if &ft=='coc-explorer' | setl stl=%#Normal# | return | endif
  let b:is_dirty = strlen(system("git status -s")) > 0 ? 1 : 0
  let b:git_info = '  ' . ' '. toupper(fugitive#head()) . ' '
  let b:file_head = filereadable(expand("%"))?expand("%:h") . '/':''
  let b:file_title = expand("%:t")
  let b:coc_current_function = ''
  let b:stl_ft =   WebDevIconsGetFileTypeSymbol()
  setl stl=%#Dirty#%{b:is_dirty?get(b:,'git_info',''):''}%#Clean#%{b:is_dirty?'':get(b:,'git_info','')}
  setl stl+=%#FileHead#\ %{b:file_head}
  setl stl+=%#FileMod#%{&mod?get(b:,'file_title',''):''}%#FileUnMod#%{&mod?'':get(b:,'file_title','')}
  setl stl+=%#FileMod#%m
  setl stl+=\ %#Func#\ %{strlen(b:coc_current_function)==0?'':'\:'}
  setl stl+=\ %#Func#%{get(b:,'coc_current_function','')}
  setl stl+=%=%#StlFiletype#\ %{b:stl_ft}
  setl stl+=\ \ \ %#StlCol#\ %3l:%-3c\ %#Percent#\ %4L\ \|%5.(%p%%\ %)
endfunction
function! Stl_Win_Leave()
  if &ft=='coc-explorer' | setl stl=%#NormalNC# | return | endif
  if &ft=='fzf' | set showtabline=1 | return | endif
  " setl winhl=
  setl stl=%#DirtyNC#%{b:is_dirty?get(b:,'git_info',''):''}%#CleanNC#%{b:is_dirty?'':get(b:,'git_info','')}
  setl stl+=%#FileHeadNC#\ %{b:file_head}
  setl stl+=%#FileModNC#%{&mod?get(b:,'file_title',''):''}%#FileUnModNC#%{&mod?'':get(b:,'file_title','')}
  setl stl+=\ %#FileModNC#%m%#FuncNC#
  setl stl+=%=%#StlFiletypeNC#%{b:stl_ft}
  setl stl+=\ \ \ %#StlColNC#\ %3l:%-3c\ %#PercentNC#\ %4L\ \|%5.(%p%%\ %)
endfunction
