local disabled_builtin_plugins = {
  "gzip",
  "matchit",
  "matchparen",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "tarPlugin",
  "tohtml",
  "tutor",
  "zipPlugin",
}

for _, plugin in ipairs(disabled_builtin_plugins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.pack.add({
  "https://github.com/zuqini/zpack.nvim",
})

require("zpack").setup({
  spec = {
    { import = "synvim.plugins" },
    { import = "synvim.colorschemes" },
    { import = "synvim.plugins.lang" },
  },
  defaults = {
    confirm = true,
  },
  performance = {
    vim_loader = true,
  },
  cmd_prefix = "Z",
})
