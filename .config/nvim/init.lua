-- SynVim - Performance-Focused Neovim Config for Termux
-- Main entry point
--
-- Load core settings first (sets leader key and options)
require("synvim.options")

require("synvim.keymaps").setup()

require("synvim.autocmds")

-- Load lazy.nvim and plugins
require("synvim.lazy")

-- Apply transparent backgrounds to all UI elements
require("synvim.transparent").setup()
