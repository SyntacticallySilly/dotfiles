-- SynVim Neoscroll Plugin
-- Smooth scrolling animations

return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",

  keys = {
    { "<C-u>", function() require("neoscroll").scroll(-vim.wo.scroll, { move_cursor = true, duration = 150 }) end },
    { "<C-d>", function() require("neoscroll").scroll(vim.wo.scroll, { move_cursor = true, duration = 150 }) end },
    { "<C-b>", function() require("neoscroll").scroll(-vim.api.nvim_win_get_height(0), { move_cursor = true, duration = 250 }) end },
    { "<C-f>", function() require("neoscroll").scroll(vim.api.nvim_win_get_height(0), { move_cursor = true, duration = 250 }) end },
    { "<C-y>", function() require("neoscroll").scroll(-0.10, { move_cursor = false, duration = 100 }) end },
    { "<C-e>", function() require("neoscroll").scroll(0.10, { move_cursor = false, duration = 100 }) end },
    { "zt", function() require("neoscroll").zt({ half_win_duration = 150 }) end },
    { "zz", function() require("neoscroll").zz({ half_win_duration = 150 }) end },
    { "zb", function() require("neoscroll").zb({ half_win_duration = 150 }) end },
  },

  opts = {
    hide_cursor = false,
    stop_eof = true,
    respect_scrolloff = true,
    cursor_scrolls_alone = true,
    easing = "sine",
    performance_mode = false,
  },
}
