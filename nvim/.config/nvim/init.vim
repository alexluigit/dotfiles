" Basics
  set hidden nobackup nowritebackup noswapfile
  set smarttab expandtab shiftwidth=2 softtabstop=2
  set history=200
  set linebreak nowrap " display long lines in just one line
  set iskeyword+=- " treat dash separated words as a word text object
  set ignorecase smartcase " ignore case when searching but still respect capital input
  set smartindent
  set path+=**
  set wildmenu
  set updatetime=50
  set shortmess+=ac
  set timeoutlen=300 " By default timeoutlen is 1000 ms
  set signcolumn=yes " CoC suggest
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=99               " start unfolded
  set termguicolors
  set relativenumber
  set splitright splitbelow diffopt+=vertical " default diff split splits open at the bottom and right
  set noshowmode noshowcmd
  au! BufWritePost $MYVIMRC source $MYVIMRC
  au! BufWinEnter * call alex#general#root(expand("%"), &buftype)

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

" Plugin settings
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
  command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
  command! -bang -nargs=* All
  \ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/i*}" "$HOME"', 
  \ 'options': [ '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}'] } ))

" Appearance
" ----------- colors ---------------
  colorscheme onedark
    hi Dirty guifg=#30302C guibg=#df5f87 gui=bold
    hi Clean guifg=#30302C guibg=#87af87 gui=bold
    hi FileHead guifg=#949484 guibg=#4e4e43
    hi FileUnMod guifg=#e8e8d3 guibg=#4e4e43 gui=bold
    hi FileMod guifg=#61adef guibg=#4e4e43 gui=bold
    hi Func guifg=#d7875f guibg=#30302C gui=bold,italic
    hi StlFiletype guifg=#808070 guibg=#30302C
    hi StlCol guifg=#a8a897 guibg=#4e4e43
    hi Percent guifg=#30302C guibg=#949484 gui=bold
    " Non-current window
    hi DirtyNC guifg=#3b4252 guibg=#B48EAD gui=bold
    hi CleanNC guifg=#3b4252 guibg=#a3be8c gui=bold
    hi FileHeadNC guifg=#8e939e guibg=#434c5e
    hi FileUnModNC guifg=#eceff4 guibg=#434c5e gui=bold
    hi FileModNC guifg=#5e81ac guibg=#434c5e gui=bold
    hi FuncNC guifg=#d08770 guibg=#3b4252 gui=bold,italic
    hi StlFiletypeNC guifg=#b9bcc2 guibg=#3b4252
    hi StlColNC guifg=#c2c7d1 guibg=#4c566a
    hi PercentNC guifg=#242933 guibg= #616e88 gui=bold
" ----------- Windows --------------
  augroup Stline
    au!
    au FileType coc-explorer,floaterm setl nonu norelativenumber stl=%#Normal#
    au FileType fzf set showtabline=0
    au BufWinEnter,BufEnter * call Stl_Win_Enter()
    au WinLeave * call Stl_Win_Leave()
  augroup END
  function! Stl_Win_Enter()
    if &ft=='coc-explorer' | setl stl=%#Normal# | return | endif
    let b:is_dirty = strlen(system("git status -s")) > 0 ? 1 : 0
    let b:git_info = '  ' . ' '. toupper(fugitive#head()) . ' '
    let b:file_head = filereadable(expand("%"))?expand("%:h") . '/':''
    let b:file_title = expand("%:t")
    let b:coc_current_function = ''
    let b:stl_ft =   WebDevIconsGetFileTypeSymbol()
    setl stl=%#Dirty#%{b:is_dirty?get(b:,'git_info',''):''}%#Clean#%{b:is_dirty?'':get(b:,'git_info','')}
    setl stl+=%#FileHead#\ %{b:file_head}
    setl stl+=%#FileMod#%{&mod?get(b:,'file_title',''):''}%#FileUnMod#%{&mod?'':get(b:,'file_title','')}
    setl stl+=%#FileMod#%m
    setl stl+=\ %#Func#\ %{strlen(b:coc_current_function)==0?'':'\:'}
    setl stl+=\ %#Func#%{get(b:,'coc_current_function','')}
    setl stl+=%=%#StlFiletype#\ %{b:stl_ft}
    setl stl+=\ \ \ %#StlCol#\ %3l:%-3c\ %#Percent#\ %4L\ \|%5.(%p%%\ %)
  endfunction
  function! Stl_Win_Leave()
    if &ft=='coc-explorer' | setl stl=%#NormalNC# | return | endif
    if &ft=='fzf' | set showtabline=1 | return | endif
    " setl winhl=
    setl stl=%#DirtyNC#%{b:is_dirty?get(b:,'git_info',''):''}%#CleanNC#%{b:is_dirty?'':get(b:,'git_info','')}
    setl stl+=%#FileHeadNC#\ %{b:file_head}
    setl stl+=%#FileModNC#%{&mod?get(b:,'file_title',''):''}%#FileUnModNC#%{&mod?'':get(b:,'file_title','')}
    setl stl+=\ %#FileModNC#%m%#FuncNC#
    setl stl+=%=%#StlFiletypeNC#%{b:stl_ft}
    setl stl+=\ \ \ %#StlColNC#\ %3l:%-3c\ %#PercentNC#\ %4L\ \|%5.(%p%%\ %)
  endfunction

  " hi Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
  " hi SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow

  " let g:fzf_buffers_jump = 1
  " command! -bang -nargs=* Rg
  "   \ call fzf#vim#grep(
  "   \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  "   \   fzf#vim#with_preview(), <bang>0)

  " autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
  " map <F5> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  "   \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  "   \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
