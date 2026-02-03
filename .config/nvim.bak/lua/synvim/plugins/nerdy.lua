-- SynVim Nerdy Plugin
-- Nerd font icon picker

return {
  "2KAbhishek/nerdy.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  cmd = "Nerdy",

  config = function()
    -- Load the extension
    require("telescope").load_extension("nerdy")
  end,

  keys = {
    { "<leader>si", "<cmd>Telescope nerdy<CR>", desc = "Search Nerd Icons" },
  },
}
