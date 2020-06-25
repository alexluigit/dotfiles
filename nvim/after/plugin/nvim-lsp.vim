if !has('nvim') | finish | endif

lua << END
  require'nvim_lsp'.vimls.setup{}
END

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

sign define LspDiagnosticsErrorSign text=•
sign define LspDiagnosticsWarningSign text=•
sign define LspDiagnosticsInformationSign text=•
sign define LspDiagnosticsHintSign text=⏽
