return {
  "rcarriga/nvim-notify",
  lazy = false,
  enabled = false,
  opts = {
    stages = "fade_in_slide_out",
    timecut = 3000,
    level = 1,
    render = "wrapped-compact",
    top_down = true, -- important: makes them stack from top
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
