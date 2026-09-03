-- SynVim Noice Plugin
-- Floating command bar and search.

return {
	"folke/noice.nvim",
	-- enabled = false,
	event = "BufReadPre",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-mini/mini.nvim",
	},
	config = function()
		require("noice").setup({
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				format = {
					cmdline = { pattern = "^:", title = "", icon = "|>", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = " ", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = " " },
					replace = { pattern = "^:s/", icon = " ", lang = "regex", view = "cmdline" },
					replace_all = { pattern = "^:%%s/", icon = " 󰬳", lang = "regex", view = "cmdline" },
					input = { view = "cmdline_input", icon = "~> " }, -- Used by input()
					selectcmd = { view = "cmdline", pattern = "'<,'>s/", icon = "󱈅 ", lang = "regex" },
					select = { pattern = "'<,'>", icon = "󰒉 ", lang = "vim" },
				},
			},
			messages = {
				enabled = false,
			},
			popupmenu = {
				enabled = false,
			},
			notify = {
				enabled = false,
			},
			lsp = {
				progress = {
					enabled = false,
				},
				hover = { enabled = false },
				signature = { enabled = false },
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
					["vim.lsp.util.stylize_markdown"] = false,
					["cmp.entry.get_documentation"] = false, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		})
	end,
}
