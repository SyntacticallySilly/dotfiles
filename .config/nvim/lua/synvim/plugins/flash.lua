-- SynVim Flash Plugin
-- Enhanced navigation - jump anywhere with 2 keystrokes

return {
  "folke/flash.nvim",
  event = "VeryLazy",

  opts = {
    modes = {
      search = {
--[[         enabled = true,  -- Enhanced search ]]
      },
      char = {
        enabled = true,  -- Enhanced f/F/t/T
        jump_labels = true,
      },
    },
  },

  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
