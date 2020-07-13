function! alex#autocmds#vim_enter() abort
  set stl=%#Normal#
  if argc() == 0 | call TryGFiles() | endif
endfunction

function! alex#autocmds#yank_post() abort
  lua vim.highlight.on_yank { "IncSearch", 700 }
  " Only usee Osc52Yank in macOS and tty variable has been passed in
  if v:event.operator !~ "y" || !has("mac") || !exists("g:tty") | return | endif
  " Inspired by https://github.com/fcpg/vim-osc52/blob/master/plugin/osc52.vim
  " For better understanding OSC 52: https://invisible-island.net/xterm/ctlseqs/ctlseqs.html
  let buffer=system('base64', @0)
" Remove the trailing newline.
  let buffer=substitute(buffer, "\n", "", "")
" Now wrap the whole thing in <start-dcs><start-osc52>...<end-osc52><end-dcs>.
  let buffer='\ePtmux;\e\e]52;c;'.buffer.'\x07\e\x5c'
" Disable GNU-coreutils bdfore echo
  silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape(g:tty)
endfunction
