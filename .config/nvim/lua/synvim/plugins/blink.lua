return {
	"saghen/blink.cmp",
	event = "BufRead",
	lazy = true,
	dependencies = {
		-- "moyiz/blink-emoji.nvim",
		"rafamadriz/friendly-snippets",
		-- "saghen/blink.lib",
	},
	version = "1.*",

	opts = {
		keymap = {
			preset = "enter",
			["K"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
		},
		snippets = { preset = "default" },
		cmdline = {
			enabled = true,
			completion = {
				list = { selection = { preselect = false, auto_insert = true } },
				menu = { auto_show = true, draw = { columns = { { "label", "label_description" } } } },
			},
			sources = { "cmdline", "buffer", "path" },
		},
		completion = {
			keyword = { range = "prefix" },
			trigger = {
				show_on_backspace_in_keyword = true,
			},
			accept = {
				-- Write completions to the `.` register
				dot_repeat = true,
				-- Create an undo point when accepting a completion item
				create_undo_point = true,
			},

			list = { selection = { preselect = true, auto_insert = true } },
			menu = {
				scrollbar = false,
				border = "none",
				auto_show = true,
				draw = {
					snippet_indicator = "@",
					treesitter = { "lsp", "buffer" },
					columns = {
						{ "label" },
						{ "label_description", "kind", "kind_icon", gap = 1, "source_name" },
					},
				},
			},
			ghost_text = {
				enabled = true,
				show_with_selection = true,
				show_without_selection = false,
				show_with_menu = false,
				show_without_menu = true,
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 550,
				update_delay_ms = 550,
				treesitter_highlighting = true,
				window = {
					min_width = 10,
					max_width = 80,
					max_height = 20,
					border = "rounded", -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
					winblend = 10,
					-- Note that the gutter will be disabled when border ~= 'rounded'
					scrollbar = true,
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets" },
			providers = {
				lsp = {
					name = "LSP",
					fallbacks = { "buffer" },
				},
				path = {
					opts = {
						trailing_slash = true,
						label_trailing_slash = true,
						show_hidden_files_by_default = true,
						-- This limits memory use and responsiveness for very large folders.
						max_entries = 500,
					},
				},
				snippets = {
					opts = {
						-- Whether to use show_condition for filtering snippets
						use_show_condition = true,
						-- Whether to show autosnippets in the completion list
						show_autosnippets = false,
						-- Whether to prefer docTrig placeholders over trig when expanding regTrig snippets
						prefer_doc_trig = false,
						-- Whether to put the snippet description in the label description
						use_label_description = true,
					},
				},
			},
		},
		fuzzy = {
			-- Controls which implementation to use for the fuzzy matcher.
			--
			-- 'prefer_rust_with_warning' (Recommended) If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available, emitting a warning message.
			-- 'prefer_rust' If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available.
			-- 'rust' Always use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Error if not available.
			-- 'lua' Always use the Lua implementation, doesn't download any prebuilt binaries
			--
			-- See the prebuilt_binaries section for controlling the download behavior
			implementation = "lua",

			-- Allows for a number of typos relative to the length of the query
			-- Set this to 0 to match the behavior of fzf
			-- Note, this does not apply when using the Lua implementation.
			max_typos = function(keyword)
				return math.floor(#keyword / 4)
			end,

			-- Frecency tracks the most recently/frequently used items and boosts the score of the item
			-- Note, this does not apply when using the Lua implementation.
			frecency = {
				enabled = false,
				path = vim.fn.stdpath("state") .. "/blink/cmp/frecency.dat",
			},
			use_proximity = true,
			sorts = {
				"exact",
				"score",
				"sort_text",
			},
		},
	},
}
