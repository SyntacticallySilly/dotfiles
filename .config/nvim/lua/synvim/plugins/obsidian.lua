-- SynVim Obsidian Plugin
-- Obsidian integration

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },

  opts = {
    workspaces = {
      {
        name = "Personal",
        path = "~/storage/shared/Documents/personal/",  -- Change to your vault path
      },
      -- {
      --   name = "Research",
      --   path = "~/storage/shared/Documents/Research",
      -- },
    },

    daily_notes = {
      folder = "06 - Daily",
      date_format = "%Y-%m-%d",
      -- date_format = "%d-%m-%Y",
      template = "99 - Meta/dailytemplate.md",
    },

    completion = {
      nvim_cmp = false,  -- We're using blink.cmp
      min_chars = 2,
    },

    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },

    ui = {
      enable = true,
      checkboxes = {
        [" "] = { char = "󰄱 ", hl_group = "ObsidianTodo" },
        ["x"] = { char = " ", hl_group = "ObsidianDone" },
      },
    },
  },

  keys = {
    { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Obsidian note" },
    { "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search Obsidian" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch notes" },
    { "<leader>ot", "<cmd>ObsidianToday<CR>", desc = "Today's note" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Show backlinks" },
    { "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "Show links" },
  },
}
