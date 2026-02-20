-- SynVim Telescope Plugin
-- Fuzzy finder for files, text, and more

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  branch = "master",
  cmd = "Telescope",

  keys = {
    { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Files" },
    { "<leader>sv", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>sw", function()
      require('telescope.builtin').grep_string()
    end, desc = "Search Word" },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>st", "<cmd>Telescope colorscheme<cr>", desc = "Themes" },
    { "<leader>sn", "<cmd>Telescope notify<cr>", desc = "Notifications"},
    { "<leader>sm", "<cmd>Telescope resume<cr>", desc = "Resume last search"},
    { "<leader>s%", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search current buffer"},
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "  ",
        -- selection_caret = "|> ",

        sorting_strategy = "descending",
        layout_strategy = "horizontal",

        layout_config = {
          horizontal = {
            prompt_position = "bottom",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 9,
        },

        -- Transparent background
        winblend = 0,
        --[[         borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }, ]]

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-x>"] = actions.delete_buffer,
            ["<Esc>"] = actions.close,
            ["kj"] = actions.close,
          },
          n = {
            ["q"] = actions.close,
            ["x"] = actions.delete_buffer,
          },
        },

        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "%.jpg",
          "%.jpeg",
          "%.png",
          "%.svg",
          "%.otf",
          "%.ttf",
        },
      },

      pickers = {
        find_files = {
          hidden = true,
          -- theme = "ivy",
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
        keymaps = {
          theme = "ivy",
        },
        current_buffer_fuzzy_find = {
          theme = "ivy",
          prompt_position = 'bottom',
          preview_cutoff = 1,
        }
      },
    })

    -- Load extensions
    pcall(telescope.load_extension, "fzf")
  end,
}
