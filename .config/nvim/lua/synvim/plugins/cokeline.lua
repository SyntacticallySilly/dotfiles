-- SynVim Cokeline Plugin
-- Beautiful, customizable bufferline

return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = "BufAdd",
  keys = {
    { "<S-Tab>", "<Plug>(cokeline-focus-prev)", desc = "Previous Buffer" },
    { "<Tab>", "<Plug>(cokeline-focus-next)", desc = "Next Buffer" },
    { "<leader>bp", "<Plug>(cokeline-switch-prev)", desc = "Move Buffer Left" },
    { "<leader>bn", "<Plug>(cokeline-switch-next)", desc = "Move Buffer Right" },
    { "<leader>bc", "<Plug>(cokeline-pick-close)", desc = "Pick Close Buffer" },
    { "<leader>bf", "<Plug>(cokeline-pick-focus)", desc = "Pick Focus Buffer" },
  },

  config = function()
    local get_hex = require("cokeline.hlgroups").get_hl_attr
    local mappings = require("cokeline.mappings")

    local colors = {
      normal_bg = get_hex("Normal", "bg"),
      normal_fg = get_hex("Normal", "fg"),
      comment_fg = get_hex("Comment", "fg"),
      
      -- Custom colors (theme adaptive)
      red = "#f38ba8",
      green = "#a6e3a1",
      yellow = "#f9e2af",
      blue = "#89b4fa",
      purple = "#cba6f7",
      cyan = "#89dceb",
      
      bg_inactive = "#181825",
      bg_active = "#313244",
      fg_inactive = "#6c7086",
      fg_active = "#cdd6f4",
    }

    local components = {
      -- Space
      space = {
        text = " ",
        truncation = { priority = 1 },
      },

      -- Two spaces
      two_spaces = {
        text = "  ",
        truncation = { priority = 1 },
      },

      -- Separator
      separator = {
        text = function(buffer)
          return buffer.index ~= 1 and "▏" or ""
        end,
        fg = function(buffer)
          return buffer.is_focused and colors.blue or colors.comment_fg
        end,
        truncation = { priority = 1 },
      },

      -- Devicon
      devicon = {
        text = function(buffer)
          return buffer.devicon.icon
        end,
        fg = function(buffer)
          return buffer.is_focused and buffer.devicon.color or colors.fg_inactive
        end,
        truncation = { priority = 2 },
      },

      -- Buffer index
      index = {
        text = function(buffer)
          return buffer.index .. ": "
        end,
        fg = function(buffer)
          return buffer.is_focused and colors.blue or colors.fg_inactive
        end,
        bold = function(buffer)
          return buffer.is_focused
        end,
        truncation = { priority = 3 },
      },

      -- Unique prefix (for duplicate filenames)
      unique_prefix = {
        text = function(buffer)
          return buffer.unique_prefix
        end,
        fg = function(buffer)
          return buffer.is_focused and colors.fg_active or colors.comment_fg
        end,
        italic = true,
        truncation = { priority = 4, direction = "left" },
      },

      -- Filename
      filename = {
        text = function(buffer)
          return buffer.filename
        end,
        fg = function(buffer)
          return buffer.is_focused and colors.fg_active or colors.fg_inactive
        end,
        bold = function(buffer)
          return buffer.is_focused
        end,
        italic = function(buffer)
          return not buffer.is_focused
        end,
        truncation = { priority = 5, direction = "left" },
      },

      -- Modified indicator
      modified = {
        text = function(buffer)
          return buffer.is_modified and " ●" or ""
        end,
        fg = function(buffer)
          return buffer.is_modified and colors.yellow or nil
        end,
        truncation = { priority = 2 },
      },

      -- Readonly indicator
      readonly = {
        text = function(buffer)
          return buffer.is_readonly and " " or ""
        end,
        fg = colors.red,
        truncation = { priority = 2 },
      },

      -- Close button
      close_button = {
        text = " 󰅖",
        fg = function(buffer)
          return buffer.is_focused and colors.red or colors.fg_inactive
        end,
        on_click = function(_, _, _, _, buffer)
          buffer:delete()
        end,
        truncation = { priority = 1 },
      },
    }

    require("cokeline").setup({
      -- Show bufferline only if there are at least 2 buffers
      show_if_buffers_are_at_least = 2,

      -- Bufferline components
      components = {
        components.separator,
        components.space,
        components.devicon,
        components.space,
        components.index,
        components.unique_prefix,
        components.filename,
        components.modified,
        components.readonly,
        components.close_button,
        components.space,
      },

      -- Default highlight groups
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and colors.fg_active or colors.fg_inactive
        end,
        bg = function(buffer)
          return buffer.is_focused and colors.bg_active or colors.bg_inactive
        end,
      },

      -- Fill (empty space) highlight
      fill_hl = "TabLineFill",

      -- Sidebar integration (neo-tree, aerial, etc.)
      sidebar = {
        filetype = { "neo-tree", "aerial", "NvimTree" },
        components = {
          {
            text = function(buf)
              return buf.filetype
            end,
            fg = colors.blue,
            bg = colors.bg_inactive,
            bold = true,
          },
        },
      },

      -- Rendering options
      rendering = {
        max_buffer_width = 30,
      },

      -- Mappings (for <Plug> keymaps)
      mappings = {
        cycle_prev_next = true,
        disable_mouse = false,
      },

      -- Pick display
      pick = {
        use_filename = true,
        letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
      },

      -- History (for smarter buffer switching)
      history = {
        enabled = true,
        size = 10,
      },
    })

    -- Number keymaps (Alt+1 to Alt+9 for quick buffer access)
    for i = 1, 9 do
      vim.keymap.set("n", ("<A-%s>"):format(i), function()
        mappings.by_index("focus", i)
      end, { desc = ("Buffer %s"):format(i) })
    end

    -- Pick letter (leader + letter to pick buffer)
    vim.keymap.set("n", "<leader>p", function()
      mappings.pick("focus")
    end, { desc = "Pick Buffer" })

    -- Close all but current
    vim.keymap.set("n", "<leader>bC", function()
      local current = vim.api.nvim_get_current_buf()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current and vim.bo[buf].buflisted then
          vim.api.nvim_buf_delete(buf, { force = false })
        end
      end
    end, { desc = "Close All But Current" })
  end,
}
