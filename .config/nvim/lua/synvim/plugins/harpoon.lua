-- SynVim Harpoon Plugin
-- Quick navigation to your favorite files

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  
  -- Load on demand
  event = "VeryLazy",
  cmd = "Harpoon",
  
  config = function()
    local harpoon = require("harpoon")
    
    -- Initialize harpoon
    harpoon:setup({
      settings = {
        save_on_change = true,     -- Auto-save marks
        sync_on_ui_close = true,   -- Sync when closing UI
      },
    })
    
    -- NOW load harpoon keymaps after harpoon is configured
    require("synvim.keymaps").harpoon_keymaps()
  end,
}
