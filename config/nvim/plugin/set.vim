set hidden nobackup nowritebackup noswapfile
set smarttab expandtab shiftwidth=2 softtabstop=2
set smartindent autoindent
set linebreak nowrap                        " display long lines in just one line
set ignorecase smartcase                    " ignore case when searching but still respect capital input
set number relativenumber
set splitright splitbelow diffopt+=vertical " default diff split splits open at the bottom and right
set noshowmode noshowcmd
" set scrolloff=999                           " Always keep cursor in the middle when <C-d> and <C-u>
set history=10000
set path+=**
set wildmenu
set shortmess+=ac
set updatetime=500                          " CursorHold event will respect this value
set timeoutlen=400                          " By default timeoutlen is 1000 ms
set signcolumn=yes                          " Always show signcolumn
set foldmethod=indent                       " not as cool as syntax, but faster
set foldlevelstart=99                       " start unfolded
set foldtext=alex#settings#foldtext()
set termguicolors
set lazyredraw                              " dont redraw screen during macro execution
set list
set dictionary+=/usr/share/dict/words
set fillchars=diff:∙                        " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
set fillchars+=fold:·                       " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
set listchars+=tab:••                       " BULLET (U+2022, UTF-8: 0xE2 0x80 0xA2)
set listchars+=trail:•                      " BULLET (U+2022, UTF-8: 0xE2 0x80 0xA2)
set fillchars+=eob:\                        " suppress ~ at EndOfBuffer
set fillchars+=vert:\                       " supress sign between vertical splits
