-- ~/.config/nvim/lua/plugins/notify.lua
return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    stages = "fade",
    timeout = 3000,
    background_colour = "#000000",
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎",
    },
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
  end,
}

