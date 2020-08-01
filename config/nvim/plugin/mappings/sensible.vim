" Map semicolon to colon, hit twice for semicolon
map                     ;             :
noremap                 ;;            ;
" Do not autojump to next result when searching with *
nnoremap                *             :keepj norm! mp*`p<cr>
xnoremap                *             ymp:keepj norm! /\V<C-r>=escape(@",'/\')<cr><C-v><C-m>`p<cr>
" Better visual indenting
vnoremap                <             <gv
vnoremap                >             >gv
" if {count} > 5, j/k motion should be added to jumplist
nnoremap <expr>         k             (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr>         j             (v:count > 5 ? "m'" . v:count : '') . 'j'
" Don't add n/N motion to jumplist
noremap  <silent>       n             :keepj norm! n<cr>
noremap  <silent>       N             :keepj norm! N<cr>
" Undo/Redo/Repeat last {cmd, macro}
nnoremap <silent>       u             :silent norm! u<cr>
nnoremap <silent>       <leader>u     <C-r>
nnoremap <silent>       <C-r>         @:
nnoremap <silent><expr> <CR>          empty(&buftype) ? '@@' : '<CR>'
" Disable EX mode
nnoremap                Q             <Nop>
" Yank to end of line
noremap                 Y             y$
" Map <C-i> to <F6> in terminal emulator, it will solove <TAB> and <C-i> hijack
nnoremap               <F6>           <C-i>
nnoremap               <Tab>          za
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
" Textobj: class (ac/ic are comment textobj)
xmap                    aC            <Plug>(coc-classobj-a)
omap                    aC            <Plug>(coc-classobj-a)
xmap                    iC            <Plug>(coc-classobj-i)
omap                    iC            <Plug>(coc-classobj-i)
