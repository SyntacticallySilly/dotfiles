-- SynVim Termux Plugin
-- Termux integration for battery status and more

return {
  "massix/termux.nvim",
  lazy = false,
  
  opts = {
    battery = {
      enabled = true,
      update_interval = 30000,  -- Update every 30 seconds
    },
    volume = {
      enabled = false,  -- Disable volume control
    },
  },
  
  config = function(_, opts)
    require("termux").setup(opts)
  end,
}
