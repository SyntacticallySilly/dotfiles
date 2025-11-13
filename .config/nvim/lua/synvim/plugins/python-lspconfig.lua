-- SynVim Python LSP Plugin
-- Modern vim.lsp setup for Python with blink.cmp

return {
  "neovim/nvim-lspconfig",
  ft = "python",
  dependencies = {
    "saghen/blink.cmp",
  },
  
  config = function()
    -- Use modern vim.lsp.config API if available (Neovim 0.11+)
    if vim.lsp.config then
      -- Modern API
      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", "requirements.txt", ".git" }),
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
              typeCheckingMode = "basic",
            },
          },
        },
      })
      
      -- Enable pyright for Python files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.lsp.enable("pyright")
        end,
      })
    else
      -- Fallback for older Neovim versions
      local lspconfig = require("lspconfig")
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
              typeCheckingMode = "basic",
            },
          },
        },
      })
    end
  end,
}
