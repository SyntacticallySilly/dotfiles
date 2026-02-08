-- SynVim Barbecue Plugin
-- VSCode-style breadcrumbs in winbar

return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  event = { "BufReadPost", "BufNewFile" },

  opts = {
    -- theme = "rose-pine", -- Matches your colorscheme automatically
    theme = {
      normal = { bg = "NONE", bold = true, italic = true},
      -- seperator = { fg = "love" },
      -- modified = { fg = "gold" },
      -- dirname = { fg = "rose" }
    },
    show_dirname = true,
    show_basename = true,
    show_modified = true,

    -- Performance optimizations for mobile
    create_autocmd = true, -- Auto-update on CursorHold
    attach_navic = true, -- Automatically attach to LSP
    show_navic = true,

    -- Layout
    lead_custom_section = function()
      return " "
    end,

    -- Context display settings
    context_follow_icon_color = true,
    include_buftypes = { "", "acwrite" },
    exclude_filetypes = {
      "netrw",
      "toggleterm",
      "alpha",
      "dashboard",
      "lazy",
      "mason",
      "TelescopePrompt",
      "neo-tree",
      "Trouble",
    },
  },

  config = function(_, opts)
    require("barbecue").setup(opts)

    -- Toggle barbecue keymap
    vim.keymap.set("n", "<leader>ub", function()
      require("barbecue.ui").toggle()
      vim.notify("Barbecue toggled", vim.log.levels.INFO)
    end, { desc = "Toggle Barbecue" })
  end,
}
