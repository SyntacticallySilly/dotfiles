-- SynVim Blink.cmp Plugin
-- Performant completion engine with cmdline and path support

return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = "rafamadriz/friendly-snippets",
  version = "v0.*",

  opts = {
    keymap = {
      preset = "default",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<Enter>"] = { "select_and_accept" },

      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },

      providers = {
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
            show_hidden_files_by_default = false,
          },
        },
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
        border = "rounded",
        winblend = 8,
        scrollbar = false,

        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
        },
      },

      documentation = {
        auto_show = false,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
        },
      },

      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },

    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },
  },

  opts_extend = { "sources.default" },
}
