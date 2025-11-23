-- SynVim Render-Markdown Plugin
-- Beautiful markdown rendering in Neovim

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = "markdown",  -- Load only for markdown files

  opts = {
    -- Headings
    heading = {
      enabled = true,
      sign = true,
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },

    -- Code blocks
    code = {
      enabled = true,
      sign = true,
      style = "full",
      left_pad = 2,
      right_pad = 2,
      width = "block",
      border = "rounded",
    },

    -- Bullet points
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
    },

    -- Checkboxes
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰱒 " },
    },

    -- Links
    link = {
      enabled = true,
      image = "󰥶 ",
      hyperlink = "󰌹 ",
    },

    -- Tables
    pipe_table = {
      enabled = true,
      style = "full",
      cell = "padded",
    },

    -- Quotes
    quote = {
      enabled = true,
      icon = "▋",
      repeat_linebreak = true,
    },
  },

  config = function(_, opts)
    require("render-markdown").setup(opts)
  end,
}
