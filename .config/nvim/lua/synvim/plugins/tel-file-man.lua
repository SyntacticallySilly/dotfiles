-- SynVim Telescope File Browser
-- Feature-rich file manager with Enter to open

return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },

  keys = {
    { "<leader>e", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File Browser" },
    { "<leader>E", "<cmd>Telescope file_browser<CR>", desc = "File Browser (cwd)" },
  },

  config = function()
    local telescope = require("telescope")
    local fb_actions = require("telescope._extensions.file_browser.actions")
    local actions = require("telescope.actions")

    telescope.setup({
      extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          grouped = true,
          path_display = { "truncate" },
          hidden = { file_browser = true, folder_browser = true },
          respect_gitignore = true,
          git_status = true,
          sorting_strategy = "descending",
          layout_config = {
            prompt_position = "bottom",
          },
          auto_depth = true,
          display_stat = false,
          collapse_dirs = true,
          cwd_to_path = true,

          mappings = {
            ["i"] = {
              -- ENTER opens files/folders
              ["<CR>"] = actions.select_default,

              -- File operations
              ["<C-n>"] = fb_actions.create,
              ["<C-r>"] = fb_actions.rename,
              ["<C-x>"] = fb_actions.remove,
              ["<C-m>"] = fb_actions.move,
              ["<C-y>"] = fb_actions.copy,

              -- Navigation
              ["<C-h>"] = fb_actions.goto_parent_dir,
              ["<C-l>"] = fb_actions.change_cwd,

              -- Toggle
              ["<C-f>"] = fb_actions.toggle_hidden,
              ["<C-s>"] = fb_actions.toggle_all,
            },
            ["n"] = {
              -- ENTER and 'l' open files/folders
              ["<CR>"] = actions.select_default,
              ["l"] = actions.select_default,

              -- File operations
              ["c"] = fb_actions.create,
              ["r"] = fb_actions.rename,
              ["x"] = fb_actions.remove,
              ["m"] = fb_actions.move,
              ["y"] = fb_actions.copy,

              -- Navigation
              ["h"] = fb_actions.goto_parent_dir,
              ["-"] = fb_actions.goto_parent_dir,

              -- Toggle
              ["f"] = fb_actions.toggle_hidden,
              ["s"] = fb_actions.toggle_all,
            },
          },
        },
      },
    })

    telescope.load_extension("file_browser")
  end,
}
