-- SynVim Grug Far Plugin
-- Beautiful search and replace in floating window

return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sar",
      function()
        require("grug-far").open({
          prefills = {
            search = vim.fn.expand("<cword>"),
          },
        })
      end,
      desc = "Search and Replace",
    },
    {
      "<leader>saR",
      function()
        require("grug-far").open({
          prefills = {
            search = vim.fn.expand("<cword>"),
            paths = vim.fn.expand("%"),
          },
        })
      end,
      desc = "Search and Replace (current file)",
    },
    {
      "<leader>sar",
      function()
        require("grug-far").with_visual_selection({
          prefills = {
            paths = vim.fn.expand("%"),
          },
        })
      end,
      mode = "v",
      desc = "Search and Replace (visual selection)",
    },
  },

  config = function()
    require("grug-far").setup({
      -- FLOATING WINDOW instead of tab
      windowCreationCommand = "split",
      startInInsertMode = true,

      -- Window appearance
      wrap = false,
      transient = false,

      -- Engines
      engines = {
        ripgrep = {
          path = "rg",
          extraArgs = "",
          showReplaceDiff = true,
        },
      },

      -- Keybindings (no mouse needed!)
      keymaps = {
        replace = { n = "<localleader>r" },
        qflist = { n = "<localleader>q" },
        syncLocations = { n = "<localleader>s" },
        syncLine = { n = "<localleader>l" },
        close = { n = "q" },  -- Just press 'q' to close
        historyOpen = { n = "<localleader>h" },
        historyAdd = { n = "<localleader>a" },
        refresh = { n = "<localleader>f" },
        openLocation = { n = "<localleader>o" },
        gotoLocation = { n = "<CR>" },  -- Enter to jump
        pickHistoryEntry = { n = "<CR>" },
        abort = { n = "<localleader>x" },
        help = { n = "g?" },
        toggleShowCommand = { n = "<localleader>p" },
      },

      -- UI
      maxSearchCharsInTitles = 50,
      folding = {
        enabled = true,
        foldcolumn = "1",
        foldlevelstart = 0,
      },

      -- Performance
      debounceMs = 300,
      maxWorkers = 4,

      -- History
      history = {
        maxHistoryEntries = 50,
        historyDir = vim.fn.stdpath("data") .. "/grug-far",
        autoSave = {
          enabled = true,
        },
      },

      normalModeSearch = true,

      -- Icons
      icons = {
        enabled = true,
      },

      resultLocation = {
        showNumberLabel = true,
      },

      prefills = {
        search = "",
        replacement = "",
        filesFilter = "",
        flags = "",
        paths = "",
      },
    })

    -- Better floating window setup
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "grug-far",
      callback = function()
        -- Make it a nice floating window
        vim.cmd([[
          resize 20
          wincmd L
        ]])
      end,
    })
  end,
}