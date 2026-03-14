return {
  "rachartier/tiny-glimmer.nvim",
  event = "InsertEnter",
  opts = {
    enabled = true,
    overwrite = {
      -- Automatically map keys to overwrite operations
      -- Set to false if you have custom mappings or prefer manual API calls
      auto_map = true,

      -- Yank operation animation
      yank = {
        enabled = true,
        default_animation = "pulse",
        settings = {
          from_color = "HLYank",
          to_color = "HLYank",
          max_duration = 500,
          min_duration = 500,
        }
      },

      -- Search navigation animation
      search = {
        enabled = true,
        default_animation = "pulse",
        next_mapping = "n", -- Key for next match
        prev_mapping = "N", -- Key for previous match
      },

      -- Paste operation animation
      paste = {
        enabled = true,
        default_animation = "reverse_fade",
        paste_mapping = "p", -- Paste after cursor
        Paste_mapping = "P", -- Paste before cursor
      },

      -- Undo operation animation
      undo = {
        enabled = true,
        default_animation = {
          name = "pulse",
          settings = {
            from_color = "DiffDelete",
            max_duration = 500,
            min_duration = 500,
          },
        },
        undo_mapping = "u",
      },

      -- Redo operation animation
      redo = {
        enabled = true,
        default_animation = {
          name = "pulse",
          settings = {
            from_color = "DiffAdd",
            max_duration = 500,
            min_duration = 500,
          },
        },
        redo_mapping = "U",
      },
    },
  }
}
