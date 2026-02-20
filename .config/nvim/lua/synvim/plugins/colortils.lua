return {
  {
    "max397574/colortils.nvim",
    cmd = {
      "Colortils",
      "ColortilsDarken",
      "ColortilsLighten",
      "ColortilsComplement",
      "ColortilsInvert",
      "ColortilsGreyscale",
      "ColortilsMix",
      "ColortilsToHex",
      "ColortilsToRgb",
      "ColortilsToHsl",
    },
    opts = {
      -- Default options (fully expanded for you to tweak later)

      register = "+", -- register to copy results to

      default_format = "hex", -- default output format (hex, rgb, hsl)

      border = "rounded", -- window border style
      preview = true, -- show preview window
      width = 40, -- popup width
      height = 10, -- popup height

      mappings = {
        increment = "l",
        decrement = "h",
        increment_big = "L",
        decrement_big = "H",
        set_register_default_format = "r",
        set_register_other_format = "R",
        replace_default_format = "<CR>",
        replace_other_format = "g<CR>",
        clear_line = "x",
        exit = "q",
      },

      -- Highlight group options
      highlight = {
        preview = "ColortilsPreview",
        input = "ColortilsInput",
        border = "ColortilsBorder",
      },
    },
  },
  vim.keymap.set('n', '<leader>cc', '<cmd>Colortils<CR>', { desc = "Pick color"})
}

