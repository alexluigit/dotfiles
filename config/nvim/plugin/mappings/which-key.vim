let g:wkm = {}
let g:wkm['<Tab>'] = [ 'za',                                         '"#" buffer' ]
let g:wkm[' ']   = [ ':Files',                                       'find files' ]
let g:wkm['/']   = [ ':call whichkey#fix("comment")',                'comment' ]
let g:wkm[';']   = [ ':Commands',                                    'commands' ]
let g:wkm["i"]   = [ ':bnext',                                       'next buffer' ]
let g:wkm['o']   = [ ':bprevious',                                   'prev buffer' ]
let g:wkm['q']   = [ ':call whichkey#fix("quit")',                   'close buffer']
let g:wkm['u']   = [ ':redo',                                        'undo tree' ]
let g:wkm['v']   = [ ':LfVS',                                        'vertical' ]
let g:wkm['w']   = [ ':silent! w',                                   'save' ]
let g:wkm['x']   = [ ':silent! x',                                   'save & close' ]
let g:wkm['1']   = [ '<Plug>BufTabLine.Go(1)',                       'BufTab1' ]
let g:wkm['2']   = [ '<Plug>BufTabLine.Go(2)',                       'BufTab2' ]
let g:wkm['3']   = [ '<Plug>BufTabLine.Go(3)',                       'BufTab3' ]
let g:wkm['4']   = [ '<Plug>BufTabLine.Go(4)',                       'BufTab4' ]
let g:wkm['5']   = [ '<Plug>BufTabLine.Go(5)',                       'BufTab5' ]

let g:wkm.a = {} | let g:wkm.a['name'] = '+actions'
let g:wkm.a['a'] = [ '<Plug>VSurround',                              'around']
let g:wkm.a['c'] = [ ':let @/=""',                                   'clear highlight' ]
let g:wkm.a['d'] = [ ':windo diffthis',                              'diff' ]
let g:wkm.a['D'] = [ ':diffoff',                                     'diffoff' ]
let g:wkm.a['p'] = [ ':call whichkey#fix("regpaste")',               'paste from register']
let g:wkm.a['r'] = [ ':call whichkey#fix("replaceword")',            'replace cursor word' ]
let g:wkm.a['s'] = [ ':call whichkey#fix("regsend")',                'send to register']

let g:wkm.d = {} | let g:wkm.d['name'] = '+debug'
let g:wkm.d['b'] = ['<Plug>VimspectorToggleBreakpoint',              'breakpoint']
let g:wkm.d['B'] = ['<Plug>VimspectorToggleConditionalBreakpoint',   'conditional breakpoint']
let g:wkm.d['c'] = ['<Plug>VimspectorRunToCursor',                   'run to cursor']
let g:wkm.d['d'] = ['<Plug>VimspectorContinue',                      'continue']
let g:wkm.d['f'] = ['<Plug>VimspectorAddFunctionBreakpoint',         'function breakpoint']
let g:wkm.d['m'] = [':MaximizerToggle',                              'maximize window']
let g:wkm.d['o'] = ['<Plug>VimspectorStepOver',                      'step over']
let g:wkm.d['O'] = ['<Plug>VimspectorStepOut',                       'step out']
let g:wkm.d['i'] = ['<Plug>VimspectorStepInto',                      'step into']
let g:wkm.d['p'] = ['<Plug>VimspectorPause',                         'pause']
let g:wkm.d['r'] = ['<Plug>VimspectorRestart',                       'restart']
let g:wkm.d['s'] = ['<Plug>VimspectorStop',                          'stop']

let g:wkm.e = {} | let g:wkm.e['name'] = '+edit'
let g:wkm.e['d'] = [ ':call whichkey#fix("delete")',                 'delete current file' ]
let g:wkm.e['e'] = [ ':e',                                           'refresh']
let g:wkm.e['n'] = [ ':call whichkey#fix("newfile")',                'edit newfile' ]
let g:wkm.e['f'] = [ ':CocCommand workspace.renameCurrentFile',      'rename file']
let g:wkm.e['s'] = [ ':CocList snippets',                            'snippets']
let g:wkm.e['t'] = [ ':keepalt Todo',                                'todo list']

let g:wkm.g = {} | let g:wkm.g['name'] = '+git'
let g:wkm.g['a'] = [ ':diffget //2',                                 'get left diff' ]
let g:wkm.g['c'] = [ ':BCommits',                                    'buffer commits' ]
let g:wkm.g['C'] = [ ':Commits',                                     'repo commits' ]
let g:wkm.g['d'] = [ ':Git diff',                                    'diff' ]
let g:wkm.g['D'] = [ ':Gdiffsplit',                                  'diff split' ]
let g:wkm.g['o'] = [ ':diffget //3',                                 'get right diff' ]
let g:wkm.g['b'] = [ ':Git blame',                                   'blame' ]
let g:wkm.g['B'] = [ ':GBrowse',                                     'browse' ]
let g:wkm.g['g'] = [ ':vert Gstatus',                                'status' ]
let g:wkm.g['G'] = [ ':GGrep',                                       'git grep' ]
let g:wkm.g['i'] = [ ':CocCommand git.chunkInfo',                    'preview hunk' ]
let g:wkm.g['n'] = [ '<Plug>(coc-git-nextchunk)',                    'next hunk' ]
let g:wkm.g['e'] = [ '<Plug>(coc-git-prevchunk)',                    'prev hunk' ]
let g:wkm.g['m'] = [ '<Plug>(git-messenger)',                        'message' ]
let g:wkm.g['p'] = [ ':Git push',                                    'push' ]
let g:wkm.g['P'] = [ ':Git pull',                                    'pull' ]
let g:wkm.g['r'] = [ ':Gread',                                       'read head' ]
let g:wkm.g['R'] = [ ':Gremove',                                     'remove' ]
let g:wkm.g['s'] = [ ':CocCommand git.chunkStage',                   'stage hunk' ]
let g:wkm.g['u'] = [ ':CocCommand git.chunkUndo',                    'undo hunk' ]

let g:wkm.l = {} | let g:wkm.l['name'] = '+lsp'
let g:wkm.l[';'] = [ '<Plug>(coc-refactor)',                         'refactor' ]
let g:wkm.l['a'] = [ '<Plug>(coc-codeaction)',                       'code action' ]
let g:wkm.l['A'] = [ '<Plug>(coc-codeaction-selected)',              'selected action' ]
let g:wkm.l['b'] = [ ':CocNext',                                     'next action' ]
let g:wkm.l['B'] = [ ':CocPrev',                                     'prev action' ]
let g:wkm.l['c'] = [ ':CocList commands',                            'commands' ]
let g:wkm.l['d'] = [ '<Plug>(coc-declaration)',                      'declaration' ]
let g:wkm.l['D'] = [ '<Plug>(coc-definition)',                       'definition' ]
let g:wkm.l['e'] = [ ':CocList extensions',                          'extensions' ]
let g:wkm.l['f'] = [ '<Plug>(coc-format-selected)',                  'format selected' ]
let g:wkm.l['F'] = [ '<Plug>(coc-format)',                           'format' ]
let g:wkm.l['h'] = [ '<Plug>(coc-float-hide)',                       'hide' ]
let g:wkm.l['i'] = [ ':CocList diagnostics',                         'diagnostics' ]
let g:wkm.l['I'] = [ '<Plug>(coc-implementation)',                   'implementation' ]
let g:wkm.l['j'] = [ '<Plug>(coc-float-jump)',                       'float jump' ]
let g:wkm.l['l'] = [ '<Plug>(coc-codelens-action)',                  'code lens' ]
let g:wkm.l['n'] = [ '<Plug>(coc-diagnostic-next)',                  'next diagnostic' ]
let g:wkm.l['N'] = [ '<Plug>(coc-diagnostic-next-error)',            'next error' ]
let g:wkm.l['o'] = [ '<Plug>(coc-openlink)',                         'open link']
let g:wkm.l['O'] = [ ':CocList outline',                             'search outline' ]
let g:wkm.l['p'] = [ '<Plug>(coc-diagnostic-prev)',                  'prev diagnostic' ]
let g:wkm.l['P'] = [ '<Plug>(coc-diagnostic-prev-error)',            'prev error' ]
let g:wkm.l['q'] = [ '<Plug>(coc-fix-current)',                      'quickfix' ]
let g:wkm.l['r'] = [ '<Plug>(coc-references)',                       'references' ]
let g:wkm.l['R'] = [ '<Plug>(coc-rename)',                           'rename' ]
let g:wkm.l['s'] = [ ':CocList -I symbols',                          'references' ]
let g:wkm.l['t'] = [ '<Plug>(coc-type-definition)',                  'type definition' ]
let g:wkm.l['u'] = [ ':CocListResume',                               'resume list' ]
let g:wkm.l['U'] = [ ':CocUpdate',                                   'update CoC' ]
let g:wkm.l['z'] = [ ':CocDisable',                                  'disable CoC' ]
let g:wkm.l['Z'] = [ ':CocEnable',                                   'enable CoC' ]

let g:wkm.p = {} | let g:wkm.p['name'] = '+project'
let g:wkm.p['/'] = [ ':call Twf()',                                  'project treeview']
let g:wkm.p['t'] = [ ':Tags',                                        'tags' ]
let g:wkm.p['w'] = [ ':call whichkey#fix("cocsearch")',              'project search word' ]

let g:wkm.s = {} | let g:wkm.s['name'] = '+toggle'
let g:wkm.s['C'] = [ ':ColorizerToggle',                             'colorizer']
let g:wkm.s['n'] = [ ':set nu!',                                     'line numbers']
let g:wkm.s['N'] = [ ':set relativenumber!',                         'relative line nums']
let g:wkm.s['q'] = [ ':copen',                                       'quickfix']
let g:wkm.s['t'] = [ ':call whichkey#fix("toggletab")',              'toggle tab']

let g:wkm.t = {} | let g:wkm.t['name'] = '+telescope'
let g:wkm.t['f'] = [ ':GFiles',                                      'git files' ]
let g:wkm.t['g'] = [ ':GFiles?',                                     'modified git files' ]
let g:wkm.t['o'] = [ ':History',                                     'old files' ]
let g:wkm.t['h'] = [ ':Helptags',                                    'help tags' ]
let g:wkm.t['l'] = [ ':Lines',                                       'search all lines' ]
let g:wkm.t['m'] = [ ':Maps',                                        'normal maps' ]
let g:wkm.t['n'] = [ ':BLines',                                      'navigate lines in file' ]
let g:wkm.t['o'] = [ ':Buffers',                                     'opened buffers' ]
let g:wkm.t['r'] = [ ':Rg',                                          'rg search']
let g:wkm.t['t'] = [ ':Filetypes',                                   'filetypes' ]

nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
call which_key#register('<Space>', "g:wkm")

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noruler | autocmd BufLeave <buffer> set noruler laststatus=2

" this line is just a hotfix for whichkey timeout; track https://github.com/liuchengxu/vim-which-key/issues/158
nnoremap <silent> <leader>zz :echo ''<cr>
