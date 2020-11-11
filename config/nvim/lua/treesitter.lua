require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    disable = {"vue"}
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
