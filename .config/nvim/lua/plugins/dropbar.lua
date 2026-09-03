return {
	"Bekaboo/dropbar.nvim",
	enabled = false,
	lazy = true,
	event = "BufReadPost",
	dependencies = {
		"nvim-mini/mini.nvim",
	},
	config = function()
		local dropbar_api = require("dropbar.api")
		require("dropbar").setup({
			bar = {
				update_debounce = 40,
			},
			menu = {},
		})

		vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
		vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
	end,
}
