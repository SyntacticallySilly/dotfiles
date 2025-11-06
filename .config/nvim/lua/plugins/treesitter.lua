-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "markdown",
        "markdown_inline",
        "bash",
        "c",
        "cpp",
        "rust",
        "go",
        "java",
        "javascript",
        "lua",
        "python",
        "vim",
        "yaml",
        "json",
        "html",
        "css",
      },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
