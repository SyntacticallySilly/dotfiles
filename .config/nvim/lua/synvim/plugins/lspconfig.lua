-- SynVim LSP Configuration
-- Modern vim.lsp.config setup for Neovim 0.11+

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    "b0o/schemastore.nvim", -- Added missing dependency
  },

  config = function()
    -- Get capabilities from blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities()

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
            checkThirdParty = false,
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

    -- JSON LSP
    vim.lsp.config.jsonls = {
      cmd = { "vscode-json-language-server", "--stdio" },
      filetypes = { "json", "jsonc" },
      root_markers = { ".git" },
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }

    -- YAML LSP
    vim.lsp.config.yamlls = {
      cmd = { "yaml-language-server", "--stdio" },
      filetypes = { "yaml", "yml" },
      root_markers = { ".git" },
      capabilities = capabilities,
      settings = {
        yaml = {
          validate = true,
          schemaStore = {
            enable = false, -- Disable builtin store, use SchemaStore.nvim instead
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    }

    -- TOML LSP (taplo)
    vim.lsp.config.taplo = {
      cmd = { "taplo", "lsp", "stdio" },
      filetypes = { "toml" },
      root_markers = { ".git" },
      capabilities = capabilities,
    }

    -- Enable LSP servers for their respective filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python" },
      callback = function()
        vim.lsp.enable("pyright")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "rust" },
      callback = function()
        vim.lsp.enable("rust_analyzer")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "lua" },
      callback = function()
        vim.lsp.enable("lua_ls")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go" },
      callback = function()
        vim.lsp.enable("gopls")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "json", "jsonc" },
      callback = function()
        vim.lsp.enable("jsonls")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "yaml", "yml" },
      callback = function()
        vim.lsp.enable("yamlls")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "toml" },
      callback = function()
        vim.lsp.enable("taplo")
      end,
    })

    -- LSP keymaps (set on attach)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local opts = { buffer = args.buf }

        -- Navigation
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

        -- Documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

        -- Code actions
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- Diagnostics
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      end,
    })

    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = {
        prefix = " ",
        spacing = 4,
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
        header = "Diagnostics :",
        prefix = "",
      },
    })

    -- Diagnostic signs
    local signs = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
  end,
}
