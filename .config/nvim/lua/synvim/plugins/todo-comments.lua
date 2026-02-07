-- SynVim Todo-Comments Plugin
-- Highlight and search TODO, FIXME, BUG, etc. in comments

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "TodoTrouble", "TodoTelescope", "TodoQuickFix" },
  
  opts = {
    signs = true,  -- Show icons in sign column
    sign_priority = 8,
    
    -- Keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = " ",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    
    -- Highlighting style
    highlight = {
      multiline = true,
      before = "",
      keyword = "wide",  -- Highlight the keyword widely
      after = "fg",
      pattern = [[.*<(KEYWORDS)s*:]],
      comments_only = true,  -- Only in comments (uses treesitter)
      max_line_len = 400,
    },
    
    -- Colors (uses Catppuccin)
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test = { "Identifier", "#FF00FF" },
    },
  },
  
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo" },
    { "<leader>st", "<cmd>TodoTelescope<CR>", desc = "Search Todos" },
    { "<leader>sq", "<cmd>TodoQuickFix<CR>", desc = "Todo Quickfix" },
  },
}
