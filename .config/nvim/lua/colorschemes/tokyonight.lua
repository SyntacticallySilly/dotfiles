return {
	"folke/tokyonight.nvim",
	lazy = false,
	name = "tokyonight",
	enabled = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night",
			transparent = true, -- Background styles. Can be "dark", "transparent" or "normal"
			sidebars = "transparent", -- style for sidebars, see below
			floats = "transparent", -- style for floating windows
		})
		vim.cmd([[colorscheme tokyonight]])
	end,
}
