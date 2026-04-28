-- SynVim Treesitter Plugin
-- Syntax highlighting and code parsing with AST (Abstract Syntax Tree)

return {
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = false,
		lazy = true,
		event = "BufReadPre",
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter").setup({
				install_dir = "~/bin/TS/parsers",
				auto_install = true,
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"dockerfile",
					"gleam",
					"go",
					"haskell",
					"hjson",
					"html",
					"ini",
					"java",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"just",
					"kdl",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"markdown_inline",
					"nix",
					"purescript",
					"query",
					"racket",
					"regex",
					"rust",
					"terraform",
					"typescript",
					"typst",
					"vim",
					"vimdoc",
					"yaml",
					"zsh",
				},
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
	{
		"romus204/tree-sitter-manager.nvim",
		dependencies = {}, -- tree-sitter CLI must be installed system-wide
		config = function()
			require("tree-sitter-manager").setup({
				-- ensure_installed = {}, -- list of parsers to install at the start of a neovim session
				border = "rounded", -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
				auto_install = false, -- if enabled, install missing parsers when editing a new file
				highlight = true, -- treesitter highlighting is enabled by default
				-- languages = {}, -- override or add new parser sources
				parser_dir = vim.fn.stdpath("data") .. "/site/parser",
				query_dir = vim.fn.stdpath("data") .. "/site/queries",
			})
		end,
	},
}
