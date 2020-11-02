scriptencoding utf-8

hi default link BufTabLineCurrent TabLineSel
hi default link BufTabLineActive  PmenuSel
hi default link BufTabLineHidden  TabLine
hi default link BufTabLineFill    TabLineFill

let g:buftabline_numbers    = get(g:, 'buftabline_numbers',    0)
let g:buftabline_indicators = get(g:, 'buftabline_indicators', 0)
let g:buftabline_separators = get(g:, 'buftabline_separators', 0)
let g:buftabline_show       = get(g:, 'buftabline_show',       2)
let g:buftabline_plug_max   = get(g:, 'buftabline_plug_max',  10)

augroup BufTabLine
  autocmd!
  autocmd VimEnter  * call buftabline#update(0)
  autocmd TabEnter  * call buftabline#update(0)
  autocmd BufAdd    * call buftabline#update(0)
  autocmd FileType qf call buftabline#update(0)
  autocmd BufDelete * call buftabline#update(str2nr(expand('<abuf>')))
augroup END
