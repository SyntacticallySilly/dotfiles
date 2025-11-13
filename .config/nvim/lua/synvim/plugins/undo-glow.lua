-- SynVim Undo-Glow Plugin
-- Visual glow effect for edits and operations

return {
  "y3owk1n/undo-glow.nvim",
  event = { "VeryLazy" },

  opts = {
    animation = {
      enabled = true,
      duration = 500,
      animation_type = "zoom",
      window_scoped = true,
    },
    highlights = {
      undo = {
        hl_color = { bg = "#dbdbff" },
      },
      redo = {
        hl_color = { bg = "#bdbdff" },
      },
      yank = {
        hl_color = { bg = "#dbdbff" },
      },
      paste = {
        hl_color = { bg = "#bdbdff" },
      },
      search = {
        hl_color = { bg = "#bdeeff" },
      },
      cursor = {
        hl_color = { bg = "#eebdff" },
      },
    },
    priority = 2048 * 3,
  },

  keys = {
    { "u", function() require("undo-glow").undo() end, mode = "n", desc = "Undo with glow" },
    { "U", function() require("undo-glow").redo() end, mode = "n", desc = "Redo with glow" },
    { "p", function() require("undo-glow").paste_below() end, mode = "n", desc = "Paste below with glow" },
    { "P", function() require("undo-glow").paste_above() end, mode = "n", desc = "Paste above with glow" },
    {
      "n",
      function()
        require("undo-glow").search_next({ animation = { animation_type = "strobe" } })
      end,
      mode = "n",
      desc = "Search next with glow",
    },
    {
      "N",
      function()
        require("undo-glow").search_prev({ animation = { animation_type = "strobe" } })
      end,
      mode = "n",
      desc = "Search prev with glow",
    },
  },

  init = function()
    -- Highlight when yanking
    vim.api.nvim_create_autocmd("TextYankPost", {
      desc = "Highlight when yanking text",
      callback = function()
        require("undo-glow").yank()
      end,
    })

    -- Highlight cursor on significant movement
    vim.api.nvim_create_autocmd("CursorMoved", {
      desc = "Highlight cursor on movement",
      callback = function()
        require("undo-glow").cursor_moved({
          animation = { animation_type = "slide" },
        })
      end,
    })
  end,
}
