return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "InsertEnter",
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "modern",
			transparent_cursorline = true,
			options = {
				multilines = {
					enabled = true,
				},
				set_arrow_to_diag_color = true,
				use_icons_from_diagnostic = true,
				throttle = 50,
				show_all_diags_on_cursorline = true,
			},
		})
	end,
}
