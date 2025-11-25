-- SynVim Bufferline Plugin
-- Beautiful buffer tabs with icons and features

return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  version = "*",

  opts = {
    options = {
      mode = "buffers",
      themable = true,

      indicator = {
        icon = "▎",
        style = "icon",
      },

      buffer_close_icon = " ",
      modified_icon = " ",
      close_icon = " ",
      left_trunc_marker = "󰳞 ",
      right_trunc_marker = "󰳠 ",

      max_name_length = 18,
      max_prefix_length = 15,
      truncate_names = true,
      tab_size = 15,

      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or level:match("warning") and " " or " "
        return " " .. icon .. count
      end,

      offsets = {
        {
          filetype = "neo-tree",
          text = "  File Explorer",
          text_align = "left",
          separator = true,
        },
        {
          filetype = "NvimTree",
          text = "  File Explorer",
          text_align = "left",
          separator = true,
        },
      },

      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      show_duplicate_prefix = false,
      persist_buffer_sort = true,
      move_wraps_at_ends = false,
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = false,
      hover = {
        enabled = true,
        delay = 200,
        reveal = {'close'}
      },

      sort_by = 'insert_after_current',

      numbers = function(opts)
        return string.format('%s', opts.raise(opts.ordinal))
      end,

      custom_filter = function(buf_number, buf_numbers)
        if vim.bo[buf_number].filetype ~= "qf" then
          return true
        end
      end,

      groups = {
        options = {
          toggle_hidden_on_enter = true,
        },
        items = {
          {
            name = "Tests",
            highlight = {bg = "#3e4451", fg = "#98c379"},
            priority = 2,
            icon = "",
            matcher = function(buf)
              return buf.name:match('_test') or buf.name:match('_spec')
            end,
          },
          {
            name = "Docs",
            highlight = {bg = "#3e4451", fg = "#61afef"},
            auto_close = false,
            matcher = function(buf)
              return buf.name:match('%.md') or buf.name:match('%.txt')
            end,
          },
        },
      },
    },
  },
}
