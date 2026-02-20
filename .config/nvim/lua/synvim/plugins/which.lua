-- SynVim Which-Key Plugin
-- Display keybindings in a popup

return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  opts = {
    preset = "helix",
    delay = 300,
    notify = true,

    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 10,
      },
    },
    presets = {
      operators = true,                                   -- adds help for operators like d, y, ...
      motions = true,                                     -- adds help for motions
      text_objects = true,                                -- help for text objects triggered after entering an operator
      windows = true,                                     -- default bindings on <c-w>
      nav = true,                                         -- misc bindings to work with windows
      z = true,                                           -- bindings for folds, spelling and others prefixed with z
      g = true,                                           -- bindings for prefixed with g
    },
    win = {
      border = "rounded",
      title = true,
      title_pos = "center",
      padding = { 1, 2 },
    },
  },

  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register key groups
    wk.add({
      { "<leader>s", group = "Search" },
      { "<leader>g", group = "Git" },
      { "<leader>b", group = "Buffer/Bookmark" },
      { "<leader>w", group = "Window" },
      { "<leader>f", group = "Format" },
      { "<leader>x", group = "Diagnostics" },
      { "<leader>c", group = "Code/Color" },
      { "<leader>o", group = "Obsidian" },
      { "<leader>q", group = "Quit" },
      { "<leader>t", group = "Terminal" },
      { "<leader>n", group = "Notifications"}
    })
  end,
}
