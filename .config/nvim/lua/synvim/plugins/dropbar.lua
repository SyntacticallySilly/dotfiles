return {
  'Bekaboo/dropbar.nvim',
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },

  opts = {
    bar = {
      update_debounce = 500,
      hover = true,
    },
    menu = {
      preview = false,
      hover = true,
      scrollbar = {
        enable = false,
        background = false,
      },
    },
    fzf = {
      prompt = '#Rose#$ '
    },
    icons = {
      ui = {
        bar = {
          separator = ' > ',
          extends = '..',
        },
      },
    },
    sources = {
      path = {
        max_depth = 12,
      },
      treesitter = {
        max_depth = 10,
      },
      lsp = {
        max_depth = 6,
      },
      markdown = {
        max_depth = 16,

      }
    }
  },
  config = function()
    local dropbar_api = require('dropbar.api')
    vim.keymap.set('n', '<leader>s;', dropbar_api.pick, { desc = 'Search Symbols' })
    vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
  end
}
