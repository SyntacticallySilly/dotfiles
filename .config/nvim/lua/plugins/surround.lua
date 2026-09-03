return {
	"kylechui/nvim-surround",
	version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
	event = "BufReadPost",
	config = function()
		require("nvim-surround").setup({
			aliases = {
				["a"] = ">",
				["b"] = ")",
				["B"] = "}",
				["r"] = "]",
				["q"] = { '"', "'", "`" },
				["s"] = { "}", "]", ")", ">", '"', "'", "`" },
			},
			highlight = {}, -- Defines highlight behavior
			move_cursor = "sticky", -- Defines cursor behavior after a surround action
		})

		vim.g.nvim_surround_no_normal_mappings = true

		vim.keymap.set("i", "<C-g>s", "<Plug>(nvim-surround-insert)", {
			desc = "Add a surrounding pair around the cursor (insert mode)",
		})
		vim.keymap.set("i", "<C-g>S", "<Plug>(nvim-surround-insert-line)", {
			desc = "Add a surrounding pair around the cursor, on new lines (insert mode)",
		})
		vim.keymap.set("n", "gs", "<Plug>(nvim-surround-normal)", {
			desc = "Add a surrounding pair around a motion (normal mode)",
		})
		vim.keymap.set("n", "gss", "<Plug>(nvim-surround-normal-cur)", {
			desc = "Add a surrounding pair around the current line (normal mode)",
		})
		vim.keymap.set("n", "gS", "<Plug>(nvim-surround-normal-line)", {
			desc = "Add a surrounding pair around a motion, on new lines (normal mode)",
		})
		vim.keymap.set("n", "gSS", "<Plug>(nvim-surround-normal-cur-line)", {
			desc = "Add a surrounding pair around the current line, on new lines (normal mode)",
		})
		vim.keymap.set("x", "S", "<Plug>(nvim-surround-visual)", {
			desc = "Add a surrounding pair around a visual selection",
		})
		vim.keymap.set("x", "gS", "<Plug>(nvim-surround-visual-line)", {
			desc = "Add a surrounding pair around a visual selection, on new lines",
		})
		vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", {
			desc = "Delete a surrounding pair",
		})
		vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)", {
			desc = "Change a surrounding pair",
		})
		vim.keymap.set("n", "cS", "<Plug>(nvim-surround-change-line)", {
			desc = "Change a surrounding pair, putting replacements on new lines",
		})
	end,
}
