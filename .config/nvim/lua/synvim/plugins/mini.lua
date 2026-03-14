return {
  "nvim-mini/mini.nvim",
  lazy = false,
  config = function()
    -- require('mini.cmdline').setup({
    --   autocomplete = { enabled = false },
    --   autocoorect = { enabled = true },
    --   autopeek = {
    --     enable = true,
    --     -- Number of lines to show above and below range lines
    --     n_context = 1,
    --     -- Window options
    --     window = {
    --       -- Floating window config
    --       config = {},
    --       -- Function to render statuscolumn
    --       statuscolumn = nil,
    --     },
    --   },
    -- })


    vim.api.nvim_create_autocmd("InsertEnter", {
      once = true,
      callback = function()
        require('mini.animate').setup({
          -- Cursor path animation (visualizes cursor movement with extmarks)
          cursor = {
            enable = false,
            timing = require('mini.animate').gen_timing.linear({ duration = 150, unit = 'total' }),
            path = require('mini.animate').gen_path.line({
              predicate = function(dest) return math.abs(dest[1]) > 1 end,
              max_output_steps = 800,
            }),
          },

          -- Vertical scroll (smooth scrolling via subscrolls)
          scroll = {
            enable = false,
            timing = require('mini.animate').gen_timing.linear({ duration = 200, unit = 'total' }),
            subscroll = require('mini.animate').gen_subscroll.equal({
              predicate = function(total_scroll) return total_scroll > 1 end,
              max_output_steps = 80,
            }),
          },

          -- Window resize (gradual size changes across windows)
          resize = {
            enable = true,
            timing = require('mini.animate').gen_timing.linear({ duration = 180, unit = 'total' }),
            subresize = require('mini.animate').gen_subresize.equal({
              predicate = function(sizes_from, sizes_to)
                return vim.tbl_count(sizes_from) >= 2
              end,
            }),
          },

          -- Window open (floating overlay visualization)
          open = {
            enable = true,
            timing = require('mini.animate').gen_timing.linear({ duration = 150, unit = 'total' }),
            winconfig = require('mini.animate').gen_winconfig.wipe({
              predicate = function(win_id)
                local tabpage = vim.api.nvim_win_get_tabpage(win_id)
                return #vim.api.nvim_tabpage_list_wins(tabpage) > 1
              end,
              direction = 'from_edge',
            }),
            winblend = require('mini.animate').gen_winblend.linear({ from = 100, to = 70 }),
          },

          -- Window close (reverse floating overlay)
          close = {
            enable = true,
            timing = require('mini.animate').gen_timing.linear({ duration = 150, unit = 'total' }),
            winconfig = require('mini.animate').gen_winconfig.wipe({
              predicate = function(win_id)
                local tabpage = vim.api.nvim_win_get_tabpage(win_id)
                return #vim.api.nvim_tabpage_list_wins(tabpage) > 1
              end,
              direction = 'to_edge',
            }),
            winblend = require('mini.animate').gen_winblend.linear({ from = 100, to = 70 }),
          },
        })
      end,
    })

    -- Mini.ai - Enhanced text objects
    require("mini.ai").setup({
      mappings = {
        around = "a",
        inside = "i",
        around_next = "gan",
        inside_next = "gin",
        around_last = "gal",
        inside_last = "gil",
        goto_left = "g[",
        goto_right = "g]",
      },
      n_lines = 500,
      search_method = "cover_or_next",
      custom_textobjects = nil,
    })

    -- Mini.bracketed - Bracket navigation
    require("mini.bracketed").setup({
      buffer     = { suffix = "b", options = {} },
      comment    = { suffix = "c", options = {} },
      conflict   = { suffix = "x", options = {} },
      diagnostic = { suffix = "d", options = {} },
      file       = { suffix = "f", options = {} },
      indent     = { suffix = "i", options = {} },
      jump       = { suffix = "j", options = {} },
      location   = { suffix = "l", options = {} },
      oldfile    = { suffix = "o", options = {} },
      quickfix   = { suffix = "q", options = {} },
      treesitter = { suffix = "t", options = {} },
      undo       = { suffix = "u", options = {} },
      window     = { suffix = "w", options = {} },
      yank       = { suffix = "y", options = {} },
    })

    -- Mini.pairs - Replaces autopairs
    require("mini.pairs").setup({
      modes = { insert = true, command = true, terminal = false },
      mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
        ["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\]." },
        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
        [">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\]." },
        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
      },
    })

    -- Mini.comment - Replaces comments
    require("mini.comment").setup({
      options = {
        custom_commentstring = nil,
        ignore_blank_line = false,
        start_of_line = false,
        pad_comment_parts = true,
      },
      mappings = {
        comment = "gc",
        comment_line = "gcc",
        comment_visual = "gc",
        textobject = "gc",
      },
    })

    -- Mini.surround - Replaces surround
    require("mini.surround").setup({
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    })
  end,
}
