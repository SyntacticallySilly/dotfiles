-- SynVim Nerdy Plugin
-- Nerd font icon picker

return {
  "2KAbhishek/nerdy.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  cmd = "Nerdy",
  
  keys = {
    { "<leader>sni", "<cmd>Nerdy<CR>", desc = "Search Nerd Icons" },
  },
}
