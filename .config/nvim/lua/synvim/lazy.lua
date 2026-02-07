-- SynVim lazy.nvim Bootstrap
-- This file handles downloading and initializing lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Auto-download lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- Add lazy to runtime path so Neovim can find it
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with plugin directory
require("lazy").setup({
  spec = {
    { import = "synvim.plugins" },  -- Regular plugins
    { import = "synvim.plugins.rose-pine"}
    -- { import = "synvim.themes" },   -- Theme plugins
  },
  -- Performance optimization for Termux
  performance = {
    rtp = {
      disabled_plugins = {
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
      },
    },
  },
})
