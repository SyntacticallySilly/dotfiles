-- SynVim Keymaps
-- Action-first approach: <leader>s for search actions, <leader>h for harpoon, etc.
-- Keymaps that depend on plugins are wrapped in functions that load after plugins

local M = {}

-- Helper function to set keymaps robustly
local function map(mode, lhs, rhs, opts)
  local options = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

-- ============================================================================
-- TELESCOPE KEYMAPS - Search Actions (<leader>s + letter)
-- These are wrapped in a function that loads AFTER Telescope is ready
-- ============================================================================

M.telescope_keymaps = function()
  local builtin = require("telescope.builtin")

  -- <leader>sf = Search Files
  map("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })

  -- <leader>sg = Search Grep (live grep)
  map("n", "<leader>sg", builtin.live_grep, { desc = "Search Grep" })

  -- <leader>sb = Search Buffers
  map("n", "<leader>sb", builtin.buffers, { desc = "Search Buffers" })

  -- <leader>sh = Search Help tags
  map("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })

  -- <leader>sr = Search Recent files
  map("n", "<leader>sr", builtin.oldfiles, { desc = "Search Recent" })

  -- <leader>ss = Search in current buffer
  map("n", "<leader>ss", function()
    builtin.current_buffer_fuzzy_find()
  end, { desc = "Search buffer content" })

  -- <leader>sw = Search word under cursor
  map("n", "<leader>sw", builtin.grep_string, { desc = "Search Word" })

  -- <leader>sk = Search Keymaps
  map("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })

  -- <leader>sc = Search in config files
  map("n", "<leader>sc", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
  end, { desc = "Search Config" })

  -- <leader>sd = Search diagnostics
  map("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })

  -- <leader>sq = Search quickfix history
  map("n", "<leader>sq", builtin.quickfixhistory, { desc = "Search Quickfix" })
end

-- ============================================================================
-- HARPOON KEYMAPS - Navigation shortcuts (<leader>h + number/action)
-- These are wrapped in a function that loads AFTER Harpoon is ready
-- ============================================================================

M.harpoon_keymaps = function()
  local harpoon = require("harpoon")

  -- <leader>ha = Add current file to harpoon
  map("n", "<leader>ha", function()
    harpoon:list():add()
  end, { desc = "Harpoon Add" })

  -- <leader>he = Toggle harpoon menu
  map("n", "<leader>he", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = "Harpoon Edit" })

  -- <leader>h1 = Jump to harpoon mark 1
  map("n", "<leader>h1", function()
    harpoon:list():select(1)
  end, { desc = "Harpoon 1" })

  -- <leader>h2 = Jump to harpoon mark 2
  map("n", "<leader>h2", function()
    harpoon:list():select(2)
  end, { desc = "Harpoon 2" })

  -- <leader>h3 = Jump to harpoon mark 3
  map("n", "<leader>h3", function()
    harpoon:list():select(3)
  end, { desc = "Harpoon 3" })

  -- <leader>h4 = Jump to harpoon mark 4
  map("n", "<leader>h4", function()
    harpoon:list():select(4)
  end, { desc = "Harpoon 4" })
end

-- ============================================================================
-- WINDOW & NAVIGATION KEYMAPS - General navigation (no plugin dependencies)
-- ============================================================================

M.navigation_keymaps = function()
  -- Window splits
  map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
  map("n", "<leader>wh", "<cmd>split<CR>", { desc = "Split horizontal" })
  map("n", "<leader>wc", "<cmd>close<CR>", { desc = "Close window" })
  map("n", "<leader>wo", "<cmd>only<CR>", { desc = "Close other windows" })
  map("n", "<leader>w=", "<C-w>=", { desc = "Equal window sizes" })

  -- Window navigation (Ctrl + hjkl)
  map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
  map("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
  map("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
  map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

  -- Window resize
  map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
  map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

  -- Buffer navigation
  map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
  map("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "Previous buffer" })
  map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
end

-- ============================================================================
-- EDITING KEYMAPS - Text manipulation (no plugin dependencies)
-- ============================================================================

M.editing_keymaps = function()
  -- Move lines up/down (Alt + j/k)
  map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
  map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
  map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
  map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
  map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
  map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

  -- Indent/unindent in visual mode
  map("v", "<", "<gv", { desc = "Unindent" })
  map("v", ">", ">gv", { desc = "Indent" })

  -- Better escape
  map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
end

-- ============================================================================
-- ALPHA (DASHBOARD) KEYMAPS
-- ============================================================================

M.dashboard_keymaps = function()
  map("n", "<leader>a", "<cmd>Dashboard<CR>", { desc = "Dashboard" })
end

-- ============================================================================
-- BUFFERLINE KEYMAPS - Quick buffer navigation
-- ============================================================================

M.bufferline_keymaps = function()
  -- Navigate buffers by number
  map("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
  map("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
  map("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
  map("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
  map("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
  map("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6" })
  map("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7" })
  map("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8" })
  map("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9" })
end

-- ============================================================================
-- FORMATTING KEYMAPS - Fix indentation and format code
-- ============================================================================

M.formatting_keymaps = function()
  -- Format entire file with LSP (if available, otherwise fallback to indent)
  map("n", "<leader>fl", function()
    -- Try LSP format first
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients > 0 then
      vim.lsp.buf.format({ async = true })
    else
      -- Fallback: use treesitter-based indenting if available
      vim.notify("No LSP formatter available, use <leader>i for manual indent", vim.log.levels.WARN)
    end
  end, { desc = "Format file (LSP)" })

  -- Format selection in visual mode
  map("v", "<leader>fl", function()
    vim.lsp.buf.format({ async = true })
  end, { desc = "Format selection" })

  -- Fix indentation manually (preserves content, only fixes indent)
  map("n", "<leader>fi", function()
    -- Save cursor position
    local save_cursor = vim.api.nvim_win_get_cursor(0)
    -- Store the view to restore scroll position
    local save_view = vim.fn.winsaveview()

    -- Use treesitter indenting if available, otherwise vim's indent
    if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
      -- Reindent using treesitter
      vim.cmd("normal! gg=G")
    else
      -- Fallback to simple reindent
      vim.cmd("normal! gg=G")
    end

    -- Restore view and cursor
    vim.fn.winrestview(save_view)
    vim.api.nvim_win_set_cursor(0, save_cursor)

    vim.notify("Indentation fixed", vim.log.levels.INFO)
  end, { desc = "Fix indentation" })

  -- Alternative: Format with external formatter (if you have prettier, black, etc.)
  map("n", "<leader>fe", function()
    -- This will use conform.nvim if you install it, or fallback to LSP
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ lsp_fallback = true, async = true })
    else
      vim.lsp.buf.format({ async = true })
    end
  end, { desc = "Format with external tool" })
end
-- ============================================================================
-- THEME SWITCHER KEYMAP
-- ============================================================================

M.theme_keymaps = function()
  map("n", "<leader>ss", function()
    require("synvim.theme-switcher").switch_theme()
  end, { desc = "Switch theme" })
end

-- ============================================================================
-- FILE EXPLORER KEYMAPS - Telescope File Browser
-- ============================================================================

M.file_explorer_keymaps = function()
  -- Open file browser in current file's directory
  map("n", "<leader>e", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { desc = "File Explorer (current dir)" })

  -- Open file browser in cwd
  map("n", "<leader>E", "<cmd>Telescope file_browser<CR>",
    { desc = "File Explorer (cwd)" })

  -- Toggle between last file and file browser
  map("n", "<C-n>", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { desc = "Toggle File Explorer" })
end

-- ============================================================================
-- NOICE KEYMAPS
-- ============================================================================

M.notify_keymaps = function()
  -- Notifications Dismiss
  map("n", "<leader>nd", "<cmd>Noice dismiss<CR>",
  { desc = "Dismiss Notifications"})

  --  Search Notificatuon history
  map("n", "<leader>ns", "<cmd>Telescope notify<CR>",
    { desc = "Notificatuons Search"})
end

 -- ============================================================================
-- SETTINGS KEYMAPS
-- ============================================================================
M.settings_keymaps = function()
  -- Opens Dashboard.
 map("n", "<leader>td", "<cmd>Dashboard<CR>", { desc = "Open Dashboard"})
  -- Opens Lazy.nvim
 map("n", "<leader>tlv", "<cmd>Lazy<CR>", { desc = "Open Lazy.nvim"})
  -- LSP styff.
 map("n", "<leader>tlss", "<cmd>LspRestart<CR>", { desc = "Start LSP"})
 map("n", "<leader>tlsp", "<cmd>LspStop<CR>", { desc = "Stop LSP"})
 map("n", "<leader>tlsi", "<cmd>LspInfo<CR>", { desc = "LSP Debug"})
 map("n", "U", "<cmd>redo<CR>", { desc = "Redo"})
end
-- ============================================================================
-- Setup function - Call keymaps that don't depend on plugins
-- Plugin-dependent keymaps are called from their plugin configs
-- ============================================================================

M.setup = function()
  -- Load keymaps that have NO plugin dependencies immediately
  M.navigation_keymaps()
  M.editing_keymaps()
  M.bufferline_keymaps()
  M.formatting_keymaps()
  M.theme_keymaps()
  M.file_explorer_keymaps()
  M.notify_keymaps()
  M.settings_keymaps()
  -- Plugin-dependent keymaps are called from their plugin configs
  -- See telescope.lua and harpoon.lua for when these are called
end

return M
