-- SynVim Cinnamon Plugin
-- Smooth scrolling for any command

return {
  "declancm/cinnamon.nvim",
  event = "VeryLazy",
  opts = {
    -- Options
    options = {
      -- Scroll mode: "cursor" or "window"
      -- cursor: animates cursor and window
      -- window: only animates when cursor moves out of view
      mode = "cursor",
      
      -- Delay between each movement (ms)
      delay = 4,
      
      -- Max length of the scrolling animation
      max_delta = {
        line = 100, -- Max lines
        column = false, -- No horizontal scroll limit
        time = 500, -- Max 500ms per scroll
      },
    },

    -- Keymaps (enhanced scrolling commands)
    keymaps = {
      -- Basic scrolling
      basic = true, -- Enable basic keymaps
      extra = false, -- Disable extra keymaps (we'll define custom)
    },
  },

  config = function(_, opts)
    require("cinnamon").setup(opts)
    local cinnamon = require("cinnamon")

    -- Half-page scrolling (centered)
    vim.keymap.set("n", "<C-u>", function()
      cinnamon.scroll("<C-u>zz")
    end, { desc = "Scroll Up (Smooth)" })

    vim.keymap.set("n", "<C-d>", function()
      cinnamon.scroll("<C-d>zz")
    end, { desc = "Scroll Down (Smooth)" })

    -- Full-page scrolling
    vim.keymap.set("n", "<C-b>", function()
      cinnamon.scroll("<C-b>")
    end, { desc = "Page Up (Smooth)" })

    vim.keymap.set("n", "<C-f>", function()
      cinnamon.scroll("<C-f>")
    end, { desc = "Page Down (Smooth)" })

    -- Paragraph navigation
    vim.keymap.set("n", "{", function()
      cinnamon.scroll("{")
    end, { desc = "Prev Paragraph (Smooth)" })

    vim.keymap.set("n", "}", function()
      cinnamon.scroll("}")
    end, { desc = "Next Paragraph (Smooth)" })

    -- Search results (centered)
    vim.keymap.set("n", "n", function()
      cinnamon.scroll("nzzzv")
    end, { desc = "Next Search (Smooth)" })

    vim.keymap.set("n", "N", function()
      cinnamon.scroll("Nzzzv")
    end, { desc = "Prev Search (Smooth)" })

    -- Jump to top/bottom
    vim.keymap.set("n", "gg", function()
      cinnamon.scroll("gg")
    end, { desc = "Top (Smooth)" })

    vim.keymap.set("n", "G", function()
      cinnamon.scroll("G")
    end, { desc = "Bottom (Smooth)" })

    -- LSP integration (smooth jumps)
    vim.keymap.set("n", "gd", function()
      cinnamon.scroll(vim.lsp.buf.definition)
    end, { desc = "Go to Definition (Smooth)" })

    vim.keymap.set("n", "gD", function()
      cinnamon.scroll(vim.lsp.buf.declaration)
    end, { desc = "Go to Declaration (Smooth)" })

    vim.keymap.set("n", "gr", function()
      cinnamon.scroll(vim.lsp.buf.references)
    end, { desc = "Go to References (Smooth)" })

    vim.keymap.set("n", "gi", function()
      cinnamon.scroll(vim.lsp.buf.implementation)
    end, { desc = "Go to Implementation (Smooth)" })

    -- Diagnostic navigation (smooth)
    vim.keymap.set("n", "]d", function()
      cinnamon.scroll(function()
        vim.diagnostic.goto_next()
      end)
    end, { desc = "Next Diagnostic (Smooth)" })

    vim.keymap.set("n", "[d", function()
      cinnamon.scroll(function()
        vim.diagnostic.goto_prev()
      end)
    end, { desc = "Prev Diagnostic (Smooth)" })

    -- Window navigation with scrolling
    vim.keymap.set("n", "<C-w>w", function()
      cinnamon.scroll("<C-w>w")
    end, { desc = "Next Window (Smooth)" })

    -- Performance: disable in large files
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        local lines = vim.api.nvim_buf_line_count(0)
        if lines > 5000 then
          -- Temporarily disable smooth scrolling for large files
          vim.b.cinnamon_disable = true
        else
          vim.b.cinnamon_disable = false
        end
      end,
    })
  end,
}
