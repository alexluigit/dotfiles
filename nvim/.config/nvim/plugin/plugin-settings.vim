" ------------- Coc ----------------
let g:coc_data_home = '~/.config/nvim/coc_data'
" ----------- floaterm -------------
let g:floaterm_wintype       = 'normal'
let g:floaterm_width         =  0.5
let g:floaterm_position      = 'right'
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_prev   = '<F2>'
let g:floaterm_keymap_new    = '<F3>'
let g:floaterm_autoclose     = 1
" ------------ sneak ---------------
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1 " case insensitive sneak
let g:sneak#s_next = 1 " imediately move tot the next instance of search, if you move the cursor sneak is back to default behavior
let g:sneak#prompt = ' : '
" ------------  fzf  ---------------
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" let g:fzf_buffers_jump = 1
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)

" autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
" map <F5> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
"   \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
"   \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
