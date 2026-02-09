-- SynVim Treesitter Plugin
-- Syntax highlighting and code parsing with AST (Abstract Syntax Tree)

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ':TSUpdate',


  require'nvim-treesitter'.setup {
    install_dir = "~/bin/TS/parsers",
  },
}
