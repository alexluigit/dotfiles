 " shamelessly stolen from hemisu: https://github.com/noahfrederick/vim-hemisu/
 function! alex#colors#set_highlight(group, style)
   if g:terminal_italics == 0 && has_key(a:style, "cterm") && a:style["cterm"] == "italic"
     unlet a:style.cterm
   endif
   if g:termcolors == 16
     let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm16 : "NONE")
     let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm16 : "NONE")
   else
     let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
     let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
   end
   execute "highlight" a:group
     \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
     \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
     \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
     \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
     \ "ctermfg=" . l:ctermfg
     \ "ctermbg=" . l:ctermbg
     \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
 endfunction
