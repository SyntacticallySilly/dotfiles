-- SynVim Lualine Plugin
-- Minimal statusline with mode icon, git branch, truncated path, and filetype

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",  -- For git integration
  },
  event = "VeryLazy",
  
  config = function()
    local lualine = require("lualine")
    
    -- Custom function to get truncated file path (3 levels)
    local function truncated_path()
      local path = vim.fn.expand("%:p")  -- Full path
      local home = vim.fn.expand("~")
      
      -- Replace home with ~
      if path:find(home) then
        path = path:gsub(vim.pesc(home), "~")
      end
      
      -- Split by path separator
      local parts = {}
      for part in path:gmatch("[^/]+") do
        table.insert(parts, part)
      end
      
      -- Keep last 3 parts (max depth)
      local depth = math.min(3, #parts)
      local truncated = table.concat(parts, "/", #parts - depth + 1)
      
      -- Add leading slash if absolute path (not starting with ~)
      if path:sub(1, 1) == "/" and truncated:sub(1, 1) ~= "/" then
        truncated = "/" .. truncated
      end
      
      return truncated
    end
    
    -- Mode icon map (minimal display)
    local mode_icons = {
      n = "󰆾 ",      -- Normal mode
      i = " ",      -- Insert mode
      v = "󰩬 ",      -- Visual mode
      [""] = "󰫙 ",   -- Visual-block mode
      c = "󰘳 ",      -- Command mode
      t = " ",      -- Terminal mode
    }
    
    lualine.setup({
      options = {
        theme = "catppuccin-mocha",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "alpha", "dashboard", "startify" },
          tabline = {},
        },
      },
      
      sections = {
        -- Left section: mode icon only
        lualine_a = {
          {
            function()
              local mode = vim.fn.mode()
              return mode_icons[mode] or mode
            end,
            padding = { left = 1, right = 1 },
            color = "lualine_a_normal",
          },
        },
        
        -- Middle-left: git branch and diff stats
        lualine_b = {
          {
            "branch",
            icon = "",
            color = "lualine_b_normal",
          },
          {
            "diff",
            colored = true,
            symbols = { added = " ", modified = " ", removed = " " },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        
        -- Middle: truncated file path
        lualine_c = {
          {
            truncated_path,
            color = "lualine_c_normal",
            padding = { left = 1, right = 1 },
          },
        },
        
        -- Right section: filetype and icon
        lualine_x = {
          {
            "filetype",
            colored = true,
            icon_only = false,
            icon = { align = "left" },
            padding = { left = 1, right = 1 },
          },
        },
        
        -- Far right: empty
        lualine_y = {},
        lualine_z = {},
      },
      
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            truncated_path,
            color = "lualine_c_inactive",
          },
        },
        lualine_x = {
          {
            "filetype",
            colored = false,
            icon_only = true,
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
