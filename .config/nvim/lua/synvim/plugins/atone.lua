-- SynVim Atone Plugin
-- Modern, beautiful undo tree visualizer

return {
  "XXiaoA/atone.nvim",
  cmd = "Atone",
  keys = {
    {
      "<leader>m",
      "<cmd>Atone toggle<cr>",
      desc = "Toggle Undo Tree",
    },
  },

  opts = {
    -- Layout configuration
    layout = {
      -- Position: "left" or "right"
      direction = "left",

      -- Width options:
      -- "adaptive" - exact width of tree graph (recommended)
      -- number < 1 - percentage of vim.o.columns (e.g., 0.25 = 25%)
      -- number >= 1 - fixed column width
      width = "adaptive",
    },

    -- Diff window for the node under cursor
    diff_cur_node = {
      enabled = true,

      -- Height as percentage of tree window
      split_percent = 0.35,
    },

    -- Auto-attach to buffers
    auto_attach = {
      enabled = true,

      -- Exclude specific filetypes
      excluded_ft = {
        "neo-tree",
        "aerial",
        "toggleterm",
        "FTerm",
        "lazy",
        "mason",
        "dashboard",
        "alpha",
        "help",
        "qf",
        "oil",
        "Trouble",
        "TelescopePrompt",
      },
    },

    -- Keymaps in tree window
    keymaps = {
      tree = {
        quit = { "<C-c>", "q", "<Esc>" },
        next_node = "j", -- Supports v:count (e.g., 5j)
        pre_node = "k", -- Supports v:count (e.g., 3k)
        jump_to_G = "G",
        jump_to_gg = "gg",
        undo_to = "<CR>", -- Apply undo state
        help = { "?", "g?" },
      },

      -- Keymaps in diff window
      auto_diff = {
        quit = { "<C-c>", "q", "<Esc>" },
      },

      -- Keymaps in help window
      help = {
        quit_help = { "<C-c>", "q", "<Esc>" },
      },
    },
    ui = {
      border = 'rounded',
      compact = false,
    }
  },

  config = function(_, opts)
    require("atone").setup(opts)

    -- Enable persistent undo (required for undo history to persist across sessions)
    vim.opt.undofile = true
    vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
    vim.opt.undolevels = 10000
    vim.opt.undoreload = 10000

    -- Create undo directory if it doesn't exist
    local undo_dir = vim.fn.stdpath("cache") .. "/undo"
    if vim.fn.isdirectory(undo_dir) == 0 then
      vim.fn.mkdir(undo_dir, "p")
    end
    -- Auto-close atone when it's the last window
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("AtoneClose", { clear = true }),
      callback = function()
        if vim.bo.filetype == "atone" then
          local wins = vim.api.nvim_list_wins()
          local non_atone_wins = vim.tbl_filter(function(win)
            local buf = vim.api.nvim_win_get_buf(win)
            return vim.bo[buf].filetype ~= "atone"
          end, wins)

          if #non_atone_wins == 0 then
            vim.cmd("quit")
          end
        end
      end,
    })

    -- Window-specific settings for atone
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "atone",
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.statuscolumn = ""
        vim.opt_local.foldcolumn = "0"
        vim.opt_local.cursorline = true
        vim.opt_local.wrap = false
      end,
    })
    -- Performance: Clear old undo files periodically (prevents cache bloat)
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        -- This runs on exit - you can add cleanup logic here if needed
        -- For example, delete undo files older than 30 days
        local undo_dir = vim.fn.stdpath("cache") .. "/undo"
        if vim.fn.isdirectory(undo_dir) == 1 then
          -- Optional: Add cleanup logic for old files
          -- os.execute("find " .. undo_dir .. " -type f -mtime +30 -delete")
        end
      end,
    })
  end,
}
