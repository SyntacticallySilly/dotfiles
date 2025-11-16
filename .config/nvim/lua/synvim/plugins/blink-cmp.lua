-- SynVim Blink.cmp Plugin
-- Performant completion with Enter key and lspkind icons

return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = {
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
  },
  version = "v0.*",

  opts = {
    keymap = {
      preset = "enter",

      ["<CR>"] = { "accept", "fallback" },
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
        border = "none",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        scrollbar = true,

        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
          },
        },
      },

      documentation = {
        auto_show = false,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winblend = 0,
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
      },

      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
    },

    signature = {
      enabled = true,
      window = {
        border = "rounded",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
      },
    },
  },

  opts_extend = { "sources.default" },

  config = function(_, opts)
    -- Setup blink.cmp
    require("blink.cmp").setup(opts)

    -- Integrate lspkind formatting
    local lspkind_ok, lspkind = pcall(require, "lspkind")
    if lspkind_ok then
      -- lspkind is already initialized in its own plugin file
      -- blink.cmp will use the kind_icon_provider if needed
    end
  end,
}
