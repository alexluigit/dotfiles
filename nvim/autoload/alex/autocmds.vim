function! alex#autocmds#init() abort
  set stl=%#Normal#
  if argc() == 0 | call TryGFiles() | endif
endfunction

let g:statusline_ft_blacklist = [ 'fzf', 'diff', 'fugitiveblame', 'qf' ]
function! alex#autocmds#should_use_statusline() abort
  if index(g:statusline_ft_blacklist, &filetype) != -1 | return 0 | endif
  if !empty(&buftype) | return 0 | endif
  return &buflisted
endfunction

let g:ownsyntax_blacklist = [ '' ]
function! alex#autocmds#should_use_ownsyntax() abort
  if index(g:ownsyntax_blacklist, &filetype) != -1 | return 0 | endif
  " if !empty(&buftype) | return 0 | endif
  return &buflisted
endfunction

function! alex#autocmds#yankpost() abort
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
