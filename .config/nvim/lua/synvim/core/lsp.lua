vim.lsp.enable({ 'clangd', 'lua_ls', 'taplo', 'gopls', 'rust_analyzer' })

local capabilities = require('blink.cmp').get_lsp_capabilities({
  textDocument = { completion = { completionItem = { snippetSupport = false } } },
})

vim.lsp.config.lua_ls = {
  cmd          = { "lua-language-server" },
  filetypes    = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
  capabilities = capabilities,
  settings     = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "nvim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          "VIMRUNTIME"
        },
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace",
      },
      hint = {
        enable = false,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
    },
  },
}

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

vim.lsp.config.gopls = {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  capabilities = capabilities,
}

vim.lsp.config.taplo = {
  cmd = { "taplo", "lsp", "stdio" },
  filetypes = { "toml" },
  capabilities = capabilities,
}

vim.lsp.config.clangd = {
  filetypes = { "c", "cpp" },
  capabilities = capabilities,
}

vim.lsp.config.jdtls = {
  filetypes = { "java", "kt" },
  capabilities = capabilities
}
