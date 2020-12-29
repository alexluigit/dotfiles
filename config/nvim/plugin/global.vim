" prevent tcomment from making a zillion mappings (we just want the operator).
let g:tcomment_mapleader1=''
let g:tcomment_mapleader2=''
let g:tcomment_mapleader_comment_anyway=''
let g:tcomment_textobject_inlinecomment=''
let g:tcomment_mapleader_uncomment_anyway=''

" sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1 " case insensitive sneak
let g:sneak#s_next = 1 " imediately move tot the next instance of search, if you move the cursor sneak is back to default behavior
let g:sneak#prompt = ' :'

" slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}
let g:slime_dont_ask_default = 1
let g:slime_paste_file = tempname()

" markdown
let g:markdown_fenced_languages = ['c\(\[.*\]\)\?=c', 'html', 'python', 'cpp', 'go', 'rust', '\(ba\)\?sh\(\[.*\]\)\?=sh', 'js\(\[.*\]\)\?=javascript']
let g:markdown_folding = 1

" which-key
let g:which_key_timeout = 100
let g:which_key_display_names = {'<CR>': '', '<TAB>': '', ' ': 'SPC'}
let g:which_key_sep = '→'
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0
