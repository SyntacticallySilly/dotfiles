-- SynVim - Performance-Focused Neovim Config for Termux
-- Main entry point
-- vim.g.synvim_start_time = (vim.uv or vim.loop).hrtime()

-- Load core settings first (sets leader key and options)
require("core.options")
require("core.keymaps").setup()
require("core.lazy")
require("core.autocmds")
-- require(".core.startup").setup()
-- require(".core.weaver")
require("core.lsp")
require("core.highlights")
require("scripts.lsp_hover").setup()
require("scripts.undotree")
require("scripts.lsp_idle").setup()
