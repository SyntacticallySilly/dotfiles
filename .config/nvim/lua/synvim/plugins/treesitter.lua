-- SynVim Treesitter Plugin
-- Syntax highlighting and code parsing with AST (Abstract Syntax Tree)

return {
  "nvim-treesitter/nvim-treesitter",
  enabled = false,
  lazy = true,
  event = 'BufReadPre',
  build = ':TSUpdate',

  config = function()
    require 'nvim-treesitter'.setup({
      install_dir = "~/bin/TS/parsers",
      auto_install = true,
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "dockerfile",
        "gleam",
        "go",
        "haskell",
        "hjson",
        "html",
        "ini",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "just",
        "kdl",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "nix",
        "purescript",
        "query",
        "racket",
        "regex",
        "rust",
        "terraform",
        "typescript",
        "typst",
        "vim",
        "vimdoc",
        "yaml",
        "zsh",
      },
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
