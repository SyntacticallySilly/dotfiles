-- SynVim Smear Cursor Plugin
-- Smooth cursor animation with fast smear effect

return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",

  opts = {
    -- Cursor color (adapts to theme automatically)
    cursor_color = "#d9e0ee", -- Fallback color, theme overrides this

    -- Normal mode smear
    normal_bg = "#7aa2f7", -- Color for normal mode cursor trail

    -- Smear animation settings
    stiffness = 0.6, -- 0.6 to 1 (higher = faster catch up)
    trailing_stiffness = 0.3, -- Smear trail stiffness (lower = longer trail)
    trailing_exponent = 0.1, -- How fast trail fades (lower = longer visible trail)

    -- Distance settings
    distance_stop_animating = 0.9, -- Stop animating when close to target
    hide_target_hack = false, -- Hide target cursor (keeps visible for better UX)

    -- Legacy smear settings
    legacy_computing_symbols_support = false, -- Faster performance

    -- Smear gamma correction
    gamma = 2.2, -- Standard gamma for smooth gradients

    -- Volume adjustment
    volume_reduction_exponent = -0.2, -- How trail thickness reduces

    -- Minimum update time (performance)
    minimum_update_interval = 16, -- 60 FPS (16ms per frame)

    -- Maximum smear time
    max_slope_horizontal = 3, -- Max horizontal smear speed
    max_slope_vertical = 2, -- Max vertical smear speed

    -- Transparent background support
    transparent_bg_fallback_color = "#dbdbff", -- Catppuccin base fallback
  },

  config = function(_, opts)
    require("smear_cursor").setup(opts)

    -- Get theme colors dynamically
    local function update_smear_colors()
      local normal_fg = vim.api.nvim_get_hl(0, { name = "Cursor" }).fg
      local cursorline_bg = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg

      if normal_fg then
        opts.cursor_color = string.format("#%06x", normal_fg)
      end

      if cursorline_bg then
        opts.normal_bg = string.format("#%06x", cursorline_bg)
      end

      require("smear_cursor").setup(opts)
    end

    -- Update colors when colorscheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.schedule(update_smear_colors)
      end,
    })

    -- Initial color update
    vim.schedule(update_smear_colors)

    -- Toggle keybinding
    vim.keymap.set("n", "<leader>us", function()
      if vim.g.smear_cursor_enabled == nil then
        vim.g.smear_cursor_enabled = true
      end

      if vim.g.smear_cursor_enabled then
        require("smear_cursor").toggle()
        vim.g.smear_cursor_enabled = false
        vim.notify("Smear cursor disabled", vim.log.levels.INFO)
      else
        require("smear_cursor").toggle()
        vim.g.smear_cursor_enabled = true
        vim.notify("Smear cursor enabled", vim.log.levels.INFO)
      end
    end, { desc = "Toggle Smear Cursor" })

    -- Disable smear in certain filetypes for performance
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "lazy",
        "mason",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "toggleterm",
        "TelescopePrompt",
      },
      callback = function()
        vim.b.smear_cursor_disabled = true
      end,
    })
  end,
}
