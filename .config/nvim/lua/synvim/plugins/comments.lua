-- SynVim Comment Plugin
-- Smart commenting for any language

return {
  "numToStr/Comment.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",  -- Better JSX/TSX comments
  },
  
  config = function()
    require("Comment").setup({
      -- Use treesitter for comment string detection
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      
      -- Normal mode mappings
      toggler = {
        line = "gcc",  -- Toggle line comment
        block = "gbc",  -- Toggle block comment
      },
      
      -- Visual mode mappings
      opleader = {
        line = "gc",  -- Line comment operator
        block = "gb",  -- Block comment operator
      },
      
      -- Extra mappings
      extra = {
        above = "gcO",  -- Comment above
        below = "gco",  -- Comment below
        eol = "gcA",    -- Comment at end of line
      },
    })
  end,
}
