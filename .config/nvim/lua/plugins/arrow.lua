-- SynVim Arrow Plugin
return {
	"otavioschwanck/arrow.nvim",
	dependencies = {
		{ "nvim-mini/mini.nvim" },
	},
	config = function()
		require("arrow").setup({
			show_icons = true,
			leader_key = "&",
			buffer_leader_key = "+",
			separate_by_branch = false,
			hide_handbook = false,
			-- Save arrow state (persist between sessions)
			save_path = function()
				return vim.fn.stdpath("cache") .. "/arrow"
			end,
			save_on_change = true,
			show_max_files = 10,
			full_path_list = { "update_stuff" }, -- Files to always show full path
			always_show_path = false,
			separate_save_and_remove = true,

			-- Mappings inside arrow window
			mappings = {
				edit = "e", -- Edit file
				delete_mode = "d", -- Delete mode
				clear_all_items = "C", -- Clear all bookmarks
				toggle = "s", -- Toggle bookmark
				open_vertical = "v", -- Open in vertical split
				open_horizontal = "-", -- Open in horizontal split
				quit = "q", -- Close window
				remove = "x", -- Remove current item
				next_item = "]", -- Next item
				prev_item = "[", -- Previous item
			},

			window = {
				border = "rounded", -- Border style
			},

			-- Per buffer configuration
			per_buffer_config = {
				lines = 4, -- Number of lines to cache for preview
				sort_automatically = true,
				zindex = 10, -- Window z-index
				treesitter_context = nil, -- Use treesitter context
			},

			-- Global bookmarks (always available)
			global_bookmarks = false,

			-- Status line configuration
			statusline = {
				enabled = true,
				separator = "",
				-- Only show current file's index in statusline
				colored = true,
			},
		})

		-- Keymaps for quick navigation (numbered bookmarks)
		vim.keymap.set("n", "H", require("arrow.persist").previous, { desc = "Previous Arrow" })
		vim.keymap.set("n", "L", require("arrow.persist").next, { desc = "Next Arrow" })

		-- Toggle current file bookmark
		vim.keymap.set("n", "<leader>bb", require("arrow.persist").toggle, { desc = "Toggle Bookmark" })

		-- Clear all bookmarks
		vim.keymap.set("n", "<leader>bx", function()
			require("arrow.persist").clear_all()
			vim.notify("All bookmarks cleared", vim.log.levels.INFO)
		end, { desc = "Clear All Bookmarks" })

		-- Quick jump to bookmark by index (1-9)
		for i = 1, 9 do
			vim.keymap.set("n", string.format("<leader>%d", i), function()
				require("arrow.persist").go_to(i)
			end)
		end

		-- Notification on bookmark toggle
		local arrow_persist = require("arrow.persist")
		local original_toggle = arrow_persist.toggle
	end,
}
