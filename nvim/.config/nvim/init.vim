" Plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'honza/vim-snippets'
  Plug 'ryanoasis/vim-devicons'
  Plug 'ThePrimeagen/vim-be-good'
  Plug 'joshdick/onedark.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'voldikss/vim-floaterm'
  Plug 'justinmk/vim-sneak'
  Plug 'jiangmiao/auto-pairs'
  Plug 'sheerun/vim-polyglot' " language pack
call plug#end()
