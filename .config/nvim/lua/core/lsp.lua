-- ─── Diagnostics ────────────────────────────────────────────────────────────

local diagnostic_icons = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.HINT] = " ",
	[vim.diagnostic.severity.INFO] = " ",
}

vim.diagnostic.config({
	-- virtual_text = {
	-- 	spacing = 2,
	-- 	source = "if_many",
	-- 	prefix = function(diagnostic)
	-- 		return diagnostic_icons[diagnostic.severity] or ""
	-- 	end,
	-- },
	virtual_text = false,
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
	underline = false,
	update_in_insert = false,
	-- virtual_lines = {
	-- 	current_line = false,
	-- 	-- format = function() end,
	-- },
	severity_sort = true,
	float = {
		---@diagnostic disable-next-line:assign-type-mismatch
		header = false,
		focusable = false,
		prefix = "-> ",
		scope = "line",
		border = "none",
		severity_sort = true,
		source = "if_many",
	},
})

-- -- Opens the float
-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	callback = function()
-- 		vim.diagnostic.open_float(nil)
-- 	end,
-- })

-- ─── Markview LSP Hover ─────────────────────────────────────────────────────

-- ─── Global LSP defaults ─────────────────────────────────────────────────────

vim.lsp.config("*", {
	detached = true,
	exit_timeout = 1500,
	flags = {
		allow_incremental_sync = true,
		debounce_text_changes = 150,
	},
	root_markers = { ".git" },
	capabilities = {
		workspace = {
			-- Prevent servers from registering file watchers dynamically;
			-- those watchers are expensive and Neovim has its own.
			didChangeWatchedFiles = {
				dynamicRegistration = false,
			},
		},
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
				augmentsSyntaxTokens = true, -- lets treesitter & tokens coexist
			},
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	},
})

-- ─── Server configs ───────────────────────────────────────────────────────────

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"stylua.toml",
		".git",
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- "${3rd}/luv/library",
					-- vim.fn.stdpath("config") .. "/lua",
				},
			},
			diagnostics = {
				globals = { "vim" },
			},
			hint = {
				enable = true,
				setType = false,
				paramType = true,
				paramName = "Disable",
				semicolon = "Disable",
				arrayIndex = "Disable",
			},
			format = { enable = true },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json", ".git" },
	settings = {
		["rust-analyzer"] = {
			cargo = {
				autoreload = true,
				buildScripts = { enable = true },
			},
			check = {
				allTargets = false,
				command = "clippy",
			},
			completion = {
				autoimport = { enable = true },
			},
			diagnostics = {
				enable = true,
				styleLints = { enable = true },
			},
			lens = {
				enable = true,
				run = { enable = true },
				debug = { enable = true },
				references = { enable = true },
				enumVariant = { enable = true },
			},
			procMacro = { enable = true },
			inlayHints = {
				bindingModeHints = { enable = true },
				closureCaptureHints = { enable = true },
				lifetimeElisionHints = { enable = true, useParameterNames = true },
			},
		},
	},
})

-- clangd needs utf-16 offset encoding to silence the encoding-mismatch warning.
-- vim.lsp.config("clangd", {
-- 	cmd = {
-- 		"clangd",
-- 		"--background-index",
-- 		"--clang-tidy",
-- 		"--header-insertion=never",
-- 		"--completion-style=detailed",
-- 		"--offset-encoding=utf-16",
-- 		"--limit-results=100",
-- 	},
-- 	filetypes = { "c", "cpp", "objc", "objcpp" },
-- 	root_markers = {
-- 		".clangd",
-- 		"compile_commands.json",
-- 		"compile_flags.txt",
-- 		".git",
-- 	},
-- })
vim.lsp.config("ccls", {
	cmd = { "ccls" },
	filetypes = { "c", "cpp" },
	root_markers = {
		".clangd",
		"compile_commands.json",
		"compile_flags.txt",
		".git",
	},
})

vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
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
			matcher = "Fuzzy", -- "FastFuzzy" is not a valid value
			semanticTokens = true,
			staticcheck = true,
			usePlaceholders = true,
		},
	},
})

-- Pick whichever kotlin LSP binary is actually installed.
vim.lsp.config("kotlin_lsp", {
	cmd = (function()
		if vim.fn.executable("kotlin-lsp") == 1 then
			return { "kotlin-lsp" }
		elseif vim.fn.executable("kotlin-language-server") == 1 then
			return { "kotlin-language-server" }
		end
	end)(),
	filetypes = { "kotlin" },
	root_markers = {
		"settings.gradle.kts",
		"settings.gradle",
		"build.gradle.kts",
		"build.gradle",
		"pom.xml",
		".git",
	},
})

vim.lsp.config("taplo", {
	cmd = (function()
		if vim.fn.executable("taplo") == 1 then
			return { "taplo", "lsp", "stdio" }
		elseif vim.fn.executable("taplo-lsp") == 1 then
			return { "taplo-lsp" }
		end
	end)(),
	filetypes = { "toml" },
	root_markers = {
		".taplo.toml",
		"taplo.toml",
		"Cargo.toml",
		".git",
	},
})

vim.lsp.config("yamlls", {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.ansible", "yaml.docker-compose", "yaml.gitlab" },
	root_markers = { ".yamlls.yaml", ".yamlls.yml", ".git" },
	settings = {
		redhat = { telemetry = { enabled = false } },
		yaml = {
			completion = true,
			format = { enable = true },
			hover = true,
			keyOrdering = false,
			schemaStore = { enable = false, url = "" },
			validate = true,
		},
	},
})

vim.lsp.config("zls", {
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_markers = { "zls.json", "build.zig", ".git" },
	settings = {
		zls = {
			enable_inlay_hints = true,
			enable_snippets = true,
			warn_style = true,
			highlight_global_var_declarations = true,
		},
	},
})

vim.lsp.config("ty", {
	cmd = { "ty", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ty.toml", ".git" },
	settings = {
		ty = {
			-- ty language server settings go here
		},
	},
})

vim.lsp.config("marksman", {
	cmd = { "marksman", "server" },
	filetypes = { "markdown", "markdown.mdx" },
	root_markers = { ".marksman.toml", ".git" },
})

-- ─── Enable servers ──────────────────────────────────────────────────────────

vim.lsp.enable({
	"lua_ls",
	"rust_analyzer",
	"clangd",
	"gopls",
	"ccls",
	"ty",
	"kotlin_lsp",
	"taplo",
	"yamlls",
	"zls",
	"marksman",
})
