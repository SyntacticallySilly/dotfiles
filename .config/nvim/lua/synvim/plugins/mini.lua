return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    -- Mini.pairs - Replaces autopairs
    require("mini.pairs").setup({
      modes = { insert = true, command = false, terminal = false },
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
        comment = "cc",
        comment_line = "ccl",
        comment_visual = "cc",
        textobject = "cc",
      },
    })

    -- Mini.surround - Replaces surround
    require("mini.surround").setup({
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
      n_lines = 20,
      search_method = "cover_or_next",
    })

    -- Mini.indentscope - Replaces indent-blankline
    -- require("mini.indentscope").setup({
    --   symbol = "│",
    --   options = { try_as_border = true },
    --   draw = {
    --     delay = 50,
    --     animation = require("mini.indentscope").gen_animation.none(),
    --   },
    --   mappings = {
    --     object_scope = "ii",
    --     object_scope_with_border = "ai",
    --     goto_top = "[i",
    --     goto_bottom = "]i",
    --   },
    -- })

    -- Mini.animate - Replaces illuminate, undo-glow, beacon.nvim
    require("mini.animate").setup({
      -- Cursor path animation (replaces beacon.nvim)
      -- cursor = {
      --   enable = true,
      --   timing = require("mini.animate").gen_timing.linear({ duration = 500, unit = "total" }),
      --   path = require("mini.animate").gen_path.line({
      --     predicate = function()
      --       return true
      --     end,
      --   }),
      -- },

      -- Scroll animation
      scroll = {
        enable = true,
        timing = require("mini.animate").gen_timing.linear({ duration = 350, unit = "total" }),
        subscroll = require("mini.animate").gen_subscroll.equal({
          predicate = function(total_scroll)
            return total_scroll > 1
          end,
        }),
      },

      -- Window resize animation (FIXED)
      resize = {
        enable = true,
        timing = require("mini.animate").gen_timing.linear({ duration = 300, unit = "total" }),
        subresize = require("mini.animate").gen_subresize.equal({ predicate = function() return true end }),
      },

      -- Window open/close animation
      open = {
        enable = true,
        timing = require("mini.animate").gen_timing.linear({ duration = 250, unit = "total" }),
        winconfig = require("mini.animate").gen_winconfig.wipe({ direction = "from_edge" }),
      },

      close = {
        enable = true,
        timing = require("mini.animate").gen_timing.linear({ duration = 350, unit = "total" }),
        winconfig = require("mini.animate").gen_winconfig.wipe({ direction = "to_edge" }),
      },
    })

    -- Mini.cursorword - Highlight word under cursor
    require("mini.cursorword").setup({
      delay = 100, -- Delay before highlighting (ms)
    })

    -- Mini.trailspace - Highlight and remove trailing whitespace
    -- require("mini.trailspace").setup({
    --   only_in_normal_buffers = true,
    -- })

    -- Mini.move - Move lines and selections with Alt+hjkl
    require("mini.move").setup({
      mappings = {
        -- Move visual selection in Visual mode
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",

        -- Move current line in Normal mode
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },

      -- Options which control moving behavior
      options = {
        reindent_linewise = true, -- Reindent when moving lines
      },
    })

    -- Disable indentscope for certain filetypes
    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = {
    --     "help",
    --     "alpha",
    --     "dashboard",
    --     "neo-tree",
    --     "Trouble",
    --     "lazy",
    --     "mason",
    --     "notify",
    --     "toggleterm",
    --     "lazyterm",
    --   },
    --   callback = function()
    --     vim.b.miniindentscope_disable = true
    --   end,
    -- })

    -- Disable cursorword for certain filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        "TelescopePrompt",
      },
      callback = function()
        vim.b.minicursorword_disable = false
      end,
    })

    -- Keymap to trim trailing whitespace
    -- vim.keymap.set("n", "<leader>cw", function()
    --   require("mini.trailspace").trim()
    --   require("mini.trailspace").trim_last_lines()
    --   vim.notify("Trailing whitespace removed", vim.log.levels.INFO)
    -- end, { desc = "Clean Whitespace" })
  end,
}
