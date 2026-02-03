-- SynVim Minty Color Picker
-- Touch-friendly color picker

return {
  "nvchad/minty",
  dependencies = { "nvchad/volt" },
  
  keys = {
    {
      "<leader>cp",
      function()
        require("minty.huefy").open()
      end,
      desc = "Color Picker (Hue)",
    },
    {
      "<leader>cs",
      function()
        require("minty.shades").open()
      end,
      desc = "Color Shades",
    },
  },
  
  config = function()
    -- Touch-friendly keymaps inside Minty
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "minty",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        
        -- Keyboard navigation (no mouse needed)
        vim.keymap.set("n", "h", "<Left>", { buffer = buf })
        vim.keymap.set("n", "j", "<Down>", { buffer = buf })
        vim.keymap.set("n", "k", "<Up>", { buffer = buf })
        vim.keymap.set("n", "l", "<Right>", { buffer = buf })
        
        -- Faster movement
        vim.keymap.set("n", "H", "5<Left>", { buffer = buf })
        vim.keymap.set("n", "J", "5<Down>", { buffer = buf })
        vim.keymap.set("n", "K", "5<Up>", { buffer = buf })
        vim.keymap.set("n", "L", "5<Right>", { buffer = buf })
        
        -- Select color
        vim.keymap.set("n", "<CR>", function()
          -- Copy color to clipboard
          local line = vim.api.nvim_get_current_line()
          local hex = line:match("#%x%x%x%x%x%x")
          if hex then
            vim.fn.setreg("+", hex)
            vim.notify("Copied: " .. hex, vim.log.levels.INFO)
          end
        end, { buffer = buf })
        
        -- Close
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf })
        vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf })
      end,
    })
  end,
}
