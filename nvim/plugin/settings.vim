set hidden nobackup nowritebackup noswapfile
set smarttab expandtab tabstop=2 shiftwidth=2 softtabstop=2
set smartindent autoindent
set history=10000
set linebreak nowrap " display long lines in just one line
set ignorecase smartcase " ignore case when searching but still respect capital input
set path+=**
set wildmenu
set updatetime=500 " CursorHold event will respect this value
set shortmess+=ac
set timeoutlen=200 " By default timeoutlen is 1000 ms
set signcolumn=yes " Always show signcolumn
set foldmethod=indent " not as cool as syntax, but faster
set foldlevelstart=99 " start unfolded
set termguicolors
set number relativenumber
set splitright splitbelow diffopt+=vertical " default diff split splits open at the bottom and right
set noshowmode noshowcmd
set lazyredraw " dont redraw screen during macro execution
set undodir=$HOME/.local/share/nvim/undo " adds ability to undo changes even if vim was previously closed
set undofile
set undolevels=1000 undoreload=10000

colorscheme gruvbox
