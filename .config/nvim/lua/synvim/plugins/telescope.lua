-- SynVim Telescope Plugin
-- Fuzzy finder for files, buffers, grep, and more

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Optional: fzf-native for faster sorting
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  
  -- Load on command or keymap
  cmd = "Telescope",
  event = "VeryLazy",
  
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    
    telescope.setup({
      defaults = {
        -- UI layout - prompt at top
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
        
        -- Don't preview files by default (faster on Termux)
        preview = {
          hide_on_startup = true,
        },
        
        -- Mappings in Telescope
        mappings = {
          i = {
            -- Insert mode mappings
            ["<C-c>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
          },
          n = {
            -- Normal mode mappings
            ["q"] = actions.close,
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
          },
        },
      },
    })
    
    -- Load fzf extension if available
    pcall(telescope.load_extension, "fzf")
    
    -- NOW load telescope keymaps after telescope is configured
    require("synvim.keymaps").telescope_keymaps()
  end,
}
