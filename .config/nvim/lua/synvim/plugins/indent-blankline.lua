-- SynVim Indent Blankline Plugin
-- Show indent guides

return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",

  opts = {
    indent = {
      char = "│",  -- Indent line character
      tab_char = "│",
    },

    scope = {
      enabled = true,  -- Highlight current scope
      show_start = true,
      show_end = true,
      injected_languages = true,
      highlight = { "Function", "Label" },
      priority = 500,
    },

    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "NvimTree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      buftypes = {
        "terminal",
        "nofile",
      },
    },
  },
}
