-- ~/.config/nvim/lua/plugins/render-markdown.lua
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown", "norg", "rmd" },
  config = function()
    require("render-markdown").setup({
      file_types = { "markdown", "norg", "rmd" },
      render_modes = { "n", "c" },
      anti_conceal = {
        enabled = true,
      },
      heading = {
        enabled = true,
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      code = {
        enabled = true,
        sign = false,
        style = "full",
        position = "left",
        language_name = true,
        disable_background = { "diff" },
        width = "full",
        left_margin = 0,
        left_pad = 2,
        right_pad = 2,
      },
      dash = {
        enabled = true,
        icon = "─",
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "☐ " },
        checked = { icon = "☑ " },
      },
      quote = {
        enabled = true,
        icon = "▋",
      },
      table = {
        enabled = true,
      },
      callout = {
        note = { raw = "[!NOTE]", rendered = "Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = "Tip", highlight = "RenderMarkdownSuccess" },
        warning = { raw = "[!WARNING]", rendered = "Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = "Caution", highlight = "RenderMarkdownError" },
        important = { raw = "[!IMPORTANT]", rendered = "Important", highlight = "RenderMarkdownError" },
      },
      link = {
        enabled = true,
        hyperlink = "🔗 ",
        image = "🖼 ",
      },
      latex = {
        enabled = false,  -- Disable latex to avoid missing parser
      },
      html = {
        enabled = false,  -- Disable html to avoid missing parser
      },
    })

    -- Keymaps
    local keymap = vim.keymap
    keymap.set("n", "<leader>mr", function()
      require("render-markdown").toggle()
    end, { desc = "Toggle markdown rendering" })
  end,
}
