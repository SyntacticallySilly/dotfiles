-- SynVim Beacon Plugin
-- Flash cursor on jumps

return {
  "rainbowhxch/beacon.nvim",
  event = "VeryLazy",

  opts = {
    enable = true,
    size = 40,
    fade = true,
    minimal_jump = 10,
    show_jumps = true,
    focus_gained = true,
    shrink = true,
    timeout = 250,
    ignore_buffers = {},
    ignore_filetypes = { "alpha", "NvimTree", "Trouble" },
  },

  config = function(_, opts)
    require("beacon").setup(opts)
  end,
}
