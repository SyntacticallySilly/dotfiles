return {
  'rasulomaroff/reactive.nvim',
  lazy = true,
  enabled = false,
  opts = {
    builtin = {
      cursorline = true,
      cursor = true,
      modemsg = true
    },
  },

  config = function(_, opts)
    local reactive = require('reactive')
    reactive.setup(opts)
  end,
}
