return {
	dir = "~/dev/tomfoolery",
	priority = 1000,
	lazy = false,
	opts = {
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
			loops = { "blink" },
			functions = { "bold" },
			keywords = {},
			strings = { "italic" },
			variables = {},
			numbers = {},
			booleans = { "italic" },
			properties = {},
			types = { "underdashed" },
			operators = {},
			-- miscs = {}, -- Uncomment to turn off hard-coded styles
		},
		lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
		},
		color_overrides = {},
		custom_highlights = function(colors)
			return {
				["@comment"] = { fg = colors.overlay1, style = { "italic" } },
				CursorLine = { bg = colors.none },
				Directory = { style = { "italic" } },
				SnacksPickerDir = { fg = colors.overlay1, style = { "italic" } },
				WinSeparator = { fg = colors.lavender },
				SnacksPickerListCursorLine = { bg = colors.none, style = { "bold", "italic" } },
				DropBarHover = { bg = colors.none, fg = colors.none, style = { "bold" } },
				MatchParen = { style = { "bold", "underline" }, fg = colors.pink },
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
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd("colorscheme catppuccin-mocha")
	end,
}
