-- SynVim Completion Plugin (nvim-cmp)
-- Autocompletion engine with snippet support

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",  -- Load when entering insert mode
  
  dependencies = {
    -- Snippet engine
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",  -- Optional: better regex support
      dependencies = { "rafamadriz/friendly-snippets" },
    },
    
    -- Completion sources
    "hrsh7th/cmp-nvim-lsp",     -- LSP completion
    "hrsh7th/cmp-buffer",       -- Buffer content completion
    "hrsh7th/cmp-path",         -- File path completion
    "hrsh7th/cmp-cmdline",      -- Command line completion
    "saadparwaiz1/cmp_luasnip", -- Snippet completion
  },
  
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    
    -- Load friendly snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    
    cmp.setup({
      -- Snippet engine configuration
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      
      -- Completion menu appearance
      formatting = {
        format = function(entry, vim_item)
          -- Add source name to completion menu
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
            cmdline = "[Cmd]",
          })[entry.source.name]
          return vim_item
        end,
      },
      
      -- Keybindings in completion menu
      mapping = cmp.mapping.preset.insert({
        -- Navigate menu with Ctrl-j/k (same as Telescope)
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        
        -- Scroll documentation preview
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        
        -- Complete with Ctrl-Space
        ["<C-Space>"] = cmp.mapping.complete(),
        
        -- Abort completion
        ["<C-c>"] = cmp.mapping.abort(),
        
        -- Accept completion with Enter or Tab
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        
        -- Tab to expand snippet or next placeholder
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        
        -- Shift-Tab to jump to previous snippet placeholder
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      
      -- Completion sources (order matters - checked in this order)
      sources = {
        { name = "nvim_lsp" },      -- LSP suggestions (when LSP is active)
        { name = "luasnip" },       -- Available snippets
        { name = "buffer" },        -- Current buffer words
        { name = "path" },          -- File paths
      },
      
      -- Performance settings
      performance = {
        max_view_entries = 20,      -- Limit menu height (Termux)
        debounce = 100,             -- Wait 100ms before showing completions
      },
      
      -- Don't auto-complete in certain filetypes
      enabled = function()
        -- Disable in comments
        if vim.api.nvim_get_option_value("buftype", {}) == "prompt" then
          return false
        end
        return true
      end,
    })
    
    -- Setup completion for cmdline (`:` commands)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "cmdline" },
        { name = "path" },
      },
    })
    
    -- Setup completion for search (/ and ?)
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
  end,
}
