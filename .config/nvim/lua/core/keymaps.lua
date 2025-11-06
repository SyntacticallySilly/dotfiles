-- ~/.config/nvim/lua/core/keymaps.lua
local keymap = vim.keymap

-- General
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>w", "<cmd>w<CR>")
keymap.set("n", "<leader>q", "<cmd>q<CR>")

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-j>", "<C-w>j")

-- Window splits
keymap.set("n", "<leader>sv", "<C-w>v")  -- split vertical
keymap.set("n", "<leader>sh", "<C-w>s")  -- split horizontal

