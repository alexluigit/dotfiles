" set scriptencoding after 'encoding' and when using multibyte chars
scriptencoding utf-8
" standard fix/safety: line continuation (avoiding side effects) {{{1
let s:save_cpo = &cpo
set cpo&vim

" config enable / disable settings {{{1
"========================================================================
function! s:set(var, default) abort
  if !exists(a:var)
    if type(a:default)
      execute 'let' a:var '=' string(a:default)
    else
      execute 'let' a:var '=' a:default
    endif
  endif
endfunction

call s:set('g:webdevicons_enable', 1)
call s:set('g:DevIconsAppendArtifactFix', has('gui_running') ? 1 : 0)
call s:set('g:DevIconsArtifactFixChar', ' ')
call s:set('g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol', '')
call s:set('g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol', '')
call s:set('g:WebDevIconsUnicodeDecorateFolderNodesSymlinkSymbol',  '')
" }}}

" local functions {{{2
"========================================================================
" scope: local
function! s:setDictionaries()
  let s:file_node_extensions = {
        \ 'styl'     : '',
        \ 'sass'     : '',
        \ 'scss'     : '',
        \ 'htm'      : '',
        \ 'html'     : '',
        \ 'slim'     : '',
        \ 'haml'     : '',
        \ 'ejs'      : '',
        \ 'css'      : '',
        \ 'less'     : '',
        \ 'md'       : '',
        \ 'mdx'      : '',
        \ 'markdown' : '',
        \ 'rmd'      : '',
        \ 'json'     : '',
        \ 'webmanifest' : '',
        \ 'js'       : '',
        \ 'mjs'      : '',
        \ 'jsx'      : '',
        \ 'rb'       : '',
        \ 'gemspec'  : '',
        \ 'rake'     : '',
        \ 'php'      : '',
        \ 'py'       : '',
        \ 'pyc'      : '',
        \ 'pyo'      : '',
        \ 'pyd'      : '',
        \ 'coffee'   : '',
        \ 'mustache' : '',
        \ 'hbs'      : '',
        \ 'conf'     : '',
        \ 'ini'      : '',
        \ 'yml'      : '',
        \ 'yaml'     : '',
        \ 'toml'     : '',
        \ 'bat'      : '',
        \ 'jpg'      : '',
        \ 'jpeg'     : '',
        \ 'bmp'      : '',
        \ 'png'      : '',
        \ 'webp'     : '',
        \ 'gif'      : '',
        \ 'ico'      : '',
        \ 'twig'     : '',
        \ 'cpp'      : '',
        \ 'c++'      : '',
        \ 'cxx'      : '',
        \ 'cc'       : '',
        \ 'cp'       : '',
        \ 'c'        : '',
        \ 'cs'       : '',
        \ 'h'        : '',
        \ 'hh'       : '',
        \ 'hpp'      : '',
        \ 'hxx'      : '',
        \ 'hs'       : '',
        \ 'lhs'      : '',
        \ 'lua'      : '',
        \ 'java'     : '',
        \ 'sh'       : '',
        \ 'fish'     : '',
        \ 'bash'     : '',
        \ 'zsh'      : '',
        \ 'ksh'      : '',
        \ 'csh'      : '',
        \ 'awk'      : '',
        \ 'ps1'      : '',
        \ 'ml'       : 'λ',
        \ 'mli'      : 'λ',
        \ 'diff'     : '',
        \ 'db'       : '',
        \ 'sql'      : '',
        \ 'dump'     : '',
        \ 'clj'      : '',
        \ 'cljc'     : '',
        \ 'cljs'     : '',
        \ 'edn'      : '',
        \ 'scala'    : '',
        \ 'go'       : '',
        \ 'dart'     : '',
        \ 'xul'      : '',
        \ 'sln'      : '',
        \ 'suo'      : '',
        \ 'pl'       : '',
        \ 'pm'       : '',
        \ 't'        : '',
        \ 'rss'      : '',
        \ 'f#'       : '',
        \ 'fsscript' : '',
        \ 'fsx'      : '',
        \ 'fs'       : '',
        \ 'fsi'      : '',
        \ 'rs'       : '',
        \ 'rlib'     : '',
        \ 'd'        : '',
        \ 'erl'      : '',
        \ 'hrl'      : '',
        \ 'ex'       : '',
        \ 'exs'      : '',
        \ 'eex'      : '',
        \ 'leex'     : '',
        \ 'vim'      : '',
        \ 'ai'       : '',
        \ 'psd'      : '',
        \ 'psb'      : '',
        \ 'ts'       : '',
        \ 'tsx'      : '',
        \ 'jl'       : '',
        \ 'pp'       : '',
        \ 'vue'      : '﵂',
        \ 'elm'      : '',
        \ 'swift'    : '',
        \ 'xcplayground' : '',
        \ 'tex'      : 'ﭨ',
        \ 'r'        : 'ﳒ',
        \ 'rproj'    : '鉶'
        \}
  let s:file_node_exact_matches = {
        \ 'exact-match-case-sensitive-1.txt' : '1',
        \ 'exact-match-case-sensitive-2'     : '2',
        \ 'gruntfile.coffee'                 : '',
        \ 'gruntfile.js'                     : '',
        \ 'gruntfile.ls'                     : '',
        \ 'gulpfile.coffee'                  : '',
        \ 'gulpfile.js'                      : '',
        \ 'gulpfile.ls'                      : '',
        \ 'mix.lock'                         : '',
        \ 'dropbox'                          : '',
        \ '.ds_store'                        : '',
        \ '.gitconfig'                       : '',
        \ '.gitignore'                       : '',
        \ '.gitlab-ci.yml'                   : '',
        \ '.bashrc'                          : '',
        \ '.zshrc'                           : '',
        \ '.vimrc'                           : '',
        \ '.gvimrc'                          : '',
        \ '_vimrc'                           : '',
        \ '_gvimrc'                          : '',
        \ '.bashprofile'                     : '',
        \ 'favicon.ico'                      : '',
        \ 'license'                          : '',
        \ 'node_modules'                     : '',
        \ 'react.jsx'                        : '',
        \ 'procfile'                         : '',
        \ 'dockerfile'                       : '',
        \ 'docker-compose.yml'               : '',
        \ 'rakefile'                         : '',
        \ 'config.ru'                        : '',
        \ 'gemfile'                          : '',
        \ 'makefile'                         : '',
        \ 'cmakelists.txt'                   : ''
        \}
  let s:file_node_pattern_matches = {
        \ '.*jquery.*\.js$'       : '',
        \ '.*angular.*\.js$'      : '',
        \ '.*backbone.*\.js$'     : '',
        \ '.*require.*\.js$'      : '',
        \ '.*materialize.*\.js$'  : '',
        \ '.*materialize.*\.css$' : '',
        \ '.*mootools.*\.js$'     : '',
        \ '.*vimrc.*'             : '',
        \ 'Vagrantfile$'          : ''
        \}
  if !exists('g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols')
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
  endif
  if !exists('g:WebDevIconsUnicodeDecorateFileNodesExactSymbols')
    " do not remove: exact-match-case-sensitive-*
    let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
  endif
  if !exists('g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols')
    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
  endif
  " iterate to fix allow user overriding of specific individual keys in vimrc (only gvimrc was working previously)
  for [key, val] in items(s:file_node_extensions)
    if !has_key(g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols, key)
      let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[key] = val
    endif
  endfor
  " iterate to fix allow user overriding of specific individual keys in vimrc (only gvimrc was working previously)
  for [key, val] in items(s:file_node_exact_matches)
    if !has_key(g:WebDevIconsUnicodeDecorateFileNodesExactSymbols, key)
      let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols[key] = val
    endif
  endfor
  " iterate to fix allow user overriding of specific individual keys in vimrc (only gvimrc was working previously)
  for [key, val] in items(s:file_node_pattern_matches)
    if !has_key(g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols, key)
      let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols[key] = val
    endif
  endfor
endfunction

" public functions {{{2
"========================================================================
" a:1 (bufferName), a:2 (isDirectory)
" scope: public
function! WebDevIconsGetFileTypeSymbol(...)
  if a:0 == 0
    let fileNodeExtension = expand('%:e')
    let fileNode = expand('%:t')
    let isDirectory = 0
  else
    let fileNodeExtension = fnamemodify(a:1, ':e')
    let fileNode = fnamemodify(a:1, ':t')
    if a:0 > 1
      let isDirectory = a:2
    else
      let isDirectory = 0
    endif
  endif
  if isDirectory == 0 || g:DevIconsEnableFolderPatternMatching
    let symbol = g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol
    let fileNodeExtension = tolower(fileNodeExtension)
    let fileNode = tolower(fileNode)
    for [pattern, glyph] in items(g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols)
      if match(fileNode, pattern) != -1
        let symbol = glyph
        break
      endif
    endfor
    if symbol == g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol
      if has_key(g:WebDevIconsUnicodeDecorateFileNodesExactSymbols, fileNode)
        let symbol = g:WebDevIconsUnicodeDecorateFileNodesExactSymbols[fileNode]
      elseif ((isDirectory == 1 && g:DevIconsEnableFolderExtensionPatternMatching) || isDirectory == 0) && has_key(g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols, fileNodeExtension)
        let symbol = g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[fileNodeExtension]
      elseif isDirectory == 1
        let symbol = g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol
      endif
    endif
  else
    let symbol = g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol
  endif
  let artifactFix = s:DevIconsGetArtifactFix()
  return symbol . artifactFix
endfunction

" scope: local
" Temporary (hopefully) fix for glyph issues in gvim (proper fix is with the
" actual font patcher)
function! s:DevIconsGetArtifactFix()
  if g:DevIconsAppendArtifactFix == 1
    let artifactFix = g:DevIconsArtifactFixChar
  else
    let artifactFix = ''
  endif
  return artifactFix
endfunction

" call setup after processing all the functions (to avoid errors) {{{1
"========================================================================
call s:setDictionaries()

" standard fix/safety: line continuation (avoiding side effects) {{{1
"========================================================================
let &cpo = s:save_cpo
unlet s:save_cpo

" modeline syntax:
" vim: fdm=marker tabstop=2 softtabstop=2 shiftwidth=2 expandtab:
