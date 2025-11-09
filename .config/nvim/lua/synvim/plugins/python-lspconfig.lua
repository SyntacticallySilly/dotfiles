-- SynVim Python LSP Plugin
-- Modern vim.lsp.config setup for Python completion

return {
  "neovim/nvim-lspconfig",
  ft = "python",
  
  config = function()
    -- Use modern vim.lsp.config API for Neovim 0.11+
    if vim.lsp.config then
      vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { 
          "pyproject.toml", 
          "setup.py", 
          "setup.cfg", 
          "requirements.txt", 
          "Pipfile",
          ".git",
        },
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic",
            },
          },
        },
      }
      
      -- Enable pyright for Python files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(args)
          vim.lsp.enable("pyright", { bufnr = args.buf })
        end,
      })
      
    else
      -- Fallback for older Neovim versions
      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic",
            },
          },
        },
      })
    end
    
    -- Python-specific keymaps (on LSP attach)
    vim.api.nvim_create_autocmd("LspAttach", {
      pattern = "*.py",
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Python: " .. desc })
        end
        
        map("<leader>pi", function()
          vim.lsp.buf.execute_command({
            command = "pyright.organizeimports",
            arguments = { vim.uri_from_bufnr(0) },
          })
        end, "Organize Imports")
      end,
    })
  end,
}
