-- SynVim Core Settings
-- Performance-focused for Termux

-- Leader key (must be set before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
-- vim.opt.autoread = true
vim.loader.enable()
vim.opt.fillchars:append('eob: ')
vim.lsp.set_log_level("off")
vim.opt.number = true               -- Line numbers
vim.opt.relativenumber = true      -- Relative line numbers
vim.opt.tabstop = 2                 -- Tab width
vim.opt.shiftwidth = 2              -- Indentation width
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.smartindent = true          -- Smart indentation
vim.opt.wrap = false                -- Don't wrap long lines
vim.opt.ignorecase = true           -- Case-insensitive search
vim.opt.smartcase = true            -- Smart case sensitivity
vim.opt.hlsearch = false            -- No search highlight by default
vim.opt.incsearch = true            -- Incremental search
vim.opt.undofile = true             -- Persistent undo
vim.opt.backup = false              -- No backup files
vim.opt.swapfile = false            -- No swap files
vim.opt.splitbelow = true           -- Split below
vim.opt.splitright = true           -- Split right
vim.opt.cursorline = true           -- Highlight current line
vim.opt.termguicolors = true        -- True color support
vim.opt.scrolloff = 5               -- Keep 8 lines visible when scrolling
vim.opt.sidescrolloff = 5           -- Keep 8 columns visible when scrolling
vim.opt.updatetime = 5              -- Faster update time (better performance)
vim.opt.timeoutlen = 250            -- Timeout for key sequences
vim.opt.completeopt = "menuone,noselect"  -- Better completion menu
vim.opt.undolevels = 10000          -- More undo history (default is 1000)
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"  -- Undo directory
vim.opt.timeout = true
vim.opt.ttimeoutlen = 10
vim.opt.spell = false
vim.opt.ttyfast = true    -- Assume fast terminal connection
-- Reduce memory usage
vim.opt.maxmempattern = 2000
-- vim.opt.shadafile = "NONE" -- Disable shada during editing, save on exit

-- -- Faster completion
vim.opt.pumheight = 15 -- Limit completion menu height

-- Restore cursor position when reopening files
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   callback = function()
--     local mark = vim.api.nvim_buf_get_mark(0, '"')
--     local lcount = vim.api.nvim_buf_line_count(0)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })

-- Add this to your init.lua or a separate config file

-- Simple approach using vim's built-in last position mark
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursorPosition", { clear = true }),
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    -- Check if the mark is valid and within file bounds
    if mark[1] > 0 and mark[1] <= line_count then
      -- Exclude certain filetypes where cursor restoration doesn't make sense
      local filetype = vim.bo.filetype
      local exclude_ft = { "gitcommit", "gitrebase", "xxd", "commit" }

      if not vim.tbl_contains(exclude_ft, filetype) then
        -- Restore cursor position and center the screen
        vim.cmd('normal! g`"zz')
      end
    end
  end,
})

-- Yank to system clipboard (but NOT delete operations)
-- This keeps delete operations in default registers
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.operator == "y" then
      vim.fn.setreg("+", vim.fn.getreg('"'))
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
      end,
})

-- Load keymaps (after all settings are configured)
require("synvim.keymaps").setup()
