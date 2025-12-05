-- SynVim Discord Rich Presence
-- Pure Lua, no building required

return {
  "andweeb/presence.nvim",
  event = "VeryLazy",
  
  config = function()
    require("presence").setup({
      -- General options
      auto_update = true,
      neovim_image_text = "SynVim - Perfect Neovim for Termux",
      main_image = "neovim",
      log_level = nil,
      debounce_timeout = 10,
      enable_line_number = false,
      blacklist = {},
      buttons = true,
      file_assets = {},
      show_time = true,

      -- Rich Presence text options
      editing_text = "Editing %s",
      file_explorer_text = "Browsing files",
      git_commit_text = "Committing changes",
      plugin_manager_text = "Managing plugins",
      reading_text = "Reading %s",
      workspace_text = "In %s",
      line_number_text = "Line %s out of %s",
    })
    
    -- Commands to toggle Discord presence
    vim.keymap.set("n", "<leader>ud", function()
      vim.cmd("PresenceToggle")
      vim.notify("Discord presence toggled", vim.log.levels.INFO)
    end, { desc = "Toggle Discord Presence" })
  end,
}
