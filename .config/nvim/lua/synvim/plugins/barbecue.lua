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
    theme = "auto", -- Matches your colorscheme automatically
    show_dirname = true,
    show_basename = true,
    show_modified = false,

    -- Symbols
    kinds = {
      File = "󰈙 ",
      Module = " ",
      Namespace = "󰌗 ",
      Package = " ",
      Class = "󰌗 ",
      Method = "󰆧 ",
      Property = " ",
      Field = " ",
      Constructor = " ",
      Enum = "󰕘",
      Interface = "󰕘",
      Function = "󰊕 ",
      Variable = "󰆧 ",
      Constant = "󰏿 ",
      String = "󰀬 ",
      Number = "󰎠 ",
      Boolean = "◩ ",
      Array = "󰅪 ",
      Object = "󰅩 ",
      Key = "󰌋 ",
      Null = "󰟢 ",
      EnumMember = " ",
      Struct = "󰌗 ",
      Event = " ",
      Operator = "󰆕 ",
      TypeParameter = "󰊄 ",
    },

    -- Performance optimizations for mobile
    create_autocmd = true, -- Auto-update on CursorHold
    attach_navic = true, -- Automatically attach to LSP
    show_navic = true,

    -- Layout
    lead_custom_section = function()
      return " "
    end,

    -- Context display settings
    context_follow_icon_color = false,
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
