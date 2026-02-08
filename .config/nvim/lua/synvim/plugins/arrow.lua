-- SynVim Arrow Plugin
-- Beautiful file bookmarking with per-project persistence

return {
  "otavioschwanck/arrow.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  keys = {
    { "&", desc = "Arrow Menu" }, -- Single key binding for everything
  },

  opts = {
    -- Show icons in menu
    show_icons = true,

    -- Leader key (recommended to be single key)
    leader_key = "&", -- Press ; to open arrow menu

    -- Buffer leader key (for per-buffer marks)
    -- buffer_leader_key = "m", -- Press m to open buffer-local arrow

    -- Separate items per buffer (like buffer-local marks)
    separate_by_branch = false, -- Set to true for git-branch-specific bookmarks

    -- Hide handbook (help text)
    hide_handbook = false,

    -- Save arrow state (persist between sessions)
    save_path = function()
      return vim.fn.stdpath("cache") .. "/arrow"
    end,

    -- Save only when Neovim closes (performance optimization)
    save_on_change = false,

    -- Number of bookmarks to show per project
    show_max_files = 10,

    -- Index keys (for quick navigation)
    index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP", -- Keys to select items

    -- Full path display (show full path instead of just filename)
    full_path_list = { "update_stuff" }, -- Files to always show full path

    -- Always show path for these patterns
    always_show_path = false,

    -- Separate save per branch
    separate_save_and_remove = true,

    -- Mappings inside arrow window
    mappings = {
      edit = "e",       -- Edit file
      delete_mode = "d", -- Delete mode
      clear_all_items = "C", -- Clear all bookmarks
      toggle = "s",      -- Toggle bookmark
      open_vertical = "v", -- Open in vertical split
      open_horizontal = "-", -- Open in horizontal split
      quit = "q",        -- Close window
      remove = "x",      -- Remove current item
      next_item = "]",   -- Next item
      prev_item = "[",   -- Previous item
    },

    -- Window settings
    window = {
      width = "auto",   -- "auto" or number
      height = "auto",  -- "auto" or number
      row = "auto",     -- "auto" or number
      col = "auto",     -- "auto" or number
      border = "rounded", -- Border style
    },

    -- Per buffer configuration
    per_buffer_config = {
      lines = 4, -- Number of lines to cache for preview
      sort_automatically = true,
      zindex = 10, -- Window z-index
      treesitter_context =nil, -- Use treesitter context
    },

    -- Custom actions
    custom_actions = {
      open = function(target_file_name, current_file_name) end,
      split_vertical = function(target_file_name, current_file_name) end,
      split_horizontal = function(target_file_name, current_file_name) end,
    },

    -- Global bookmarks (always available)
    global_bookmarks = false,

    -- Status line configuration
    statusline = {
      enabled = true,
      separator = " | ",
      -- Only show current file's index in statusline
      colored = true,
    },
  },

  config = function(_, opts)
    require("arrow").setup(opts)

    -- Keymaps for quick navigation (numbered bookmarks)
    vim.keymap.set("n", "H", require("arrow.persist").previous, { desc = "Arrow Previous" })
    vim.keymap.set("n", "L", require("arrow.persist").next, { desc = "Arrow Next" })

    -- Toggle current file bookmark
    vim.keymap.set("n", "<leader>bb", require("arrow.persist").toggle, { desc = "Toggle Bookmark" })

    -- Clear all bookmarks
    vim.keymap.set("n", "<leader>bx", function()
      require("arrow.persist").clear_all()
      vim.notify("All bookmarks cleared", vim.log.levels.INFO)
    end, { desc = "Clear All Bookmarks" })

    -- Quick jump to bookmark by index (1-9)
    for i = 1, 9 do
      vim.keymap.set("n", string.format("<leader>%d", i), function()
        require("arrow.persist").go_to(i)
      end, { desc = string.format("Bookmark %d", i) })
    end


    -- Notification on bookmark toggle
    local arrow_persist = require("arrow.persist")
    local original_toggle = arrow_persist.toggle

    arrow_persist.toggle = function()
      original_toggle()
      local is_bookmarked = require("arrow.statusline").is_on_arrow_file()
      if is_bookmarked then
        vim.notify(" Bookmark added", vim.log.levels.INFO, { timeout = 1000 })
      else
        vim.notify(" Bookmark removed", vim.log.levels.INFO, { timeout = 1000 })
      end
    end
  end,
}
