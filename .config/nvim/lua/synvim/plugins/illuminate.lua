-- SynVim Illuminate Plugin
-- Highlight all occurrences of word under cursor

return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },

  opts = {
    delay = 200,
    large_file_cutoff = 1000,
    large_file_overrides = {
      providers = { "lsp" },
    },
  },

  config = function(_, opts)
    require("illuminate").configure(opts)

    -- Keymaps for jumping between references
    vim.keymap.set("n", "]]", function()
      require("illuminate").goto_next_reference(false)
    end, { desc = "Next Reference" })

    vim.keymap.set("n", "[[", function()
      require("illuminate").goto_prev_reference(false)
    end, { desc = "Prev Reference" })
  end,
}
