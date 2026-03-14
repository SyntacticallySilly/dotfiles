local rainbow_hls = {
  "RainbowDelimiterRed",
  "RainbowDelimiterYellow",
  "RainbowDelimiterBlue",
  "RainbowDelimiterOrange",
  "RainbowDelimiterGreen",
  "RainbowDelimiterViolet",
  "RainbowDelimiterCyan",
}

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    ---@diagnostic disable : undefined-global
    { "<leader>sf", function() Snacks.picker.files() end,                desc = "Search files" },
    { "<leader>sv", function() Snacks.picker.git_files() end,            desc = "Search git files" },
    { "<leader>sg", function() Snacks.picker.grep() end,                 desc = "Search text" },
    { "<leader>sb", function() Snacks.picker.buffers() end,              desc = "Search buffers" },
    { "<leader>sh", function() Snacks.picker.help() end,                 desc = "Search help" },
    { "<leader>sr", function() Snacks.picker.recent() end,               desc = "Search recent files" },
    { "<leader>sc", function() Snacks.picker.commands() end,             desc = "Search commands" },
    { "<leader>sk", function() Snacks.picker.keymaps() end,              desc = "Search keymaps" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end,          desc = "Search diagnostics" },
    { "<leader>st", function() Snacks.picker.colorschemes() end,         desc = "Search colorschemes" },
    { "<leader>sn", function() Snacks.picker.notifications() end,        desc = "Search notifications" },
    { "<leader>sm", function() Snacks.picker.resume() end,               desc = "Resume last search" },
    { "<leader>s%", function() Snacks.picker.lines() end,                desc = "Search current buffer" },
    { "<leader>sa", function() Snacks.picker.lsp_symbols() end,          desc = "Search symbols" },
    { '<leader>s"', function() Snacks.picker.registers() end,            desc = "Search registers" },
    { "<leader>si", function() Snacks.picker.icons() end,                desc = "Search icons" },
    { "<leader>s:", function() Snacks.picker.command_history() end,      desc = "Search command history" },
    { "<leader>s/", function() Snacks.picker.search_history() end,       desc = "Search find history" },
    { "<leader>sw", function() Snacks.picker.grep_word() end,            desc = "Search word under cursor", mode = { "n", "x" }, },
    { "<leader>su", function() Snacks.picker.undo() end,                 desc = "Search undo history" },
    { "gd",         function() Snacks.picker.lsp_definitions() end,      desc = "Goto definition" },
    { "gD",         function() Snacks.picker.lsp_declarations() end,     desc = "Goto declaration" },
    { "gr",         function() Snacks.picker.lsp_references() end,       nowait = true,                     desc = "Search references" },
    { "gI",         function() Snacks.picker.lsp_implementations() end,  desc = "Goto implementation" },
    { "gy",         function() Snacks.picker.lsp_type_definitions() end, desc = "Goto type definition" },
    { "gai",        function() Snacks.picker.lsp_incoming_calls() end,   desc = "Calls incoming" },
    { "gao",        function() Snacks.picker.lsp_outgoing_calls() end,   desc = "Calls outgoing" },

    ---@diagnostic enable : undefined-global
  },
  opts = {
    -- bigfile = { enabled = true },
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "e", desc = "Explore", action = function() require('oil').toggle_float('.', { preview = {} }) end },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
        █████████                        █████   █████  ███                 
             ███░░░░░███                      ░░███   ░░███  ░░░                          
      ░███    ░░░  █████ ████ ████████   ░███    ░███  ████  █████████████  
      ░░█████████ ░░███ ░███ ░░███░░███  ░███    ░███ ░░███ ░░███░░███░░███ 
       ░░░░░░░░███ ░███ ░███  ░███ ░███  ░░███   ███   ░███  ░███ ░███ ░███ 
       ███    ░███ ░███ ░███  ░███ ░███   ░░░█████░    ░███  ░███ ░███ ░███ 
      ░░█████████  ░░███████  ████ █████    ░░███      █████ █████░███ █████
       ░░░░░░░░░    ░░░░░███ ░░░░ ░░░░░      ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ 
                    ███ ░███                                                
                   ░░██████                                                 
                    ░░░░░░                                                  
              ]]
      }
    },
    -- explorer = { enabled = true },
    indent = {
      enabled = true,
      hl = rainbow_hls,
      scope = {
        hl = rainbow_hls,
      },
    },
    input = { enabled = true },
    picker = {
      enabled = true,
      prompt = ">=",
      layout = {
        preset = "fallacy",
        reverse = true,
      },
      layouts = {
        fallacy = {
          preset = "fallacy",
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 0,
            border = "none",
            title_pos = "center",
            { win = "preview", title = "{preview}", height = 9, border = "rounded" },
            { win = "list",    title = "{title}",   height = 5, border = "rounded" },
            { win = "input",   title = "{live}",    height = 1, border = "rounded" },
          },
        },
      },
      win = {
        input = {
          keys = {
            ["<C-j>"] = { "list_down", mode = { "i", "n" } },
            ["<C-k>"] = { "list_up", mode = { "i", "n" } },
            ["<C-n>"] = { "history_forward", mode = { "i", "n" } },
            ["<C-p>"] = { "history_back", mode = { "i", "n" } },
            ["<C-q>"] = { "qflist", mode = { "i", "n" } },
            ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["jk"] = { "cancel", mode = "i" },
          },
        },
      },
      matcher = {
        fuzzy = true,          -- use fuzzy matching
        smartcase = true,      -- use smartcase
        ignorecase = true,     -- use ignorecase
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        -- so this can have a performance impact for large lists and increase memory usage
        cwd_bonus = false,     -- give bonus for matching files in the cwd
        frecency = true,       -- frecency bonus
      },

      formatters = {
        file = {
          truncate = "center",
          min_width = 40,
        },
      },
      sources = {
        files = {
          hidden = true,
          ignored = false,
          exclude = {
            ".git/*",
            "node_modules",
            "*.jpg",
            "*.jpeg",
            "*.png",
            "*.svg",
            "*.otf",
            "*.ttf",
          },
        },
        git_files = {
          untracked = true,
        },
        grep = {
          hidden = true,
          ignored = false,
          exclude = {
            ".git/*",
            "node_modules",
            "*.jpg",
            "*.jpeg",
            "*.png",
            "*.svg",
            "*.otf",
            "*.ttf",
          },
        },
        recent = {
          filter = { cwd = true },
        },
        diagnostics = {
          layout = { preset = "fallacy" },
          focus = "list",
        },
        keymaps = {
          layout = { preset = "fallacy" },
        },
        buffers = {
          current = false,
          sort_lastused = true,
          layout = { hidden = { "preview" } },
          win = {
            input = {
              keys = {
                ["<C-x>"] = { "bufdelete", mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["x"] = "bufdelete",
                ["dd"] = "bufdelete",
              },
            },
          },
        },
        lines = {
          layout = { preset = "fallacy" },
        },
      },
    },
    notifier = { enabled = true },
    -- quickfile = { enabled = true },
    scope = {
      underline = true,
    },
    scroll = {
      enabled = true
    },
    statuscolumn = { enabled = true },
    styles = {
      input = {
        backdrop = 45,
      }
    }
    -- words = { enabled = true },
  },
}
