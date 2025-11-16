-- SynVim Harpoon Plugin
-- Quick navigation between important files

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  
  keys = {
    { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon Add" },
    { "<leader>hm", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon Menu" },
    { "<leader>h1", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
    { "<leader>h2", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
    { "<leader>h3", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
    { "<leader>h4", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
    { "<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Harpoon Prev" },
    { "<C-S-N>", function() require("harpoon"):list():next() end, desc = "Harpoon Next" },
  },
  
  config = function()
    local harpoon = require("harpoon")
    
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        key = function()
          return vim.loop.cwd()
        end,
      },
    })
  end,
}
