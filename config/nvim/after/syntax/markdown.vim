unlet b:current_syntax
syntax include @yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml

syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" keepend contained conceal contains=markdownUrl
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter
    \ start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@="
    \ nextgroup=markdownLink,markdownId skipwhite
    \ contains=@markdownInline,markdownLineStart
    \ concealends

let s:done_include = {}
for s:type in g:markdown_fenced_languages
  if has_key(s:done_include, matchstr(s:type,'[^.]*'))
    continue
  endif
  let s:code_concealends = exists('g:markdown_conceal_code_blocks') ? ' concealends' : ''
  exe 'syn region markdownHighlight'.substitute(matchstr(s:type,'[^=]*$'),'\..*','','').' matchgroup=markdownCodeDelimiter start="^\s*\z(`\{3,\}\)*\s*\%({.\{-}\.\)\='.matchstr(s:type,'[^=]*').'}\=\S\@!.*$" end="^\s*\z1\ze\s*$" keepend contains=@markdownHighlight'.substitute(matchstr(s:type,'[^=]*$'),'\.','','g') . s:code_concealends
  exe 'syn region markdownHighlight'.substitute(matchstr(s:type,'[^=]*$'),'\..*','','').' matchgroup=markdownCodeDelimiter start="^\s*\z(\~\{3,\}\)*\s*\%({.\{-}\.\)\='.matchstr(s:type,'[^=]*').'}\=\S\@!.*$" end="^\s*\z1\ze\s*$" keepend contains=@markdownHighlight'.substitute(matchstr(s:type,'[^=]*$'),'\.','','g') . s:code_concealends
  let s:done_include[matchstr(s:type,'[^.]*')] = 1
endfor
unlet! s:type
unlet! s:done_include
