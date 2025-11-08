-- SynVim Alpha Plugin
-- Startup dashboard with SynVim logo

return {
  "goolord/alpha-nvim",
  lazy = false,
  priority = 1000,
  
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    
    -- SynVim ANSI Logo (Block style - SYNVIM corrected)
local logo = {
  " ███████ ██    ██ ███    ██ ██    ██ ██ ███    ███ ",
  " ██       ██  ██  ████   ██ ██    ██ ██ ████  ████ ",
  " ███████   ████   ██ ██  ██ ██    ██ ██ ██ ████ ██ ",
  "      ██    ██    ██  ██ ██  ██  ██  ██ ██  ██  ██ ",
  " ███████    ██    ██   ████   ████   ██ ██      ██ ",
  "",
}
    
    dashboard.section.header.val = logo
    
    -- Menu buttons
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find files", ":Telescope find_files<CR>"),
      dashboard.button("n", "  New file", ":enew<CR>"),
      dashboard.button("c", "  Config", ":Telescope find_files cwd=" .. vim.fn.stdpath("config") .. "<CR>"),
      dashboard.button("l", "  Lazy", ":Lazy<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }
    
    -- Footer with version
    dashboard.section.footer.val = { "SynVim - Performance-focused Neovim for Termux" }
    
    -- Configure layout
    dashboard.config.opts.noautocmd = true
    
    alpha.setup(dashboard.config)
  end,
}
