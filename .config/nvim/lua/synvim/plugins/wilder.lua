-- SynVim Wilder Plugin
-- Completions without prompt

return {
  "gelguy/wilder.nvim",
  build = ":UpdateRemotePlugins",
  event = "CmdlineEnter",
  dependencies = {
    "folke/noice.nvim",
  },

  config = function()
    local wilder = require("wilder")

    wilder.setup({
      modes = { ":", "/" },
    })

    -- Lua-only pipeline
    wilder.set_option("use_python_remote_plugin", 0)

    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline({
          language = "vim",
          fuzzy = 1,
        }),
        wilder.vim_search_pipeline()
      ),
    })

    -- Renderer with NO prompt at all
    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        highlighter = wilder.basic_highlighter(),
        border = "rounded",

        -- Size
        min_width = 50,
        max_width = 70,
        max_height = 8,
        min_height = 0,

        pumblend = 1,
        reverse = 1,

        -- Icons ONLY - no prompt column
        left = { " " },  -- Just padding, no prompt
        right = { "", wilder.popupmenu_scrollbar() },

        highlights = {
          border = "FloatBorder",
        },
      }))
    )
  end,
}
