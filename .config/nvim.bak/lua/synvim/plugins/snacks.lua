-- lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- ╭─────────────────────────────────────────────────────────╮
    -- │                      ENABLED MODULES                    │
    -- ╰─────────────────────────────────────────────────────────╯

    -- Fast file loading on startup
    quickfile = { enabled = true },

    -- Beautiful input UI replacement
    input = {
      enabled = true,
      icon = " ",
      icon_hl = "SnacksInputIcon",
      icon_pos = "left",
      prompt_pos = "title",
      win = {
        style = "input",
        relative = "cursor",
        row = -3,
        col = 0,
        width = 40,
        keys = {
          i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i", expr = true },
          i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = "i", expr = true },
          i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
          q = "cancel",
        },
      },
    },

    -- Notification system
    notifier = {
      enabled = true,
      timeout = 3000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,
      sort = { "level", "added" },
      level = vim.log.levels.TRACE,
      icons = {
        error = " ",
        warn = " ",
        info = " ",
        debug = " ",
        trace = "Y",
      },
      style = "compact",
      top_down = true,
      date_format = "%R",
      more_format = " ↓ %d lines ",
      refresh = 50,
    },

    -- vim.notify replacement
    notify = { enabled = true },

    -- LSP rename with preview
    rename = {
      enabled = true,
    },

    -- ╭─────────────────────────────────────────────────────────╮
    -- │                    DISABLED MODULES                     │
    -- ╰─────────────────────────────────────────────────────────╯
    animate = { enabled = false },
    bigfile = { enabled = false },
    bufdelete = { enabled = false },
    dashboard = { enabled = false },
    debug = { enabled = false },
    dim = { enabled = false },
    explorer = { enabled = false },
    git = { enabled = false },
    gitbrowse = { enabled = false },
    image = { enabled = false },
    indent = { enabled = false },
    layout = { enabled = false },
    lazygit = { enabled = false },
    picker = { enabled = false },
    profiler = { enabled = false },
    scope = { enabled = false },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = false },
    util = { enabled = false },
    win = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },

    -- ╭─────────────────────────────────────────────────────────╮
    -- │                    GLOBAL STYLES                        │
    -- ╰─────────────────────────────────────────────────────────╯
    styles = {
      input = {
        backdrop = false,
        position = "float",
        border = "rounded",
        title_pos = "center",
        height = 1,
        width = 40,
        relative = "cursor",
        noautocmd = true,
        row = 2,
        wo = {
          winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
          cursorline = false,
        },
        bo = {
          filetype = "snacks_input",
          buftype = "prompt",
        },
        keys = {
          n_esc = { "<esc>", "cancel", mode = { "n", "i" } },
          i_esc = { "<c-c>", "cancel", mode = "i" },
          i_cr = { "<cr>", "confirm", mode = { "i", "n" } },
        },
      },
      notification = {
        border = "rounded",
        zindex = 100,
        ft = "markdown",
        wo = {
          winblend = 5,
          wrap = false,
          conceallevel = 2,
          colorcolumn = "",
        },
        bo = { filetype = "snacks_notif" },
      },
    },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │                      KEYMAPS                            │
  -- ╰─────────────────────────────────────────────────────────╯
  keys = {
    -- Rename (LSP)
    {
      "<leader>cr",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },

    -- Notification History
    {
      "<leader>nh",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },

    -- Dismiss All Notifications
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │                   INITIALIZATION                        │
  -- ╰─────────────────────────────────────────────────────────╯
  init = function()
    -- Replace vim.notify before any other plugins load
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.notify = function(msg, level, opts)
      require("snacks").notify(msg, level, opts)
    end

    -- Setup highlights
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        -- Input highlights
        vim.api.nvim_set_hl(0, "SnacksInputNormal", { link = "NormalFloat" })
        vim.api.nvim_set_hl(0, "SnacksInputBorder", { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "SnacksInputTitle", { link = "FloatTitle" })
        vim.api.nvim_set_hl(0, "SnacksInputIcon", { link = "DiagnosticInfo" })
      end,
    })

    -- Trigger ColorScheme autocmd
    vim.api.nvim_exec_autocmds("ColorScheme", {})
  end,
}
