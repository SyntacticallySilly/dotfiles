local rainbow_hls = {
	"RainbowDelimiterRed",
	"RainbowDelimiterYellow",
	"RainbowDelimiterBlue",
	"RainbowDelimiterOrange",
	"RainbowDelimiterGreen",
	"RainbowDelimiterViolet",
	"RainbowDelimiterCyan",
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		---@diagnostic disable: undefined-global
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "Search files",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.pickers()
			end,
			desc = "Search Pickers",
		},
		{
			"<leader>sv",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Search git files",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Search text",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.pick()
			end,
			desc = "Search text",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Search buffers",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Search help",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Search recent files",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.commands()
			end,
			desc = "Search commands",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.treesitter()
			end,
			desc = "Search treesitter",
		},
		{
			"<leader>sA",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Search symbols",
		},
		{
			"<leader>sz",
			function()
				Snacks.picker.zoxide()
			end,
			desc = "Search zoxide",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Search diagnostics",
		},
		{
			"<leader>st",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Search colorschemes",
		},
		{
			"<leader>sn",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Search notifications",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume last search",
		},
		{
			"<leader>s%",
			function()
				Snacks.picker.lines()
			end,
			desc = "Search current buffer",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Search icons",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Search projects",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Search word under cursor",
			mode = { "n", "x" },
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Search undo history",
		},
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "Search references",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto type definition",
		},
		{
			"gai",
			function()
				Snacks.picker.lsp_incoming_calls()
			end,
			desc = "Calls incoming",
		},
		{
			"gao",
			function()
				Snacks.picker.lsp_outgoing_calls()
			end,
			desc = "Calls outgoing",
		},
		{
			"<leader>gi",
			function()
				Snacks.picker.gh_issue()
			end,
			desc = "GitHub Issues (open)",
		},
		{
			"<leader>gP",
			function()
				Snacks.picker.gh_pr()
			end,
			desc = "GitHub Pull Requests (open)",
		},
		{
			"<leader>E",
			function()
				Snacks.explorer.open()
			end,
		},
	},

	opts = {
		bigfile = { enabled = true },

		dashboard = {
			width = 40,
			sections = function()
				local header = [[
	   .-'''-.    ____     __ ,---.   .--.,---.  ,---..-./`) ,---.    ,---.
	  / _     \   \   \   /  /|    \  |  ||   /  |   |\ .-.')|    \  /    |
	 (`' )/`--'    \  _. /  ' |  ,  \ |  ||  |   |  .'/ `-' \|  ,  \/  ,  |
	(_ o _).        _( )_ .'  |  |\_ \|  ||  | _ |  |  `-'`"`|  |\_   /|  |
	 (_,_). '.  ___(_ o _)'   |  _( )_\  ||  _( )_  |  .---. |  _( )_/ |  |
	.---.  \  :|   |(_,_)'    | (_ o _)  |\ (_ o._) /  |   | | (_ o _) |  |
	\    `-'  ||   `-'  /     |  (_,_)\  | \ (_,_) /   |   | |  (_,_)  |  |
	 \       /  \      /      |  |    |  |  \     /    |   | |  |      |  |
	  `-...-'    `-..-'       '--'    '--'   `---`     '---' '--'      '--'

				          ]]
				-- local header = [[
				-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
				-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
				-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
				-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
				-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
				-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
				--
				-- 󰘧 Synthystified 󰘧
				-- ]]

				local function greeting()
					local hour = tonumber(vim.fn.strftime("%H"))
					-- [02:00, 10:00) - morning, [10:00, 18:00) - day, [18:00, 02:00) - evening
					local part_id = math.floor((hour + 6) / 8) + 1
					local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
					local username = os.getenv("USER") or os.getenv("USERNAME") or "Syn"
					return ("Good %s, %s"):format(day_part, username)
				end

        -- stylua: ignore
        return {
          { padding = 0, align = "center", text = { header, hl = "header" } },
          { padding = 2, align = "center", text = { greeting(), hl = "header" } },
          {
            title = "Actions",
            indent = 2,
            padding = 1,
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
            { icon = " ", key = "e", desc = "Explore", action = ":lua require('oil').toggle_float(nil ,{ preview = {} })" },
            { icon = "󱎸", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('grep')" },
            -- { icon = " ", key = "e", desc = "Explore", action = ":lua require('mini.files').open()" },
            { icon = "󰒲 ", key = "l", desc = "Plugins", action = ":Lazy" },
            { icon = " ", key = "t", desc = "Treesitter", action = ":TSManager" },
            { icon = " ", key = "r", desc = "Restore Session", action = ":lua require('resession').load()" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" }
          },
          { title = "Recent Files",    section = "recent_files", indent = 2, padding = 2 },
          -- {
          --   align = "center",
          --   padding = 1,
          --   function()
          --     return require("synvim.core.startup")
          --         .dashboard_item()
          --   end,
          -- },
          { title = "Recent Projects", section = "projects",     indent = 2, padding = 1 },
          { section = "startup" },
        }
			end,
		},

		gh = {
			enabled = true,
		},

		scope = {
			underline = true,
		},

		scroll = {
			enabled = false,
		},

		statuscolumn = {
			enabled = false,
			-- left = { "sign" },
			-- right = { "git" },
			-- git = {
			-- 	patterns = { "MiniDiffSign" },
			-- },
			-- refresh = 150, -- refresh at most every 50ms
		},

		rename = { enabled = true },

		notifier = {
			top_down = false,
			style = "compact",
			level = vim.log.levels.INFO,
		},
		styles = {
			{
				border = true,
				zindex = 100,
				ft = "markdown",
				wo = {
					winblend = 5,
					wrap = false,
					conceallevel = 3,
					colorcolumn = "",
				},
				bo = { filetype = "snacks_notif" },
			},
		},

		explorer = {
			replace_netrw = false,
		},

		indent = {
			indent = {
				only_scope = true,
				only_current = true,
			},
			hl = rainbow_hls,
			scope = {
				hl = rainbow_hls,
			},
		},

		input = { enabled = true },

		dim = {
			scope = {
				min_size = 5,
				max_size = 20,
				siblings = true,
			},
		},
		zen = {
			toggles = {
				dim = true,
				git_signs = false,
				mini_diff_signs = false,
				indent = true,
			},
			center = true,
			show = {
				statusline = true,
			},
			zoom = {
				center = true,
				show = { statusline = false, tabline = false },
			},
		},

		picker = {
			prompt = " ",
			ui_select = true,
			layout = {
				preset = "fallacy",
				reverse = true,
			},
			layouts = {
				fallacy = {
					preset = "fallacy",
					-- hidden = { "preview" },
					layout = {
						box = "vertical",
						row = -1,
						width = 0,
						height = 0,
						border = "none",
						title_pos = "center",
						{ win = "preview", title = "{preview}", height = 9, border = "rounded" },
						{ win = "list", title = "Search {title}", height = 5, border = "rounded" },
						{ win = "input", title = "{live}", height = 1, border = "rounded" },
					},
				},
				sidefall = {
					preset = "sidefall",
					layout = {
						width = 32,
						-- reverse = false,
						min_width = 15,
						height = 0,
						position = "right",
						box = "vertical",
						{ win = "preview", title = "{preview}", height = 0.4, border = "bottom" },
						{ win = "list", border = "none" },
						{
							win = "input",
							height = 1,
							border = true,
							title = "{title} {live} {flags}",
							title_pos = "center",
						},
					},
				},
				select = {
					preset = "select",
					hidden = { "preview" },
					layout = {
						width = 0.5,
						min_width = 80,
						max_width = 100,
						height = 0.4,
						reverse = true,
						min_height = 2,
						box = "vertical",
						title = "{title}",
						title_pos = "center",
						{ win = "preview", title = "{preview}", height = 0.4, border = "bottom" },
						{ win = "list", border = "rounded" },
						{ win = "input", height = 1, border = "rounded" },
					},
				},
			},
			win = {
				input = {
					keys = {
						["<C-j>"] = { "list_down", mode = { "i", "n" } },
						["<C-k>"] = { "list_up", mode = { "i", "n" } },
						["<C-n>"] = { "history_forward", mode = { "i", "n" } },
						["<C-p>"] = { "history_back", mode = { "i", "n" } },
						["<C-q>"] = { "qflist", mode = { "i", "n" } },
						["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
						["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["jk"] = { "cancel", mode = "i" },
					},
				},
			},
			matcher = {
				fuzzy = true, -- use fuzzy matching
				smartcase = true, -- use smartcase
				ignorecase = true, -- use ignorecase
				filename_bonus = true, -- give bonus for matching file names (last part of the path)
				frecency = true, -- frecency bonus
			},
			formatters = {
				file = {
					truncate = "left",
					-- filename_first = true,
					icon_width = 2,
					min_width = 40,
					git_status_hl = true,
				},
				severity = {
					icons = true, -- show severity icons
					level = false, -- show severity level
					pos = "left", -- position of the diagnostics
				},
			},
			jump = {
				reuse_win = true,
				close = false,
				match = false,
			},
			icons = {
				tree = {
					vertical = "│",
					middle = "├─",
					last = "╭",
				},
				diagnostics = {
					Error = " ",
					Hint = "",
					Info = "",
				},
			},
			sources = {
				buffers = {
					layout = "select",
					prompt = "",
					current = false,
					sort_lastused = true,
				},
				treesitter = {
					focus = "list",
					prompt = " ",
					layout = "sidefall",
				},
				lsp_symbols = {
					focus = "list",
					prompt = " ",
					layout = "sidefall",
				},
				command_history = {
					layout = "select",
				},
				explorer = {
					layout = { preset = "sidefall", preview = false },
				},
				files = {
					follow = false,
				},
				grep = {
					prompt = "󱎸",
					-- live = false,
				},
				icons = {
					layout = "select",
				},
				undo = {
					layout = { preset = "sidefall" },
					prompt = "",
					focus = "list",
				},
				lines = {
					prompt = "",
					layout = "fallacy",
				},
			},
		},
	},
}
