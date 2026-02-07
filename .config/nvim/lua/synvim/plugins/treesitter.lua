-- SynVim Treesitter Plugin
-- Syntax highlighting and code parsing with AST (Abstract Syntax Tree)

return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",                              -- Auto-compile parsers when installing/updating
  event = { "BufReadPre", "BufNewFile" },           -- Lazy load when opening files
  cmd = { "TSInstall", "TSUpdate", "TSBufEnable" }, -- Also load on these commands

  opts = {
    ensure_installed = {
      -- Languages you use frequently (add/remove as needed)
      "lua",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "json",
      "yaml",
      "toml",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "python",
      "go",
      "gomod",
      "gosum",
      "rust",
      "c",
      "cpp",
    },

    -- Auto-install parsers when opening new file types
    auto_install = true,

    -- Enable syntax highlighting
    highlight = {
      enable = true,                                      -- Enable Treesitter highlighting
      additional_vim_regex_highlighting = { "markdown" }, -- Use regex for markdown
    },

    -- Enable indentation based on Treesitter
    indent = {
      enable = true,
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  }
}
