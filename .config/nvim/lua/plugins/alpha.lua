-- ~/.config/nvim/lua/plugins/alpha.lua
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set the highlight for the header (ANSI color 3 = yellow/brown)
    vim.cmd("hi AlphaHeader ctermfg=3")

    -- Set header with "SynVim" ASCII art
    dashboard.section.header.val = {
      "                                                     ",
      "   ███████╗██╗   ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗",
      "   ██╔════╝╚██╗ ██╔╝████╗  ██║██║   ██║██║████╗ ████║",
      "   ███████╗ ╚████╔╝ ██╔██╗ ██║██║   ██║██║██╔████╔██║",
      "   ╚════██║  ╚██╔╝  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "   ███████║   ██║   ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "   ╚══════╝   ╚═╝   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "                                                     ",
    }

    -- Apply the highlight to the header
    dashboard.section.header.opts.hl = "AlphaHeader"

    -- Set menu buttons
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", "  Config", ":cd ~/.config/nvim/lua | NvimTreeOpen<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
      dashboard.button("l", "  Lazy", ":Lazy<CR>"),
    }

    -- Set footer
    local function footer()
      local total_plugins = require("lazy").stats().count
      local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
      return datetime .. "   " .. total_plugins .. " plugins"
    end

    dashboard.section.footer.val = footer()

    -- Layout
    dashboard.config.layout = {
      { type = "padding", val = 8 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.config)
  end,
}
	
