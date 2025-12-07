-- SynVim Lush Plugin
-- Colorscheme creation tool (lazy loaded on commands)

return {
  "rktjmp/lush.nvim",
  cmd = {
    "Lushify",
    "LushRunQuickstart",
    "LushRunTutorial",
    "LushExportToVimscript",
    "LushExportToLua",
  },
  -- No keys defined for performance - only loads on command
  
  config = function()
    -- Lush works out of the box, no setup needed
    -- Just loaded when commands are called
    
    -- Optional: Set up some autocmds for better UX when using Lush
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "lush",
      callback = function()
        -- Enable better syntax for lush files
        vim.opt_local.syntax = "on"
        vim.opt_local.conceallevel = 0
        
        -- Helpful info when opening lush files
        vim.notify("Lush colorscheme file loaded. Use :Lushify to enable live preview", vim.log.levels.INFO)
      end,
    })
  end,
}
