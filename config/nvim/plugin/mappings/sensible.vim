" Map semicolon to colon
map                     ;             :
" Do not autojump to next result when searching with *
nnoremap                *             :keepj norm! mp*`p<cr>
xnoremap                *             ymp:keepj norm! /\V<C-r>=escape(@",'/\')<cr><C-v><C-m>`p<cr>
" Better visual indenting
vnoremap                <             <gv
vnoremap                >             >gv
" fast navigation
nnoremap <silent>       -             :EditVifm <bar> setl statusline=%#Normal#<cr>
" If {count} > 5, j/k(n/e in colemak) motion should be added to jumplist
noremap <expr>          e             (v:count > 5 ? "m'" . v:count : '') . 'k'
noremap <expr>          n             (v:count > 5 ? "m'" . v:count : '') . 'j'
" Better visual line moving
vnoremap <silent>       N             :m '>+1<CR>gv=gv
vnoremap <silent>       E             :m '<-2<CR>gv=gv
" Colemak fix
nnoremap                N             J
noremap                 k             e
noremap                 '             l
" Bring back n key functionality meanwhile disable n/N motion being added to jumplist
nnoremap <silent>       <C-l>         :keepj norm! n<cr>
nnoremap <silent>       <C-p>         :keepj norm! N<cr>
" Undo/Redo/Repeat last {cmd, macro}
nnoremap <silent>       u             :silent norm! u<cr>
nnoremap <silent>       <C-r>         @:
nnoremap <silent><expr> <CR>          empty(&buftype) ? '@@' : '<CR>'
" Disable EX mode
nnoremap                Q             <Nop>
" Yank to end of line
noremap                 Y             y$
" Map <C-i> to <F6> in terminal emulator, it will solove <TAB> and <C-i> hijack
nnoremap                <F6>          <C-i>
nnoremap                <Tab>         za
" Use arrow key navigating quickfix buffer
nnoremap <silent>       <Up>          :cprevious<CR>
nnoremap <silent>       <Down>        :cnext<CR>
" easy align
xmap                    ga            <Plug>(EasyAlign)
nmap                    ga            <Plug>(EasyAlign)
" fzf complete
imap                    <C-x><C-x>    <plug>(fzf-complete-word)
imap                    <C-x><C-l>    <plug>(fzf-complete-line)
" TextObj: `ia`, `aa` for inside/around angle bracket.(save <shift> for `<`)
omap                    aa            a<
xmap                    aa            a<
omap                    ia            i<
xmap                    ia            i<
" Textobj: function
xmap                    af            <Plug>(coc-funcobj-a)
omap                    af            <Plug>(coc-funcobj-a)
xmap                    if            <Plug>(coc-funcobj-i)
omap                    if            <Plug>(coc-funcobj-i)
