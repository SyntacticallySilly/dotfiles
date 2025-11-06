-- ~/.config/nvim/lua/plugins/cmp.lua
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",        -- Buffer words completion
    "hrsh7th/cmp-path",          -- File path completion
    "hrsh7th/cmp-nvim-lsp",      -- LSP completion
    "hrsh7th/cmp-cmdline",       -- Command-line completion
    {
      "L3MON4D3/LuaSnip",        -- Snippet engine
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",  -- LuaSnip completion source
    "rafamadriz/friendly-snippets", -- Pre-made snippets collection
    "onsails/lspkind.nvim",      -- VSCode-like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load VSCode-style snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),  -- Previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(),  -- Next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),  -- Show completion menu
        ["<C-e>"] = cmp.mapping.abort(),  -- Close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),  -- Confirm selection
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },  -- LSP completions
        { name = "luasnip" },   -- Snippet completions
        { name = "buffer" },    -- Text in current buffer
        { name = "path" },      -- File paths
      }),
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })

    -- `/` cmdline setup for search
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `?` cmdline setup for backward search
    cmp.setup.cmdline("?", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` cmdline setup for commands
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
  end,
}

