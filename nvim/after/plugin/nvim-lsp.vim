if !has('nvim')
  finish
endif

lua << END
  require'nvim_lsp'.vimls.setup{}
END
