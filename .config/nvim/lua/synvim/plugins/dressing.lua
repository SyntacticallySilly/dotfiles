-- SynVim Dressing Plugin
-- Better UI for input and select dialogs

return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",

  opts = {
    input = {
      enabled = true,
      default_prompt = " : ",
      border = "rounded",
      relative = "editor",
      prefer_width = 40,
      win_options = {
        winblend = 0,
      },
    },
    select = {
      enabled = true,
      backend = { "telescope", "builtin" },  -- Use Telescope for selections
      telescope = require("telescope.themes").get_dropdown({
        borderchars = {
          { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
          results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
      }),
    },
  },
}
