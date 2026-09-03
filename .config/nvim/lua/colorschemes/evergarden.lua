return {
	"everviolet/nvim",
	name = "evergarden",
	lazy = true,
	opts = {
		theme = {
			variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
			accent = "blue",
		},
		editor = {
			transparent_background = true,
			sign = { color = "none" },
			float = {
				color = "mantle",
				solid_border = false,
			},
			completion = {
				color = "surface0",
			},
		},
	},
}
