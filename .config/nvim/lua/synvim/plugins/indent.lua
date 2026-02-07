return {
  "echasnovski/mini.indentscope",
  version = false,  -- Latest development (use '*' for stable)
  enabled = false,
  event = "VeryLazy",  -- Lazy-load for perf on Termux/Neovim
  config = function()
    local indentscope = require("mini.indentscope")

    -- Rainbow highlight groups from rainbow-delimiters.nvim
    local rainbow_hlgroups = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    }

    indentscope.setup({
      -- Smooth quadratic animation (fast ~15ms/step)
      draw = {
        delay = 10,
        animation = indentscope.gen_animation.quadratic({ easing = "out", duration = 15, unit = "step" }),
        predicate = function(scope) return not scope.body.is_incomplete end,
        priority = 2,
      },
      -- Scope mappings enabled
      mappings = {
        goto_top = "[i",
        goto_bottom = "]i",
        object_scope = "ii",
        object_scope_with_border = "ai",
      },
      options = {
        border = "both",
        indent_at_cursor = true,
        n_lines = 200,
        try_as_border = true,
      },
      symbol = "│",
    })

    -- Rainbow coloring hook (per colorscheme)
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.b.MiniIndentscope_hlgroups = nil
        local shiftwidth = vim.o.shiftwidth
        indentscope.config.symbol = ("│"):rep(shiftwidth > 0 and shiftwidth or 2)
        for i, group in ipairs(rainbow_hlgroups) do
          vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol" .. i, { link = group })
        end
      end,
      group = vim.api.nvim_create_augroup("MiniIndentscopeRainbow", { clear = true }),
    })
    vim.api.nvim_exec_autocmds("ColorScheme", { pattern = "*" })
  end,
}
