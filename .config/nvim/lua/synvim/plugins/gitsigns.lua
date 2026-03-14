-- SynVim Gitsigns Plugin
-- Git integration with signs, hunks, and blame

return {
  "lewis6991/gitsigns.nvim",
  event = "InsertEnter",
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "│" },
      topdelete = { text = "│" },
      changedelete = { text = "│" },
      untracked = { text = "│" },
    },

    signcolumn = true,          -- Show signs in sign column
    numhl = true,               -- Don't highlight line numbers
    linehl = false,             -- Don't highlight lines
    word_diff = false,          -- Don't show word diff

    current_line_blame = false, -- Don't show blame by default
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 700,
    }

  },
}
