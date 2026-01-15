-- SynVim Yanky Plugin
-- Advanced yank history with Telescope integration

return {
  "gbprod/yanky.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  event = "VeryLazy",
  enabled = false,
  opts = {
    ring = {
      history_length = 100,
      storage = "shada",
      sync_with_numbered_registers = true,
      cancel_event = "update",
    },
    picker = {
      telescope = {
        use_default_mappings = true,
      },
    },
    system_clipboard = {
      sync_with_ring = true,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 300,
    },
    preserve_cursor_position = {
      enabled = true,
    },
  },

  keys = {
    -- Yank/Put with history
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },

    -- Cycle through yank history
    { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Previous yank" },
    { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Next yank" },

    -- Open yank history with Telescope
    { "<leader>sy", "<cmd>Telescope yank_history<CR>", desc = "Yank history" },
  },

  config = function(_, opts)
    require("yanky").setup(opts)
    require("telescope").load_extension("yank_history")
  end,
}
