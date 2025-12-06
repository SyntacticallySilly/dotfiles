-- SynVim LuxMotion Plugin
-- Smooth motion animations for all movement commands

return {
  "LuxVim/nvim-luxmotion",
  event = "VeryLazy",

  opts = {
    cursor = {
      duration = 1000,        -- Faster for Termux performance
      easing = "ease-in-out",
      enabled = true,
    },
    scroll = {
      duration = 1000,        -- Smooth but not too slow
      easing = "ease-in-out",
      enabled = true,
    },
    performance = {
      enabled = false,       -- Can enable if you experience lag
    },
    keymaps = {
      cursor = true,         -- Enable smooth cursor movement
      scroll = true,         -- Enable smooth scrolling
    },
  },

  config = function(_, opts)
    require("luxmotion").setup(opts)
  end,

  keys = {
    { "<leader>tm", "<cmd>LuxMotionToggle<CR>", desc = "Toggle LuxMotion" },
    { "<leader>tc", "<cmd>LuxMotionCursorToggle<CR>", desc = "Toggle cursor motion" },
    { "<leader>ts", "<cmd>LuxMotionScrollToggle<CR>", desc = "Toggle scroll motion" },
  },
}
