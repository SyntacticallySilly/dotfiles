-- SynVim Yazi Plugin
-- Opens ONLY when nvim is started with a directory argument

return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  lazy = true, -- Don't load automatically
  
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
      open_file_in_vertical_split = "<c-v>",
      open_file_in_horizontal_split = "<c-x>",
      open_file_in_tab = "<c-t>",
      grep_in_directory = "<c-s>",
      replace_in_directory = "<c-g>",
      cycle_open_buffers = "<tab>",
      copy_relative_path_to_selected_files = "<c-y>",
    },
  },
  
  config = function(_, opts)
    require("yazi").setup(opts)
    
    -- Check if nvim was opened with a directory argument
    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        -- Only run if exactly 1 argument and it's a directory
        if vim.fn.argc() == 1 then
          local arg = vim.fn.argv(0)
          if vim.fn.isdirectory(arg) == 1 then
            -- Change to that directory
            vim.cmd("cd " .. vim.fn.fnameescape(arg))
            
            -- Open yazi in that directory
            vim.defer_fn(function()
              require("yazi").yazi()
            end, 50)
            
            -- Unload yazi after closing (clean up)
            vim.api.nvim_create_autocmd("User", {
              pattern = "YaziDirChanged",
              once = true,
              callback = function()
                vim.defer_fn(function()
                  require("lazy").reload({ plugins = { "yazi.nvim" } })
                end, 100)
              end,
            })
          end
        end
      end,
    })
  end,
}
