-- SynVim Blink.cmp Plugin
-- Performant completion with cmdline popup menu & color highlighting

return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = {
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    -- "mikavilpas/blink-ripgrep.nvim",
  },
  version = "v0.*",

  opts = {
    keymap = {
      preset = "enter",
      ["/"] = { "accept", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<C-g>"] = {
        function()
          require("blink.cmp").show({ providers = { "ripgrep" } })
        end,
      },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },

      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          fallbacks = { "buffer" },
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 3,
          opts = {
            trailing_slash = true,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
        },
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
        },
        cmdline = {
          name = "Cmdline",
          module = "blink.cmp.sources.cmdline",
        },
        -- ripgrep = {
        --   module = "blink-ripgrep",
        --   name = "Ripgrep",
        --   opts = {
        --     prefix_min_len = 3,
        --     context_size = 5,
        --     max_filesize = "1M",
        --     project_root_marker = ".git",
        --     search_casing = "--ignore-case",
        --   },
        --   transform_items = function(_, items)
        --     for _, item in ipairs(items) do
        --       item.labelDetails = {
        --         description = "(rg)",
        --       }
        --     end
        --     return items
        --   end,
        -- },
      },
    },

    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },

      menu = {
        enabled = true,
        min_width = 15,
        max_height = 10,
        border = "shadow",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,Search:None",
        scrollbar = true,
        auto_show = true,

        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                -- Check if nvim-highlight-colors is available
                local has_hl, hl_colors = pcall(require, "nvim-highlight-colors")
                if has_hl and ctx.item.documentation then
                  -- Try to extract color from documentation
                  local color_item = hl_colors.format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr and color_item.abbr ~= "" then
                    return color_item.abbr .. ctx.icon_gap
                  end
                end
                return ctx.kind_icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                -- Check if nvim-highlight-colors is available
                local has_hl, hl_colors = pcall(require, "nvim-highlight-colors")
                if has_hl and ctx.item.documentation then
                  -- Try to extract color from documentation
                  local color_item = hl_colors.format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr_hl_group then
                    return color_item.abbr_hl_group
                  end
                end
                return "BlinkCmpKind" .. ctx.kind
              end,
            },
          },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
        window = {
          border = "shadow",
          winblend = 0,
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
      },

      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },

      ghost_text = {
        enabled = false,
      },
    },

    signature = {
      enabled = true,
      window = {
        border = "shadow",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
      },
    },

    cmdline = {
      enabled = true,
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        if type == ":" then
          return { "cmdline", "path" }
        end
        return {}
      end,
      -- Added cmdline-specific completion settings
      completion = {
        list = {
          selection = { preselect = false }  -- Prevents :w from auto-selecting :wall
        },
        menu = {
          auto_show = function(ctx)
            return vim.fn.getcmdtype() == ":"  -- Auto-show only for : commands
          end,
        },
      },
      -- Optional: cmdline-specific keymap preset
      keymap = {
        preset = "cmdline",
      },
    },
  },

  opts_extend = { "sources.default" },

  config = function(_, opts)
    require("blink.cmp").setup(opts)
  end,
}
