set hidden nobackup nowritebackup noswapfile
set smarttab expandtab shiftwidth=2 softtabstop=2
set history=10000
set linebreak nowrap " display long lines in just one line
set ignorecase smartcase " ignore case when searching but still respect capital input
set smartindent
set path+=**
set wildmenu
set updatetime=50
set shortmess+=ac
set timeoutlen=200 " By default timeoutlen is 1000 ms
set signcolumn=yes " CoC suggest
set foldmethod=indent " not as cool as syntax, but faster
set foldlevelstart=99 " start unfolded
set termguicolors
set number relativenumber
set splitright splitbelow diffopt+=vertical " default diff split splits open at the bottom and right
set noshowmode noshowcmd
colorscheme gruvbox
