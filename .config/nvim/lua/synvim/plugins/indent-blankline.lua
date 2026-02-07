-- SynVim Indent Blankline Plugin
-- Beautiful indentation guides with scope highlighting

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<leader>ui", "<cmd>IBLToggle<cr>", desc = "Toggle Indent Lines" },
  },

  opts = {
    -- Indentation guide characters
    indent = {
      char = "┊", -- Options: "│", "▏", "┊", "┆", "¦", "╎", "┆"
      tab_char = "┊",
      smart_indent_cap = true,
      priority = 1,
    },

    -- Whitespace display
    whitespace = {
      remove_blankline_trail = true,
    },

    -- Scope highlighting (current code block)
    scope = {
      enabled = true,
      char = "╎", -- Thicker line for scope
      show_start = true, -- Underline at scope start
      show_end = true, -- Underline at scope end
      show_exact_scope = false,
      injected_languages = true,
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
      priority = 1024,
      include = {
        node_type = {
          -- Lua
          ["*"] = { "*" },
          lua = {
            "chunk",
            "do_statement",
            "while_statement",
            "repeat_statement",
            "if_statement",
            "for_statement",
            "function_declaration",
            "function_definition",
            "table_constructor",
          },
        },
      },
    },

    -- Exclude certain filetypes
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        "lspinfo",
        "packer",
        "checkhealth",
        "TelescopePrompt",
        "TelescopeResults",
        "lsp-installer",
        "markdown",
        "",
      },
      buftypes = {
        "terminal",
        "nofile",
        "quickfix",
        "prompt",
      },
    },
  },

  config = function(_, opts)
    local hooks = require("ibl.hooks")

    -- Setup indent-blankline
    require("ibl").setup(opts)

    -- Register rainbow delimiter integration (if available)
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

    -- Set custom highlight colors that adapt to theme
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- Get theme colors dynamically
      local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
      local comment_fg = vim.api.nvim_get_hl(0, { name = "Comment" }).fg

      -- Subtle indent guides (barely visible)
      vim.api.nvim_set_hl(0, "IblIndent", {
        fg = comment_fg and string.format("#%06x", comment_fg) or "#3b4261",
        nocombine = true
      })

      -- Whitespace character
      vim.api.nvim_set_hl(0, "IblWhitespace", {
        fg = comment_fg and string.format("#%06x", comment_fg) or "#3b4261",
        nocombine = true
      })

      -- Rainbow colors for scope (adapts to theme)
      local colors = {
        "#E06C75", -- Red
        "#E5C07B", -- Yellow
        "#61AFEF", -- Blue
        "#D19A66", -- Orange
        "#98C379", -- Green
        "#C678DD", -- Violet
        "#56B6C2", -- Cyan
      }

      for i, color in ipairs(colors) do
        local hl_name = "RainbowDelimiter" .. ({"Red", "Yellow", "Blue", "Orange", "Green", "Violet", "Cyan"})[i]
        vim.api.nvim_set_hl(0, hl_name, { fg = color })
      end
    end)

    -- Auto-toggle based on file size (performance optimization)
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local line_count = vim.api.nvim_buf_line_count(buf)

        -- Disable for large files (>5000 lines)
        if line_count > 5000 then
          require("ibl").setup_buffer(buf, { enabled = false })
          vim.notify("Indent guides disabled for large file", vim.log.levels.INFO)
        end
      end,
    })
  end,
}
