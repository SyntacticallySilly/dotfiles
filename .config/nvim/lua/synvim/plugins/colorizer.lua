-- SynVim Colorizer Plugin
-- Fast color highlighter using virtualtext

return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  cmd = {
    "ColorizerAttachToBuffer",
    "ColorizerDetachFromBuffer",
    "ColorizerReloadAllBuffers",
    "ColorizerToggle",
  },
  keys = {
    { "<leader>uc", "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" },
  },

  opts = {
    -- Attach to all filetypes
    filetypes = {
      "*",
      -- Special configurations for specific filetypes
      css = {
        rgb_fn = true,
        hsl_fn = true,
        css = true,
      },
      scss = {
        rgb_fn = true,
        hsl_fn = true,
        css = true,
      },
      html = {
        names = true,
        css = true,
      },
      javascript = {
        tailwind = true,
      },
      typescript = {
        tailwind = true,
      },
      lua = {
        names = true,
      },
      -- Exclude some filetypes
      "!lazy",
      "!mason",
      "!help",
      "!checkhealth",
    },

    -- Buftype options
    buftypes = {
      "*",
      "!prompt",
      "!popup",
    },

    -- Enable user commands
    user_commands = true,

    -- Default options for all filetypes
    user_default_options = {
      -- Color name codes
      names = false,
      names_opts = {
        lowercase = false,
        camelcase = false,
        uppercase = false,
        strip_digits = false,
      },

      -- Hex codes
      RGB = true,        -- #RGB
      RGBA = true,       -- #RGBA
      RRGGBB = true,     -- #RRGGBB
      RRGGBBAA = true,   -- #RRGGBBAA
      AARRGGBB = true,   -- 0xAARRGGBB

      -- CSS functions
      rgb_fn = true,     -- rgb(), rgba()
      hsl_fn = true,     -- hsl(), hsla()
      css = false,       -- Enable all CSS features at once
      css_fn = true,     -- Enable all CSS functions

      -- Tailwind colors
      tailwind = false,  -- Can enable per-filetype above
      tailwind_opts = {
        update_names = false,
      },

      -- SASS colors
      sass = {
        enable = false,
        parsers = { "css" },
      },

      -- Mode of color indication.
      mode = "virtualtext",

      -- Virtualtext configuration
      virtualtext = "󱓻 ",           -- Character to display
      virtualtext_inline = "before", -- Display after the color code
      virtualtext_mode = "foreground", -- Color the virtualtext character

      -- Always update (useful for completion menus)
      always_update = false,

      -- Hooks for customization
      hooks = {
        -- Don't highlight comment lines (optional)
        disable_line_highlight = function(line, bufnr, line_num)
          -- Uncomment to disable colorizing in comments:
          -- return string.match(line, "^%s*%-%-") ~= nil
          return false
        end,
      },
    },
  },

  config = function(_, opts)
    require("colorizer").setup(opts)

    -- Auto-attach to buffer on enter if needed
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        -- Colorizer already handles this via FileType autocmd
        -- This is just for extra insurance
      end,
    })

    -- Reload colorizer when colorscheme changes to adapt colors
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.schedule(function()
          require("colorizer").reload_all_buffers()
        end)
      end,
    })
  end,
}
