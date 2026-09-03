-- SynVim Flash Plugin
-- Enhanced navigation - jump anywhere with 2 keystrokes
return {
	"folke/flash.nvim",
	enabled = false,
	opts = {
		multi_window = false,
		mode = "fuzzy",
		incremental = true,
		nohlsearch = true,
		style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
		highlight = {
			-- show a backdrop with hl FlashBackdrop
			backdrop = true,
			-- Highlight the search matches
			matches = true,
			-- extmark priority
			priority = 5000,
			groups = {
				match = "FlashMatch",
				current = "FlashCurrent",
				backdrop = "FlashBackdrop",
				label = "FlashLabel",
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
	},
}
