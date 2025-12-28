-- SynVim - Performance-Focused Neovim Config for Termux
-- Main entry point

-- Load core settings first (sets leader key and options)
require("synvim.settings")

-- Load lazy.nvim and plugins
require("synvim.lazy")

-- Load theme from saved preference or default
require("synvim.theme-switcher").load_theme()

-- Apply transparent backgrounds to all UI elements
require("synvim.transparent").setup()
