set hidden nobackup nowritebackup noswapfile
set smarttab expandtab shiftwidth=2 softtabstop=2
set smartindent autoindent
set linebreak nowrap " display long lines in just one line
set ignorecase smartcase " ignore case when searching but still respect capital input
set number relativenumber
set splitright splitbelow diffopt+=vertical " default diff split splits open at the bottom and right
set noshowmode noshowcmd
set scrolloff=999 " Always keep cursor in the middle when <C-d> and <C-u>
set history=10000
set path+=**
set wildmenu
set updatetime=500 " CursorHold event will respect this value
set shortmess+=ac
set timeoutlen=200 " By default timeoutlen is 1000 ms
set signcolumn=yes " Always show signcolumn
set foldmethod=indent " not as cool as syntax, but faster
set foldlevelstart=99 " start unfolded
set foldtext=alex#settings#foldtext()
set termguicolors
set lazyredraw " dont redraw screen during macro execution
set list
set fillchars=diff:∙               " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
set fillchars+=fold:·              " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
if has('nvim-0.3.1')
  set fillchars+=eob:\              " suppress ~ at EndOfBuffer
  set fillchars+=vert:\              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
endif
if has("persistent_undo")
  set undodir=$HOME/.local/share/nvim/undo " adds ability to undo changes even if vim was previously closed
  set undofile
" set undolevels=1000 undoreload=10000
endif
colorscheme gruvbox
hi! Normal guibg=NONE
hi! NormalNC guibg=NONE
