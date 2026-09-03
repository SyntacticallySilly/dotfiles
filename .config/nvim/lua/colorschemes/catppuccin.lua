return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	enabled = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = true, -- disables setting the background color.
			float = {
				transparent = true, -- enable transparent floating windows
				solid = false, -- use solid styling for floating windows, see |winborder|
			},
			-- dim_inactive = {
			-- 	enabled = false, -- dims the background color of inactive window
			-- 	shade = "light",
			-- 	percentage = 0.15, -- percentage of the shade to apply to the inactive window
			-- },
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
				-- miscs = {}, -- Uncomment to turn off hard-coded styles
			},
			lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
			},
			color_overrides = {},
			custom_highlights = function(colors)
				return {
					-- ["@comment"] = { fg = colors.overlay2, style = { "italic" } },
					CursorLine = { bg = colors.none },
					-- Directory = { style = { "italic" } },
					WinSeparator = { fg = colors.lavender },
				}
			end,
			auto_integrations = true,
			integrations = {
				notify = false,
				snacks = {
					enabled = true,
				},
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
