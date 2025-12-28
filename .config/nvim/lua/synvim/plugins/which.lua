-- SynVim Which-Key Plugin
-- Display keybindings in a popup

return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  opts = {
    preset = "modern",
    delay = 300,
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 10,
      },
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
    },
  },

  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register key groups
    wk.add({
      { "<leader>s", group = "Search" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>g", group = "Git" },
      { "<leader>gd", group = "Git Diff" },
      { "<leader>b", group = "Buffer" },
      { "<leader>w", group = "Window" },
      { "<leader>f", group = "Format" },
      { "<leader>x", group = "Diagnostics" },
      { "<leader>c", group = "Code/Color" },
      { "<leader>o", group = "Obsidian" },
      { "<leader>q", group = "Quit" },
      { "<leader>gt", group = "Git Toggle" },
      { "<leader>v", group = "Vim Practice" },
      { "<leader>n", group = "Notifications"}
    })
  end,
}
