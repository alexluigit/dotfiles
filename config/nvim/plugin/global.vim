" Prevent tcomment from making a zillion mappings (we just want the operator).
let g:tcomment_mapleader1=''
let g:tcomment_mapleader2=''
let g:tcomment_mapleader_comment_anyway=''
let g:tcomment_textobject_inlinecomment=''
let g:tcomment_mapleader_uncomment_anyway=''

" Sneak settings
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1 " case insensitive sneak
let g:sneak#s_next = 1 " imediately move tot the next instance of search, if you move the cursor sneak is back to default behavior
let g:sneak#prompt = ' :'

" Replace netrw with vifm
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let g:vifm_replace_netrw = 1
let g:vifm_exec          = 'vifmrun'

" Slime settings
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}
let g:slime_dont_ask_default = 1
let g:slime_paste_file = tempname()

" markdown settings
let g:markdown_fenced_languages = ['c', 'html', 'python', 'cpp', 'go', 'rust', 'bash=sh', 'javascript']
let g:markdown_folding = 1

" Bujo settings
let g:bujo#window_width = 60

" treesitter
luafile ~/.config/nvim/lua/config/treesitter.lua
