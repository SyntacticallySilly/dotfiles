-- SynVim FTerm Plugin
-- Lightweight floating terminal

return {
  "numToStr/FTerm.nvim",
  cmd = "FTerm",
  keys = {
    { "<C-\\>", desc = "Toggle Terminal" },
    { "<leader>tt", desc = "Terminal"},
    { "<leader>tg", desc = "Lazygit" },
    { "<leader>tr", desc = "Resource Monitor" },
  },

  config = function()
    local fterm = require("FTerm")

    -- Default terminal setup
    fterm.setup({
      -- Border style
      border = "rounded",

      -- Blend (transparency)
      blend = 0,

      -- Dimensions
      dimensions = {
        height = 0.8,
        width = 0.8,
      },

      -- Command to run
      cmd = vim.o.shell,

      -- Auto-close on exit
      auto_close = true,

      -- Highlight groups
      hl = "Normal",
      border_hl = "FloatBorder",
    })

    -- Toggle terminal (both normal and terminal mode)
    vim.keymap.set("n", "<C-\\>", function()
      fterm.toggle()
    end, { desc = "Toggle Terminal" })

    vim.keymap.set("t", "<C-\\>", function()
      fterm.toggle()
    end, { desc = "Toggle Terminal" })

    -- ESC to exit terminal mode to normal mode
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

    -- Lazygit integration
    local lazygit = fterm:new({
      ft = "fterm_lazygit",
      cmd = "lazygit",
      dimensions = {
        height = 0.95,
        width = 0.95,
      },
    })

    vim.keymap.set("n", "<leader>tg", function()
      lazygit:toggle()
    end, { desc = "Lazygit" })
    -- gotop/btop
    local gotop = fterm:new({
      ft = "fterm_gotop",
      cmd = "gotop",
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
    })

    vim.keymap.set("n", "<leader>tr", function()
      gotop:toggle()
    end, { desc = "Resource Monitor" })

    -- Scratch terminal (quick one-off commands)
    local scratch = fterm:new({
      ft = "fterm_scratch",
      dimensions = {
        height = 0.5,
        width = 0.7,
      },
    })

    vim.keymap.set("n", "<leader>ts", function()
      scratch:toggle()
    end, { desc = "Scratch Terminal" })

    -- Terminal-specific settings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fterm_*",
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
      end,
    })

    -- Custom highlights (theme adaptive)
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "Fterm", { bg = "#1e1e2e" })
        vim.api.nvim_set_hl(0, "FtermBorder", { fg = "#89b4fa" })
      end,
    })
  end,
}
