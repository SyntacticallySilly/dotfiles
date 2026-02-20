return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  enabled = true,
  opts = {
    stages = "fade_in_slide_out",
    timeout = 3000,
    render = "compact",
    top_down = true,            -- important: makes them stack from top
    background_colour = "#000000",
    max_width = function()
      return math.floor(vim.o.columns * 0.4)
    end,
  },
  config = function(_, opts)
    require("notify").setup(opts)
    vim.notify = require("notify")
  end,
}
