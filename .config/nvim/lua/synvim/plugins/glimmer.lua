-- SynVim Tiny Glimmer Plugin
-- Beautiful animations for yank, paste, undo/redo

return {
  "rachartier/tiny-glimmer.nvim",
  event = "VeryLazy",
  
  config = function()
    local glimmer = require("tiny-glimmer")
    
    glimmer.setup({
      -- Enable all animations
      enabled = true,
      
      -- Yank animation (pink fade)
      yank = {
        enabled = true,
        duration = 300,
        color = "#f5c2e7", -- Catppuccin Pink
      },
      
      -- Paste animation (green pulse)
      paste = {
        enabled = true,
        duration = 350,
        color = "#a6e3a1", -- Catppuccin Green
      },
      
      -- Search animation (yellow fade)
      search = {
        enabled = true,
        duration = 250,
        color = "#f9e2af", -- Catppuccin Yellow
      },
      
      -- Undo/Redo animation (mauve)
      undo = {
        enabled = true,
        duration = 300,
        color = "#cba6f7", -- Catppuccin Mauve
      },
      
      -- Performance for Termux
      performance = {
        max_highlight_count = 30,
      },
    })
    
    -- Toggle animation keymap only
    vim.keymap.set("n", "<leader>ua", function()
      glimmer.toggle()
      local status = glimmer.is_enabled() and "enabled" or "disabled"
      vim.notify("Glimmer animations " .. status, vim.log.levels.INFO)
    end, { desc = "Toggle Glimmer animations" })
  end,
}
