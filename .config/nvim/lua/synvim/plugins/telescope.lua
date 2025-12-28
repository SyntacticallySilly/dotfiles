-- SynVim Telescope Plugin
-- Fuzzy finder for files, text, and more

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "jvgrootveld/telescope-zoxide",
  },
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
    { "<leader>sz", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide"},
    { "<leader>sn", "<cmd>Telescope notify<cr>", desc = "Notifications"}

  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "  ",
        selection_caret = " ",
        entry_prefix = "",

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
          preview_cutoff = 120,
        },

        -- Transparent background
        winblend = 0,
        --[[         borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }, ]]

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-x>"] = actions.delete_buffer,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["q"] = actions.close,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
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

        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
      },

      pickers = {
        find_files = {
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
        keymaps = {
          theme = "ivy",
        }
      },
    })

    -- Load extensions
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "zoxide")
  end,
}
