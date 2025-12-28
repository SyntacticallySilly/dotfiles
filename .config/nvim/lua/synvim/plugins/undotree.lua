-- SynVim Undotree Plugin
-- Visual undo history tree

return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undotree" },
  },
  
  config = function()
    -- Undotree window on the right
    vim.g.undotree_WindowLayout = 3
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_ShortIndicators = 1
  end,
}
