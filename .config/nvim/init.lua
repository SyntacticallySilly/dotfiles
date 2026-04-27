-- SynVim - Performance-Focused Neovim Config for Termux
-- Main entry point
vim.g.synvim_start_time = (vim.uv or vim.loop).hrtime()

-- Load core settings first (sets leader key and options)
require("synvim.core.options")
require("synvim.core.keymaps").setup()
require("synvim.core.autocmds")
-- require("synvim.core.startup").setup()
-- require("synvim.core.weaver")
require("synvim.core.lazy")

require("synvim.core.lsp")
