return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  event = 'LspAttach',
  enabled = false,
  sem_version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-mini/mini.icons", -- optional dependency
  },
  config = function()
    local barbecue = require('barbecue')
    barbecue.setup({
      show_modified = false,
      show_navic = true,
      attach_navic = true,
      show_dirname = false,
      show_basename = false,
      context_follow_icon_color = true,
      theme = {
        dirname = { italic = true },
        basename = { italic = true, bold = true },
      }
    })
  end
}
