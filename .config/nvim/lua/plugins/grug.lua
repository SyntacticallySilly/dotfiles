return {
	"MagicDuck/grug-far.nvim",
	event = "BufReadPost",
	dependencies = {
		"nvim-mini/mini.nvim",
	},
	config = function()
		require("grug-far").setup()
	end,
}
