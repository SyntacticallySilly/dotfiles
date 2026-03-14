-- SynVim LSP Configuration
-- Modern vim.lsp.config setup for Neovim 0.11+

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
  },

  config = function()
    -- Get capabilities from blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Diagnostic configuration (global)
    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        severity = vim.diagnostic.severity,
        prefix = function(d)
          return ({ " ", " ", "󰌶 ", "  " })[d.severity]
        end,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN]  = " ",
          [vim.diagnostic.severity.HINT]  = "󰌶 ",
          [vim.diagnostic.severity.INFO]  = " ",
        },
        texthl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
          [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
          [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
          [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
          [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
          [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
          [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
        },
        linehl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
        }
      },
      underline = false,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = false,
        header = { "Diagnostics :", "Bold" }
      },
    })

    -- Python LSP
    vim.lsp.config.pyright = {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    }

    -- Rust LSP
    vim.lsp.config.rust_analyzer = {
      cmd = { "rust-analyzer" },
      filetypes = { "rust" },
      root_markers = { "Cargo.toml", "rust-project.json" },
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          checkOnSave = {
            command = "clippy",
          },
          procMacro = {
            enable = true,
          },
          inlayHints = {
            chainingHints = {
              enable = true,
            },
            parameterHints = {
              enable = true,
            },
            typeHints = {
              enable = true,
            },
          },
        },
      },
    }

    -- Lua LSP
    vim.lsp.config.lua_ls = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = true,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
          telemetry = {
            enable = false,
          },
          completion = {
            callSnippet = "Replace",
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable",
          },
        },
      },
    }

    -- Go LSP
    vim.lsp.config.gopls = {
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_markers = { "go.work", "go.mod", ".git" },
      capabilities = capabilities,
      -- settings = {
      --   gopls = {
      --     analyses = {
      --       unusedparams = true,
      --       shadow = true,
      --       nilness = true,
      --       unusedwrite = true,
      --       useany = true,
      --     },
      --     staticcheck = true,
      --     gofumpt = true,
      --     usePlaceholders = true,
      --     completeUnimported = true,
      --     hints = {
      --       assignVariableTypes = true,
      --       compositeLiteralFields = true,
      --       compositeLiteralTypes = true,
      --       constantValues = true,
      --       functionTypeParameters = true,
      --       parameterNames = true,
      --       rangeVariableTypes = true,
      --     },
      --   },
      -- },
    }

    -- TOML LSP (taplo)
    vim.lsp.config.taplo = {
      cmd = { "taplo", "lsp", "stdio" },
      filetypes = { "toml" },
      capabilities = capabilities,
    }

    vim.lsp.enable({ 'clangd', 'lua_ls', 'taplo', 'gopls', 'pyright', 'rust_analyzer' })

    -- LSP keymaps (set on attach)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function()
        -- Navigation
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Perform rename" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Perform code action" })

        -- Documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show Documentation" })
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })

        -- Diagnostics
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
          { desc = "Next Diagnostic" })
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
          { desc = "Previous Diagnostic" })
      end,
    })
  end,
}
