-- ~/.config/nvim/lua/plugins/dressing.lua
return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      enabled = true,
      default_prompt = "➤ ",
      win_options = {
        winblend = 0,
      },
    },
    select = {
      enabled = true,
      backend = { "telescope", "fzf_lua", "builtin", "nui" },
      telescope = require("telescope.themes").get_dropdown(),
    },
  },
}

