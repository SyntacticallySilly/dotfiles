-- SynVim Neo-tree Plugin
-- Beautiful file explorer with git integration

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    -- {
    --   "<leader>e",
    --   function()
    --     require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
    --   end,
    --   desc = "Explorer (Neo-tree)",
    -- },
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.fn.expand("%:p:h") })
      end,
      desc = "Explorer (Current File Dir)",
    },
    {
      "<leader>ge",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true })
      end,
      desc = "Git Explorer",
    },
    {
      "<leader>be",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true })
      end,
      desc = "Buffer Explorer",
    },
  },

  deactivate = function()
    vim.cmd([[Neotree close]])
  end,

  init = function()
    -- Performance: only load on file/folder operations
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,

  opts = {
    -- Close neo-tree if it's the last window
    close_if_last_window = true,

    -- Popup on vim startup
    popup_border_style = "rounded",

    -- Enable modified markers on files
    enable_git_status = true,
    enable_diagnostics = true,
    enable_modified_markers = true,
    enable_opened_markers = true,
    enable_refresh_on_write = true,

    -- Git status refresh settings (performance)
    git_status_async = true,

    -- Log settings
    log_level = "info",
    log_to_file = false,

    -- Default component configs
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },

      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        with_expanders = nil,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },

      icon = {
        -- folder_closed = "",
        -- folder_open = "",
        -- folder_empty = " ",
        -- folder_empty_open = "",
        -- default = "",
        highlight = "NeoTreeFileIcon",
      },

      modified = {
        symbol = "●",
        highlight = "NeoTreeModified",
      },

      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },

      git_status = {
        symbols = {
          -- Change type
          added     = "✚",
          deleted   = "✖",
          modified  = "",
          renamed   = "󰁕",
          -- Status type
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        },
      },

      file_size = {
        enabled = true,
        required_width = 64,
      },

      type = {
        enabled = true,
        required_width = 122,
      },

      last_modified = {
        enabled = true,
        required_width = 88,
      },

      created = {
        enabled = true,
        required_width = 110,
      },

      symlink_target = {
        enabled = false,
      },
    },

    -- Commands for custom actions
    commands = {},

    -- Window settings
    window = {
      position = "left",
      width = 35,
      mapping_options = {
        noremap = true,
        nowait = true,
      },

      mappings = {
        ["<space>"] = {
          "toggle_node",
          nowait = false,
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "cancel",
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        ["l"] = "focus_preview",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["w"] = "open_with_window_picker",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        ["Z"] = "expand_all_nodes",
        ["a"] = {
          "add",
          config = {
            show_path = "none",
          },
        },
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["m"] = "move",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["i"] = "show_file_details",
      },
    },

    nesting_rules = {},

    -- Filesystem settings
    filesystem = {
      -- Performance optimizations
      async_directory_scan = "always",
      scan_mode = "shallow",

      -- Follow current file
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },

      -- Group empty dirs
      group_empty_dirs = false,

      -- Hijack netrw
      hijack_netrw_behavior = "open_default",

      -- Use libuv watcher (best performance)
      use_libuv_file_watcher = true,

      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["#"] = "fuzzy_sorter",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["og"] = { "order_by_git_status", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },

        fuzzy_finder_mappings = {
          ["<down>"] = "move_cursor_down",
          ["<C-n>"] = "move_cursor_down",
          ["<up>"] = "move_cursor_up",
          ["<C-p>"] = "move_cursor_up",
        },
      },

      -- Filters (performance)
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = true,
        hide_by_name = {
          "node_modules",
          ".git",
          ".cache",
          "__pycache__",
          ".pytest_cache",
          ".mypy_cache",
          ".ruff_cache",
          "target",
          "build",
          "dist",
          ".next",
          ".turbo",
        },
        hide_by_pattern = {
          "*.meta",
          "*.tmp",
        },
        always_show = {
          ".gitignore",
          ".env",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
        never_show_by_pattern = {
          ".null-ls_*",
        },
      },
    },

    -- Buffers settings
    buffers = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = true,
      show_unloaded = true,
      window = {
        position = "left",
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
      },
    },

    -- Git status settings
    git_status = {
      window = {
        position = "left",
        mappings = {
          ["A"]  = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
          ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
      },
    },
  },

  config = function(_, opts)
    require("neo-tree").setup(opts)

    -- -- Custom highlights (theme adaptive)
    -- local function setup_highlights()
    --   vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#89b4fa" })
    --   vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#89b4fa" })
    --   vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#cdd6f4" })
    --   vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#cdd6f4" })
    --   vim.api.nvim_set_hl(0, "NeoTreeFileNameOpened", { fg = "#a6e3a1" })
    --   vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#45475a" })
    --   vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#6c7086" })
    --   vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#181825" })
    --   vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#181825" })
    --   vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#313244" })
    --
    --   -- Git status colors
    --   vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#a6e3a1" })
    --   vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#f38ba8" })
    --   vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#f9e2af" })
    --   vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = "#fab387" })
    --   vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#89dceb" })
    --   vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = "#6c7086" })
    --   vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { fg = "#cba6f7" })
    --
    --   vim.api.nvim_set_hl(0, "NeoTreeModified", { fg = "#f9e2af" })
    --   vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#f5c2e7", bold = true })
    --   vim.api.nvim_set_hl(0, "NeoTreeSymbolicLinkTarget", { fg = "#94e2d5" })
    --   vim.api.nvim_set_hl(0, "NeoTreeWindowsHidden", { fg = "#6c7086" })
    -- end
    --
    -- setup_highlights()

    -- Re-apply on colorscheme change
    -- vim.api.nvim_create_autocmd("ColorScheme", {
    --   callback = setup_highlights,
    -- })

    -- Breadcrumb integration with winbar
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "neo-tree",
      callback = function()
        vim.opt_local.statuscolumn = ""
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false

        -- Set breadcrumb in window title bar
        local state = require("neo-tree.sources.manager").get_state("filesystem")
        if state and state.path then
          local path = state.path:gsub(vim.fn.expand("~"), "~")
          vim.wo.winbar = "%#Normal#  " .. path .. " %*"
        end
      end,
    })

    -- Update breadcrumb on directory change
    vim.api.nvim_create_autocmd("User", {
      pattern = "NeoTreeDirChanged",
      callback = function(args)
        local path = args.data and args.data.path or vim.loop.cwd()
        path = path:gsub(vim.fn.expand("~"), "~")

        -- Find neo-tree window and update winbar
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "neo-tree" then
            vim.wo[win].winbar = "%#Normal# 📁 " .. path .. " %*"
          end
        end
      end,
    })

    -- Performance: Clear cache periodically
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        pcall(function()
          require("neo-tree.events").clear_all_events()
          require("neo-tree.sources.manager")._clear_state()
        end)
      end,
    })

    -- Auto-close if last window
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("NeoTreeClose", { clear = true }),
      pattern = "*",
      callback = function()
        local layout = vim.fn.winlayout()
        if layout[1] == "leaf" and vim.bo[vim.fn.winbufnr(layout[2])].filetype == "neo-tree" and layout[3] == nil then
          vim.cmd("quit")
        end
      end,
    })
  end,
}
