-- ~/.config/nvim/lua/core/init.lua
require("core.settings")
require("core.lazy")
require("core.keymaps")

require("lazy").setup({
  spec = {
    { import = "plugins" },  -- Import all plugin files
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },  -- Auto-check for updates
})

