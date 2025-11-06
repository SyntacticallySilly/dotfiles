-- ~/.config/nvim/lua/plugins/mini-animate.lua
return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  opts = function()
    local animate = require("mini.animate")
    return {
      scroll = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
      },
      cursor = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
      },
      resize = { enable = false },
      open = { enable = false },
      close = { enable = false },
    }
  end,
}

