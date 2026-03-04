-- SynVim Telescope Plugin
-- Fuzzy finder for files, text, and more

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-mini/mini.icons",
    "2KAbhishek/nerdy.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  branch = "master",
  cmd = "Telescope",

  keys = {
    { "<leader>sf", "<cmd>Telescope find_files<cr>",                desc = "Files" },
    { "<leader>sv", "<cmd>Telescope git_files<cr>",                 desc = "Git Files" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>",                 desc = "Live Grep" },
    { "<leader>sb", "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>",                 desc = "Help" },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>",                  desc = "Recent Files" },
    { "<leader>sc", "<cmd>Telescope commands<cr>",                  desc = "Commands" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",                   desc = "Keymaps" },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>",               desc = "Diagnostics" },
    { "<leader>st", "<cmd>Telescope colorscheme<cr>",               desc = "Themes" },
    { "<leader>sn", "<cmd>Telescope notify<cr>",                    desc = "Notifications" },
    { "<leader>sm", "<cmd>Telescope resume<cr>",                    desc = "Resume last search" },
    { "<leader>s%", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search current buffer" },
    { "<leader>sa", "<cmd>Telescope aerial<cr>",                    desc = "Search Aerial" },
    { '<leader>s"', "<cmd>Telescope registers<cr>",                 desc = "Registers" },
    { "<leader>si", "<cmd>Telescope nerdy<cr>",                     desc = "Search Nerd Icons" },
    {
      "<leader>sw",
      function()
        require('telescope.builtin').grep_string()
      end,
      desc = "Search word under cursor"
    },
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        sorting_strategy = "descending",
        path_display = { truncate = 3 },
        layout_strategy = "horizontal",
        dynamic_preview_title = true,

        layout_config = {
          horizontal = {
            prompt_position = "bottom",
            preview_width = 0.55,
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
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["jk"] = actions.close
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
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob", "!.git/*" }
          end,
        },
        oldfiles = {
          only_cwd = true, -- only show recent files from the current project
        },
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal", -- you usually browse, not search
        },
        keymaps = {
          theme = "ivy",
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
          sort_lastused = true,
          sort_mru = true,
          ignore_current_buffer = true,
        },
        current_buffer_fuzzy_find = {
          theme = "ivy",
          preview_cutoff = 1,
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Load extensions
    telescope.load_extension("fzf")
    telescope.load_extension("nerdy")
  end,
}
