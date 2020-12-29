vim.cmd('packadd! coc.nvim')
vim.cmd('packadd! nvim-colorizer.lua')
vim.cmd('packadd! nvim-web-devicons')
vim.cmd('packadd! fzf')
vim.cmd('packadd! fzf.vim')
vim.cmd('packadd! tcomment_vim')
vim.cmd('packadd! nvim-treesitter')
vim.cmd('packadd! vim-textobj-user')
vim.cmd('packadd! vim-textobj-quotes')
vim.cmd('packadd! vim-textobj-indent')
vim.cmd('packadd! vim-sneak')
vim.cmd('packadd! vim-easy-align')
vim.cmd('packadd! vim-surround')
vim.cmd('packadd! vim-fugitive')
vim.cmd('packadd! vim-repeat')
vim.cmd('packadd! vim-eunuch')
vim.cmd('packadd! vim-slime')
vim.cmd('packadd! vim-which-key')

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    disable = { "vue", "json" }
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
