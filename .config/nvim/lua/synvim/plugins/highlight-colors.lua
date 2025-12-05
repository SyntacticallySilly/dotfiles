-- SynVim Highlight Colors Plugin
-- Robust color highlighting with virtual text

return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },

  opts = {
    -- Render style: 'background', 'foreground', or 'virtual'
    render = 'virtual',

    -- Virtual symbol customization
    virtual_symbol = '󱓻 ',
    virtual_symbol_prefix = '',
    virtual_symbol_suffix = ' ',
    virtual_symbol_position = 'inline', -- 'inline', 'eol', or 'eow'

    -- Color support settings
    enable_hex = true,
    enable_short_hex = true,
    enable_rgb = true,
    enable_hsl = true,
    enable_ansi = true,
    enable_named_colors = true,
    enable_tailwind = true,  -- Great for web dev
    enable_var_usage = true, -- CSS variables
    enable_hsl_without_function = true,

    -- Exclusions
    exclude_filetypes = { "lazy", "mason", "TelescopePrompt", "neo-tree", "NvimTree" },
    exclude_buftypes = { "terminal", "nofile" },

    -- Exclude large files (> 1MB)
    exclude_buffer = function(bufnr)
      local filename = vim.api.nvim_buf_get_name(bufnr)
      local size = vim.fn.getfsize(filename)
      return size > 1024 * 1024
    end
  },

  config = function(_, opts)
    require("nvim-highlight-colors").setup(opts)

    -- Hook to ensure colors stay active after color scheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        require("nvim-highlight-colors").turnOn()
      end,
    })
  end,
}
