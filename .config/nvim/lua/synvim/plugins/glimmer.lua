-- SynVim Tiny Glimmer Plugin
-- Beautiful animations for yank, paste, undo/redo

return {
  "rachartier/tiny-glimmer.nvim",
  event = "VeryLazy",
  
  config = function()
    local glimmer = require("tiny-glimmer")

    -- Helper to get color from highlight group
    local function get_hl_color(group, type)
      type = type or "fg"
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
      if ok and hl and hl[type] then
        return string.format("#%06x", hl[type])
      end
      return nil
    end

    local function setup_glimmer_colors()
      glimmer.setup({
        -- Enable all animations
        enabled = true,

        -- Yank animation
        yank = {
          enabled = true,
          duration = 300,
          color = get_hl_color("DiffText", "bg") or "#f5c2e7",
        },

        -- Paste animation
        paste = {
          enabled = true,
          duration = 350,
          color = get_hl_color("DiffAdd", "bg") or "#a6e3a1",
        },

        -- Search animation
        search = {
          enabled = true,
          duration = 250,
          color = get_hl_color("Search", "bg") or "#f9e2af",
        },

        -- Undo/Redo animation
        undo = {
          enabled = true,
          duration = 300,
          color = get_hl_color("DiffChange", "bg") or "#cba6f7",
        },

        -- Performance for Termux
        performance = {
          max_highlight_count = 30,
        },
      })
    end

    -- Initial setup
    setup_glimmer_colors()

    -- Re-apply on colorscheme change
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = setup_glimmer_colors,
    })
    
    -- Toggle animation keymap only
    vim.keymap.set("n", "<leader>ua", function()
      glimmer.toggle()
      local status = glimmer.is_enabled() and "enabled" or "disabled"
      vim.notify("Glimmer animations " .. status, vim.log.levels.INFO)
    end, { desc = "Toggle Glimmer animations" })
  end,
}
