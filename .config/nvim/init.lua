-- SynVim - Performance-Focused Neovim Config for Termux
-- Main entry point
--
-- Load core settings first (sets leader key and options)
require("synvim.core.options")

require("synvim.core.keymaps").setup()

require("synvim.core.autocmds")

-- Load lazy.nvim and plugins
require("synvim.core.lazy")

-- Apply transparent backgrounds to all UI elements
require("synvim.core.transparent").setup()
