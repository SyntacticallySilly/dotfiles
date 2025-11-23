-- SynVim Theme Switcher
-- Switch themes via Telescope with live preview

local M = {}

M.switch_theme = function()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  -- Available themes
  local themes = {
    "catppuccin-mocha",
    "catppuccin-latte",
    "catppuccin-frappe",
    "tokyonight-night",
    "tokyonight-storm",
    "tokyonight-moon",
    "gruvbox",
    "nord",
    "rose-pine",
    "rose-pine-main",
    "rose-pine-moon",
    "rose-pine-dawn",
    "kanagawa",
    "kanagawa-wave",
    "kanagawa-dragon",
    "kanagawa-lotus",
    "dracula",
    "everforest",
    "bamboo",
    "nightfox",
    "nordfox",
    "duskfox",
    "carbonfox",
    "monokai-pro",
    "monokai-pro-octagon",
    "monokai-pro-ristretto",
    "monokai-pro-spectrum",
    "darkvoid"
  }

  -- Store current theme to restore if cancelled
  local current_theme = vim.g.colors_name or "catppuccin-mocha"

  pickers.new({}, {
    prompt_title = "Select Theme",
    finder = finders.new_table({ results = themes }),
    sorter = conf.generic_sorter({}),

    attach_mappings = function(prompt_bufnr, map)
      -- Preview theme as you navigate
      local function preview_theme()
        local selection = action_state.get_selected_entry()
        if selection then
          pcall(vim.cmd, "colorscheme " .. selection[1])
        end
      end

      -- Apply theme on selection
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        if selection then
          pcall(vim.cmd, "colorscheme " .. selection[1])
          -- Save choice to file for persistence
          local file = io.open(vim.fn.stdpath("data") .. "/theme.txt", "w")
          if file then
            file:write(selection[1])
            file:close()
          end
        end
        actions.close(prompt_bufnr)
      end)

      -- Preview on navigation
      map("i", "<C-j>", function()
        actions.move_selection_next(prompt_bufnr)
        preview_theme()
      end)

      map("i", "<C-k>", function()
        actions.move_selection_previous(prompt_bufnr)
        preview_theme()
      end)

      -- Restore original theme on cancel
      map("i", "<Esc>", function()
        pcall(vim.cmd, "colorscheme " .. current_theme)
        actions.close(prompt_bufnr)
      end)

      return true
    end,
  }):find()
end

-- Load saved theme on startup
M.load_theme = function()
  local file = io.open(vim.fn.stdpath("data") .. "/theme.txt", "r")
  if file then
    local theme = file:read("*all")
    file:close()
    theme = theme:gsub("%s+", "")
    if theme and theme ~= "" then
      pcall(vim.cmd, "colorscheme " .. theme)
      return
    end
  end
  -- Default theme if no saved preference
  pcall(vim.cmd, "colorscheme catppuccin-mocha")
end

return M
