return {
  'simonmclean/triptych.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'nvim-tree/nvim-web-devicons', -- optional for icons
    'antosha417/nvim-lsp-file-operations' -- optional LSP integration
  },
  opts = {
    options = {
      line_numbers = {
        enabled = true,
        relative = true,
      },
      file_icons = {
        enabled = true,
      },
      border = 'rounded',
      transparecy = 100,
      backdrop = 80,
      margin_x = 1,
      git_signs = {
        enabled = true,
      },
      diagnostic_signs = {
        enabled = true,
      },
    },
  },
  keys = {
    { '<leader>e', ':Triptych<CR>' },
  },
}
