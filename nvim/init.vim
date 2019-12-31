"================================================================================
"                              General settings
"================================================================================
set softtabstop=2
set shiftwidth=2
set expandtab
set history=200
set hidden "enable hidden unsaved buffers
set iskeyword+=- "treat dash separated words as a word text object
set noswapfile "no .swp file
set ignorecase "ignore case when searching
set smartcase "make capital search valid
set clipboard=unnamedplus "use system clipboard
set linebreak "wrap with word boundary
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
"set signcolumn=yes

"================================================================================
"                              Basic autocommands
"================================================================================
au BufEnter,BufNew * if &buftype == 'terminal' | :startinsert | endif "enter terminal in insert mode
au BufWritePre * :%s/\s\+$//e "remove trailing space when saving
au FileType make setlocal noexpandtab "Ensure tabs don't get converted to spaces in Makefiles.

"================================================================================
"                          Plugins managed by vim-plug
"================================================================================
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-fugitive'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'mhinz/vim-grepper'
Plug 'terryma/vim-smooth-scroll'
"Plug 'kassio/neoterm'
call plug#end()

"================================================================================
"                                 keyBindings
"================================================================================
let g:mapleader="," "Leader Key and alias
nmap <space> ,
vmap <space> ,
noremap <silent><F1> :NERDTreeToggle<cr>
"Clear search highlights.
map <Leader><Space> :let @/=''<CR>
" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy
"all about find & replace.
nnoremap <leader>k :%s/\<<C-r><C-w>\>//g<left><left>
xnoremap <leader>k y :%s/<C-r>"//g<left><left>
nnoremap <leader>r :%s///g<left><left>
nnoremap <leader>rc :%s///gc<left><left><left>
xnoremap <leader>r :s///g<left><left>
xnoremap <leader>rc :s///gc<left><left><left>
" Type a replacement term and press . to repeat the replacement again (comparable to multiple cursors).
nnoremap <silent><leader>s :let @/='\<'.expand('<cword>').'\>'<cr>cgn
xnoremap <silent><leader>s "sy:let @/=@s<cr>cgn
"type // to search for the next occurrence of the selected text
"vnoremap // y/\V<C-R>=escape(@",'/\')<cr><cr>
"tab switch
nnoremap <silent>tn :tabnew<space>
nnoremap <silent>tp :tabprev<cr>
nnoremap <silent>tn :tabnext<cr>
"buffer switch
nnoremap <silent>-- :bp<cr>
nnoremap <silent>== :bn<cr>
"source (reload) your vimrc. Type space, s, o in sequence to trigger
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <silent><leader>er :tabnew $MYVIMRC<cr>
"press ctrl-hjkl to navigate in split
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
inoremap <C-h> <esc><C-w>h
inoremap <C-j> <esc><C-w>j
inoremap <C-k> <esc><C-w>k
inoremap <C-l> <esc><C-w>l
"press ctrl-q to delete buffer
tnoremap <silent><leader>q <C-\><C-n>:bd<cr>
nnoremap <silent><leader>q :bd<cr>
inoremap <silent><leader>q <esc>:bd<cr>
"jj to <Esc>
inoremap jj <esc>
tnoremap <esc> <C-\><C-n>
"smooth scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>

"================================================================================
"                                 Apperance
"================================================================================
set background=dark
colorscheme onedark
set termguicolors "enable true colors
set number relativenumber
set ruler
set splitright splitbelow "splits open at the bottom and right
set diffopt+=vertical "default diff split"
set noshowmode "don't show mode as airline already does
set hidden
"set cmdheight=2

"================================================================================
"                             NerdTree Settings
"================================================================================
"close NerdTree after last vim tab closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMapActivateNode='l' "l key to activate node
let NERDTreeMinimalUI=1 "do not show help message
let NERDTreeShowHidden=1 "show hidden files
let NERDTreeIgnore=[ '\.DS_Store$', '\~$', '\.hushlogin$', '\.Trash$', '\.git$' ]
let g:NERDTreeBookmarksFile = $NERDTREE_BOOKMARKS "change default bookmark path
"remove trailing '/' of dir node
augroup nerdtreehidecwd autocmd! | autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup end

"================================================================================
"                               Airline setup
"================================================================================
let g:airline#extensions#tabline#enabled = 1 "show tabline
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number type
let g:airline#extensions#tabline#buffer_idx_mode = 1
if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
let g:airline_symbols.branch = ' '
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.dirty=''
  let g:airline#extensions#branch#format = 'CustomBranchName'
  function! CustomBranchName(name)
    return  a:name . ' |'
  endfunction
"================================================================================
"                                  Fzf.vim
"================================================================================
" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<cr>
" Map a few common things to do with FZF.
nnoremap <silent><leader><Enter> :Buffers<cr>
nnoremap <silent><leader>l :Lines<cr>
nnoremap <silent><leader>h :History<cr>
" Allow passing optional flags into the Rg command. Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)

"================================================================================
"                                 Grepper
"================================================================================
let g:grepper={}
let g:grepper.tools=["rg"]
"Search terms in whole project (gernerally use before <leader>R)
xmap gr <plug>(GrepperOperator)
"Project wide find and replace. It's similar to <leader>r except this one applies to all matches across all files instead of just the current file.
nnoremap <Leader>R
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" The same as above except it works with a visual selection.
xmap <Leader>R
    \ "sy
    \ gvgr
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

"================================================================================
"                                    COC
"================================================================================
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <tab> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
