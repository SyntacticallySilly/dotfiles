-- SynVim Which-Key Plugin
-- Shows available keybindings in a floating popup

return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  opts = {
    preset = "modern",
    win = {
      border = "rounded",  -- Outlined container
      padding = { 1, 2 },  -- Padding inside popup
    },
    layout = {
      height = { min = 4, max = 30 },  -- Dynamic height
      spacing = 3,  -- Space between columns
    },
    show_help = true,  -- Show help message
    show_keys = true,  -- Show keys in popup
  },

  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register key groups with descriptions (v3 API)
    wk.add({
      { "<leader>s", group = "Search" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>g", group = "Git" },
      { "<leader>b", group = "Buffer" },
      { "<leader>w", group = "Window" },
      { "<leader>f", group = "Format" },
      { "<leader>x", group = "Diagnostics"},
      { "<leader>sn", group = "Nerd Font Icons" },
      { "<leader>c", group = "Color" },
      { "<leader>o", group = "Obsidian" },
      { "<leader>gt", group = "Git Toggle" },
    })
  end,
}
