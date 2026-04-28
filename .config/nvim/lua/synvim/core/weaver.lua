-- Bootstrap weaver.nvim via vim.pack
vim.pack.add({ "https://github.com/SyntacticallySilly/weaver.nvim" })

require("weaver").setup({
  { import = "synvim.plugins" },
  { import = "synvim.colorschemes" },
  { import = "synvim.plugins.lang" }
})
