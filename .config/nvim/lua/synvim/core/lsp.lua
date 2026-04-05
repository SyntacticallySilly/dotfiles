local M = {}

local lsp_group = vim.api.nvim_create_augroup("SynvimLsp", { clear = true })
local diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.HINT] = " ",
  [vim.diagnostic.severity.INFO] = " ",
}

local function buf_dir(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return vim.uv.cwd()
  end

  return vim.fs.dirname(name) or vim.uv.cwd()
end

local function root_dir(markers)
  return function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, markers) or buf_dir(bufnr))
  end
end

local function resolve_cmd(candidates)
  for _, cmd in ipairs(candidates) do
    if vim.fn.executable(cmd[1]) == 1 then
      return cmd
    end
  end
end

local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local completion_item = capabilities.textDocument.completion.completionItem

  completion_item.snippetSupport = true
  completion_item.commitCharactersSupport = true
  completion_item.deprecatedSupport = true
  completion_item.documentationFormat = { "markdown", "plaintext" }
  completion_item.insertReplaceSupport = true
  completion_item.labelDetailsSupport = true
  completion_item.preselectSupport = true
  completion_item.tagSupport = { valueSet = { 1 } }
  completion_item.resolveSupport = {
    properties = {
      "additionalTextEdits",
      "detail",
      "documentation",
      "insertText",
      "insertTextFormat",
      "insertTextMode",
      "sortText",
      "textEdit",
    },
  }

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  if capabilities.workspace then
    capabilities.workspace.didChangeWatchedFiles = nil
  end

  return capabilities
end

local function is_large_buffer(bufnr)
  if vim.api.nvim_buf_line_count(bufnr) > 10000 then
    return true
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return false
  end

  local stat = vim.uv.fs_stat(name)
  return stat and stat.size > 512 * 1024 or false
end

local function attach_document_highlight(client, bufnr)
  if not client:supports_method("textDocument/documentHighlight") then
    return
  end

  local group = vim.api.nvim_create_augroup(("SynvimLspDocumentHighlight%d"):format(bufnr), { clear = true })

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "LspDetach" }, {
    group = group,
    buffer = bufnr,
    callback = function(event)
      vim.lsp.buf.clear_references()

      if event.event == "LspDetach" then
        vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
      end
    end,
  })
end

local function attach_navic(client, bufnr)
  if not client:supports_method("textDocument/documentSymbol") then
    return
  end

  local ok, navic = pcall(require, "nvim-navic")
  if ok and type(navic.attach) == "function" then
    pcall(navic.attach, client, bufnr)
  end
end

local function on_attach(client, bufnr)
  if is_large_buffer(bufnr) and client.server_capabilities.semanticTokensProvider then
    pcall(vim.lsp.semantic_tokens.enable, false, { bufnr = bufnr })
  else
    attach_document_highlight(client, bufnr)
  end

  attach_navic(client, bufnr)
end

local function bordered_handler(handler, opts)
  return function(err, result, ctx, config)
    local merged = vim.tbl_deep_extend("force", config or {}, opts)
    return handler(err, result, ctx, merged)
  end
end

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    source = "if_many",
    prefix = function(diagnostic)
      return diagnostic_icons[diagnostic.severity] or ""
    end,
  },
  signs = {
    text = diagnostic_icons,
    texthl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.lsp.handlers["textDocument/hover"] = bordered_handler(vim.lsp.handlers.hover, {
  border = "rounded",
  title = "Documentation",
  title_pos = "center",
  max_width = 100,
})

vim.lsp.handlers["textDocument/signatureHelp"] = bordered_handler(vim.lsp.handlers.signature_help, {
  border = "rounded",
  title = "Signature",
  title_pos = "center",
  max_width = 100,
})

vim.api.nvim_create_autocmd("CursorHold", {
  group = lsp_group,
  callback = function(args)
    if vim.api.nvim_get_mode().mode ~= "n" then
      return
    end

    if #vim.lsp.get_clients({ bufnr = args.buf }) == 0 then
      return
    end

    vim.diagnostic.open_float({
      border = "rounded",
      focusable = false,
      ---@diagnostic disable-next-line
      header = false,
      severity_sort = true,
      scope = "cursor",
      source = "if_many",
    })
  end,
})

vim.lsp.config("*", {
  capabilities = make_capabilities(),
  detached = true,
  exit_timeout = 1500,
  flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
  },
  on_attach = on_attach,
})

local runtime_path = vim.env.VIMRUNTIME or vim.fn.expand("$VIMRUNTIME")
local config_lua_path = vim.fn.stdpath("config") .. "/lua"
local servers = {
  {
    name = "lua_ls",
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_dir = root_dir({
      { ".luarc.json",  ".luarc.jsonc" },
      { ".stylua.toml", "stylua.toml" },
      ".git",
    }),
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          globals = { "vim" },
        },
        format = {
          enable = true,
        },
        hint = {
          enable = false,
          arrayIndex = "Disable",
          paramName = "Disable",
          paramType = true,
          setType = false,
        },
        runtime = {
          version = "LuaJIT",
        },
        telemetry = {
          enable = false,
        },
        workspace = {
          checkThirdParty = false,
          library = {
            runtime_path,
            config_lua_path,
          },
          maxPreload = 2000,
          preloadFileSize = 300,
        },
      },
    },
  },
  {
    name = "rust_analyzer",
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = root_dir({ "Cargo.toml", "rust-project.json", ".git" }),
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          autoreload = true,
          buildScripts = {
            enable = true,
          },
        },
        check = {
          allTargets = false,
          command = "clippy",
        },
        completion = {
          autoimport = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
  {
    name = "clangd",
    cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = root_dir({
      ".clangd",
      "compile_commands.json",
      "compile_flags.txt",
      ".git",
    }),
  },
  {
    name = "gopls",
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = root_dir({ "go.work", "go.mod", ".git" }),
    settings = {
      gopls = {
        analyses = {
          nilness = true,
          shadow = true,
          unreachable = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        completeUnimported = true,
        directoryFilters = {
          "-.git",
          "-.idea",
          "-.vscode",
          "-build",
          "-dist",
          "-node_modules",
          "-tmp",
        },
        gofumpt = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        matcher = "FastFuzzy",
        semanticTokens = true,
        staticcheck = true,
        usePlaceholders = true,
      },
    },
  },
  {
    name = "kotlin_lsp",
    cmd = resolve_cmd({
      { "kotlin-lsp" },
      { "kotlin-language-server" },
    }),
    filetypes = { "kotlin" },
    root_dir = root_dir({
      "settings.gradle.kts",
      "settings.gradle",
      "build.gradle.kts",
      "build.gradle",
      "pom.xml",
      ".git",
    }),
  },
  {
    name = "taplo",
    cmd = resolve_cmd({
      { "taplo",    "lsp", "stdio" },
      { "taplo-lsp" },
    }),
    filetypes = { "toml" },
    root_dir = root_dir({
      { ".taplo.toml", "taplo.toml" },
      "Cargo.toml",
      ".git",
    }),
  },
  {
    name = "yamlls",
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.ansible", "yaml.docker-compose", "yaml.gitlab" },
    get_language_id = function(_, filetype)
      if vim.startswith(filetype, "yaml") then
        return "yaml"
      end

      return filetype
    end,
    root_dir = root_dir({
      { ".yamlls.yaml", ".yamlls.yml" },
      ".git",
    }),
    settings = {
      redhat = {
        telemetry = {
          enabled = false,
        },
      },
      yaml = {
        completion = true,
        format = {
          enable = true,
        },
        hover = true,
        keyOrdering = false,
        schemaStore = {
          enable = false,
          url = "",
        },
        validate = true,
      },
    },
  },
}

local enabled = {}

for _, server in ipairs(servers) do
  if server.cmd and vim.fn.executable(server.cmd[1]) == 1 then
    vim.lsp.config(server.name, server)
    table.insert(enabled, server.name)
  end
end

if #enabled > 0 then
  vim.lsp.enable(enabled)
end

return M
