function! alex#autocmds#vim_enter() abort
  set stl=%#Normal#
  if argc() == 0 | call TryGFiles() | endif
endfunction

function! alex#autocmds#yank_post() abort
" echo command in GNU-coreutils doesn't work well with osc52?
" let $PATH=substitute($PATH, '/usr/local/opt/coreutils/libexec/gnubin:', '', '')
  silent! lua require'vim.highlight'.on_yank("IncSearch", 500)
" Only usee Osc52Yank when tty variable has been passed in
  if !exists("g:tty") | set clipboard=unnamedplus | return | endif
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
