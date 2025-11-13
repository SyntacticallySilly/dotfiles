-- SynVim CCC Plugin
-- Advanced color picker and highlighter

return {
  "uga-rosa/ccc.nvim",
  event = { "BufReadPre", "BufNewFile" },
  
  opts = {
    highlighter = {
      auto_enable = true,
      lsp = true,
    },
  },
  
  keys = {
    { "<leader>cp", "<cmd>CccPick<CR>", desc = "Color Picker" },
    { "<leader>cc", "<cmd>CccConvert<CR>", desc = "Color Convert" },
    { "<leader>ct", "<cmd>CccHighlighterToggle<CR>", desc = "Toggle Color Highlighter" },
  },
  
  config = function(_, opts)
    require("ccc").setup(opts)
  end,
}
