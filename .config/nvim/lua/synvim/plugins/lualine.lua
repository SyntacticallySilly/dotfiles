-- SynVim Lualine Plugin
-- Minimal statusline with time

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-mini/mini.icons",
  },
  event = 'BufRead',
  config = function()
    local lualine = require("lualine")
    -- Mode icon map
    local mode_icons = {
      n = "󰆾 ",
      i = " ",
      v = "󰩭 ",
      V = "󰕞 ",
      R = "󰬴 ",
      [vim.api.nvim_replace_termcodes("<C-v>", true, true, true)] = "󰙨", -- Visual Block mode (CTRL-V)
      c = "󰘳 ",
      t = " ",
    }
    local function arrow()
      local status = require("arrow.statusline").text_for_statusline_with_icons()
      return status
    end

    lualine.setup({
      options = {
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        always_show_tabline = true,
      },
      -- extensions = { 'quickfix', 'lazy', 'man', 'trouble' },
      sections = {
        -- Left: mode icon
        lualine_a = {
          {
            function()
              local mode = vim.fn.mode()
              return mode_icons[mode] or mode
            end,
            separator = { left = '', right = '' },
            color = { gui = 'bold' },
            padding = { left = 0.8, right = 0.8 },
          },
        },
        -- Middle-left: git branch and diff
        lualine_b = {
          {
            'filename',
            file_status = true,
            color = { gui = 'italic' },
            path = 0,
            shorting_target = 40,
            separator = { right = '' },
            symbols = {
              modified = '~',
              readonly = '@',
              unnamed = '?',
              newfile = '!',
            }
          },
          {
            'branch',
            icon = { '' }
          },
          {
            arrow,
          },
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
          },
        },
        -- Middle: truncated file path with modified indicator
        lualine_c = {
          {
            "diff",
            symbols = { added = "+", modified = "!", removed = "-" },
          },
        },
        -- Right side: LSP, buffer count, time, filetype
        lualine_x = {
          {
            'diagnostics',
            sections = { 'error', 'warn', 'info', 'hint' },
            colored = true,
            diagnostics_color = {
              error = 'DiagnosticSignError',
              warn  = 'DiagnosticSignWarn',
              info  = 'DiagnosticSignInfo',
              hint  = 'DiagnosticSignHint',
            },
          },
          {
            'lsp_status',
            icon = '', -- f013
            symbols = {
              -- Standard unicode symbols to cycle through for LSP progress:
              spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
              -- Standard unicode symbol for when LSP is done:
              done = '✓',
              -- Delimiter inserted between LSP names:
              separator = ' ',
            },
            -- List of LSP names to ignore (e.g., `null-ls`):
            ignore_lsp = {},
            -- Display the LSP name
            show_name = true,
          }
        },
        lualine_y = {
          {
            'location',
            padding = { left = 0, right = 1 },
            separator = { left = '' },
          },
          {
            'selectioncount',
          },
        },
        lualine_z = {
          {
            "filetype",
            colored = false,
            separator = { left = '', right = '' },
            padding = { right = 1, left = 1 },
          },
        },
      },
      tabline = {
        lualine_c = {
          {
            'buffers',
            show_modified_status = true,
            show_filename_only = false, -- Shows shortened relative path when set to false.
            use_mode_colors = false,
            max_length = vim.o.columns * 4,
            buffers_color = {
              active = 'TablineAct',
              inactive = 'TablineNC'
            },
            symbols = {
              alternate_file = '¿',
              directory = ' ',
              modified = '~'
            },
          },
        },
        lualine_z = {
          {
            'tabs',
            mode = 0,
            separator = { left = '', right = '' },
            use_mode_colors = true,
            show_modified_status = false,
          },
        }
      },
    })
  end,
}
