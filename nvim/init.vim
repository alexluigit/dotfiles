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
  set timeoutlen=250 " By default timeoutlen is 1000 ms
  set ruler signcolumn=yes " CoC suggest
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=99               " start unfolded
  set termguicolors
  set relativenumber
  set splitright splitbelow diffopt+=vertical " default diff split splits open at the bottom and right
  set noshowmode noshowcmd
  au! BufWritePost $MYVIMRC source $MYVIMRC
  au! BufWinEnter * call alex#root(expand("%"), &buftype)

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

" Keybindings
"     ------------ Basic ---------------
  nnoremap                     *          :keepjumps normal! mp*`p<cr>
  xnoremap                     *          ymp:keepjumps normal! /\V<C-r>=escape(@",'/\')<cr><C-v><C-m>`p<cr>
  vnoremap                     <          <gv
  vnoremap                     >          >gv
  xmap                         af         <Plug>(coc-funcobj-a)
  omap                         af         <Plug>(coc-funcobj-a)
  xmap                         ac         <Plug>(coc-classobj-a)
  omap                         ac         <Plug>(coc-classobj-a)
  nmap     <silent>            gd         <Plug>(coc-definition)
  nmap     <silent>            gy         <Plug>(coc-type-definition)
  nmap     <silent>            gr         <Plug>(coc-references)
  nma      <silent>            gi         <Plug>(coc-implementation)
  nmap                         [g         <Plug>(coc-git-prevchunk)
  nmap                         ]g         <Plug>(coc-git-nextchunk)
  xmap                         if         <Plug>(coc-funcobj-i)
  omap                         if         <Plug>(coc-funcobj-i)
  xmap                         ic         <Plug>(coc-classobj-i)
  omap                         ic         <Plug>(coc-classobj-i)
  inoremap                     jj         <Esc>
  nnoremap <expr>              k          (v:count > 5 ? "m'" . v:count : '') . 'k'
  nnoremap <expr>              j          (v:count > 5 ? "m'" . v:count : '') . 'j'
  vnoremap <silent>            J          :m '>+1<CR>gv=gv
  vnoremap <silent>            K          :m '<-2<CR>gv=gv
  " nnoremap                     K          :call CocAction('doHover')<CR>
  noremap  <silent>            n          :keepjumps normal! n<cr>
  noremap  <silent>            N          :keepjumps normal! N<cr>
  nnoremap                     Q          q
  nnoremap                     q          <Nop>
  vnoremap                     X          "_d
  noremap                      Y          y$
  nnoremap <expr>              <CR>       empty(&buftype) ? '@@' : '<CR>'
  nnoremap                     <Tab>      za
  nnoremap <silent>            <Up>       :cprevious<CR>
  nnoremap <silent>            <Down>     :cnext<CR>
  nnoremap <silent>            <Left>     :cpfile<CR>
  nnoremap <silent>            <Right>    :cnfile<CR>
  nnoremap <silent>            <S-Up>     :lprevious<CR>
  nnoremap <silent>            <S-Down>   :lnext<CR>
  nnoremap <silent>            <S-Left>   :lpfile<CR>
  nnoremap <silent>            <S-Right>  :lnfile<CR>
  nnoremap <silent>            <F4>       :Helptags<CR>
  nnoremap                     <F6>       <C-i>
"     ---------- Control/Alt -----------
  inoremap                     <C-f>      <Esc>cw
  inoremap                     <C-l>      <del>
  inoremap                     <C-u>      <Esc>cc
  nnoremap <silent>            <C-s>      :BLines<CR>
  nnoremap <silent>            <C-g>      :GFiles<CR>
  nnoremap                     <C-p>      :Rg <C-r><C-a><CR>
  nnoremap <silent>            <C-h>      :wincmd h<CR>
  nnoremap <silent>            <C-j>      :wincmd j<CR>
  nnoremap <silent>            <C-k>      :wincmd k<CR>
  nnoremap <silent>            <C-l>      :wincmd l<CR>
  nnoremap <silent>            <M-j>      :resize -2<CR>
  nnoremap <silent>            <M-k>      :resize +2<CR>
  nnoremap <silent>            <M-h>      :vertical resize -5<CR>
  nnoremap <silent>            <M-l>      :vertical resize +5<CR>
  tnoremap <silent>            <M-h>      <C-\><C-n>:vert resize -5<CR>i
  tnoremap <silent>            <M-l>      <C-\><C-n>:vert resize +5<CR>i
"     ------------ Leader --------------
  let mapleader=" "
  nmap     <silent>    <leader><space>    <C-^>
  nnoremap <silent>    <leader>.          :e $MYVIMRC<CR>
  nnoremap <silent>    <leader>;          :Commands<CR>
  nnoremap <silent>    <leader>b          :Buffers<CR>
  nmap     <silent>    <leader>c          :<C-u>CocList commands<cr>
  nnoremap             <leader>cr         :CocRestart
  nnoremap <silent>    <leader>d          :q!<CR>
  nnoremap <silent>    <leader>e          :CocCommand explorer<CR>
  nnoremap             <localleader>e     :edit <C-R>=expand('%:p:h') . '/'<CR>
  nmap     <silent>    <leader>f          :Files<CR>
  nmap                 <leader>g          :G<CR>
  nmap                 <leader>gd         :diffget //2<CR>
  nmap                 <leader>gj         :diffget //3<CR>
  nmap     <silent>    <leader>h          :History<CR>
  nmap     <silent>    <leader>hi         <Plug>(coc-git-chunkinfo)
  nmap     <silent>    <leader>hu         <Plug>(coc-git-chunkundo)
  nmap                 <leader>j          <Plug>(coc-diagnostic-prev)
  nmap                 <leader>k          <Plug>(coc-diagnostic-next)
  nmap     <silent>    <leader>o          :wincmd o<CR>
  noremap  <silent>    <leader>p          "+P
  nnoremap <silent>    <leader>q          :q<CR>
  nmap                 <leader>qf         <Plug>(coc-fix-current)
  nnoremap             <leader>r          :%s///gc<left><left><left>
  xnoremap             <leader>r          :s///gc<left><left><left>
  nmap     <silent>    <leader>s          :vert sb#<CR>
  nnoremap             <leader>sa         :All<CR>
  nnoremap <silent>    <leader>t          :let @/ = ''<CR>
  nnoremap             <leader>x          :x<CR>
  noremap  <silent>    <leader>y          "+y
  nmap     <silent>    <leader>w          :w<CR>
  nmap     <silent>    <leader>wq         :wq<CR>
  inoremap <silent> <expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <silent><expr> <C-space> coc#refresh()
  if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

" Plugin settings
"     ------------- Coc ----------------
  let g:coc_data_home = '~/.config/nvim/coc_data'
  autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
"     ----------- floaterm -------------
  let g:floaterm_wintype='normal'
  let g:floaterm_width=0.5
  let g:floaterm_position      = 'right'
  let g:floaterm_keymap_toggle = '<F1>'
  let g:floaterm_keymap_prev   = '<F2>'
  let g:floaterm_keymap_new    = '<F3>'
  let g:floaterm_autoclose     = 1
"     ------------ sneak ---------------
  let g:sneak#label = 1
  let g:sneak#use_ic_scs = 1 " case insensitive sneak
  let g:sneak#s_next = 1 " imediately move tot the next instance of search, if you move the cursor sneak is back to default behavior
  let g:sneak#prompt = ' : '
"     ------------  fzf  ---------------
  let g:fzf_buffers_jump = 1
  let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
  let g:fzf_tags_command = 'ctags -R'
  let g:fzf_commands_expect = 'alt-enter,ctrl-x'
  let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
  let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
  " command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)
  command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
  command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --hidden --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction
  " Do not ignore files in .gitignore (but ignore .git and node_modules)
  command! -bang -nargs=* All
   \ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/i*}" "$HOME"', 'options': [ '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}'] } ))

" Appearance
"     ----------- colors ---------------
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
"     ----------- Windows --------------
  augroup Stline
    au!
    au FileType coc-explorer,floaterm setl nonu norelativenumber stl=%#Normal#
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
    setl stl+=\ \ \ %#StlCol#\ %3l:%-3c\ %#Percent#\ %5.(%p%%\ %)
  endfunction

  function! Stl_Win_Leave()
    if &ft=='coc-explorer' | setl stl=%#NormalNC# | return | endif
    setl stl=%#DirtyNC#%{b:is_dirty?get(b:,'git_info',''):''}%#CleanNC#%{b:is_dirty?'':get(b:,'git_info','')}
    setl stl+=%#FileHeadNC#\ %{b:file_head}
    setl stl+=%#FileModNC#%{&mod?get(b:,'file_title',''):''}%#FileUnModNC#%{&mod?'':get(b:,'file_title','')}
    setl stl+=\ %#FileModNC#%m%#FuncNC#
    setl stl+=%=%#StlFiletypeNC#%{b:stl_ft}
    setl stl+=\ \ \ %#StlColNC#\ %3l:%-3c\ %#PercentNC#\ %5.(%p%%\ %)
  endfunction
  " hi Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
  " hi SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow
