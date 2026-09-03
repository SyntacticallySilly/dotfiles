-- SynVim Treesitter Plugin
-- Syntax highlighting and code parsing with AST (Abstract Syntax Tree)
return {
	"romus204/tree-sitter-manager.nvim",
	event = "BufReadPost",
	cmd = "TSManager",
	config = function()
		require("tree-sitter-manager").setup({
			border = "rounded",
			auto_install = false,
			highlight = true,
			parser_dir = vim.fn.stdpath("data") .. "/site/parser",
			query_dir = vim.fn.stdpath("data") .. "/site/queries",
			nerdfont = true,
		})
	end,
}
