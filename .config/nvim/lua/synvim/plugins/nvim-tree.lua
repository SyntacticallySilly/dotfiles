-- SynVim Nvim-Tree Plugin
-- Beautiful file explorer on the right side

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" },
    { "<leader>o", "<cmd>NvimTreeFocus<CR>", desc = "Focus Explorer" },
  },
  
  opts = {
    view = {
      side = "right",  -- Open on right side
      width = 35,      -- Width of tree
      preserve_window_proportions = true,
    },
    
    renderer = {
      root_folder_label = false,  -- Don't show root folder label
      highlight_git = true,
      highlight_opened_files = "name",
      indent_markers = {
        enable = true,  -- Show indent guides
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            default = "",
            empty = "󰷌",
            empty_open = "󱧴",
            open = "",
            symlink = "󰴋",
            symlink_open = "󰝉",
            arrow_open = "󰉒",
            arrow_closed = "󰉍",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    
    filters = {
      dotfiles = false,  -- Show dotfiles
      custom = { "^.git$" },  -- Hide .git folder
    },
    
    git = {
      enable = true,
      ignore = false,  -- Show gitignored files
    },
    
    actions = {
      open_file = {
        quit_on_open = false,
        window_picker = {
          enable = true,
        },
      },
    },
  },
}
