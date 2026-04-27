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
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "Search files",
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
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Search keymaps",
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
			"<leader>sa",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Search symbols",
		},
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Search registers",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Search icons",
		},
		{
			"<leader>s:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Search command history",
		},
		{
			"<leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search find history",
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
		{
			"<leader>tt",
			function()
				Snacks.terminal.toggle()
			end,
			desc = "Toggle terminal",
		},
		{
			"<leader>tl",
			function()
				Snacks.terminal.toggle("lazygit")
			end,
			desc = "Toggle lazygit",
		},
		{
			"<leader>tc",
			function()
				Snacks.terminal.toggle("codex")
			end,
			desc = "Toggle codex",
		},
	},
	-- init = function()
	--   vim.api.nvim_create_autocmd('User', {
	--     pattern = { 'LazyDone', 'VeryLazy' },
	--     callback = function()
	--       pcall(vim.cmd.colorscheme, get_colorscheme())
	--       return vim.g.colors_name == get_colorscheme 'default'
	--     end,
	--   })
	-- end,
	opts = {
		bigfile = { enabled = true },
		-- explorer = {
		--   replace_netrw = false, -- Replace netrw with the snacks explorer
		-- },

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
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('smart')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
            -- { icon = " ", key = "e", desc = "Explore", action = ":lua require('oil').toggle_float(nil ,{ preview = {} })" },
            { icon = "󱎸", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('grep')" },
            { icon = " ", key = "e", desc = "Explore", action = ":lua require('mini.files').open()" },
            { icon = "󰒲 ", key = "l", desc = "Plugins", action = ":Lazy" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
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
		-- explorer = { enabled = true },
		indent = {
			enabled = true,
			hl = rainbow_hls,
			scope = {
				hl = rainbow_hls,
			},
		},
		input = { enabled = true },
		picker = {
			enabled = true,
			prompt = ">=",
			layout = {
				preset = "fallacy",
				reverse = true,
			},
			layouts = {
				fallacy = {
					preset = "fallacy",
					layout = {
						box = "vertical",
						backdrop = false,
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
				select = {
					hidden = { "preview" },
					layout = {
						backdrop = false,
						width = 0.5,
						min_width = 80,
						max_width = 100,
						height = 0.4,
						min_height = 2,
						box = "vertical",
						title = "{title}",
						title_pos = "center",
						{ win = "list", border = "rounded" },
						{ win = "input", height = 1, border = "rounded" },
						{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
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
				-- so this can have a performance impact for large lists and increase memory usage
				cwd_bonus = false, -- give bonus for matching files in the cwd
				frecency = true, -- frecency bonus
			},

			formatters = {
				file = {
					truncate = "left",
					-- filename_first = true,
					min_width = 40,
				},
			},
			sources = {
				files = {
					hidden = true,
					ignored = false,
					exclude = {
						".git/*",
						"node_modules",
						"*.jpg",
						"*.jpeg",
						"*.png",
						"*.svg",
						"*.otf",
						"*.ttf",
					},
				},
				explorer = {
					layout = { preset = "sidebar", preview = true },
					auto_close = false,
				},
				git_files = {
					untracked = true,
				},
				grep = {
					hidden = true,
					ignored = false,
					exclude = {
						".git/*",
						"node_modules",
						"*.jpg",
						"*.jpeg",
						"*.png",
						"*.svg",
						"*.otf",
						"*.ttf",
					},
				},
				recent = {
					filter = { cwd = true },
					layout = { preset = "select" },
				},
				icons = {
					layout = { preset = "select" },
				},
				commands = {
					layout = { preset = "select" },
				},
				diagnostics = {
					layout = { preset = "fallacy" },
					focus = "list",
				},
				colorschemes = {
					-- confirm = function(picker, item)
					--   vim.g.snacks_colors_confirm = true
					--   ---@diagnostic disable-next-line
					--   Snacks.picker.sources.colorschemes.confirm(picker, item)
					--   save_colorscheme(item.text)
					-- end,
					-- on_close = function()
					--   if vim.g.snacks_colors_confirm ~= true then
					--     pcall(vim.cmd.colorscheme, get_colorscheme())
					--   end
					--   vim.g.snacks_colors_confirm = nil
					-- end,
					-- on_change = function(_, item)
					--   if item then
					--     pcall(vim.cmd.colorscheme, item.text)
					--   end
					-- end,
					layout = { preset = "select", hidden = {} },
				},
				keymaps = {
					layout = { preset = "select" },
				},
				buffers = {
					current = false,
					sort_lastused = true,
					layout = { preset = "select" },
					win = {
						input = {
							keys = {
								["<C-x>"] = { "bufdelete", mode = { "n", "i" } },
							},
						},
						list = {
							keys = {
								["x"] = "bufdelete",
								["dd"] = "bufdelete",
							},
						},
					},
				},
				lines = {
					layout = { preset = "fallacy" },
				},
			},
		},
		notifier = {
			timeout = 3000, -- default timeout in ms
			width = { min = 40, max = 0.4 },
			height = { min = 1, max = 0.6 },
			-- editor margin to keep free. tabline and statusline are taken into account automatically
			margin = { top = 0, right = 0, bottom = 0 },
			padding = true, -- add 1 cell of left/right padding to the notification window
			gap = 0, -- gap between notifications
			sort = { "level", "added" }, -- sort by level and time
			-- minimum log level to display. TRACE is the lowest
			-- all notifications are stored in history
			level = vim.log.levels.TRACE,
			icons = {
				error = " ",
				warn = " ",
				info = " ",
				debug = " ",
				trace = " ",
			},
			---@diagnostic disable-next-line : unused-local
			keep = function(notif)
				return vim.fn.getcmdpos() > 0
			end,
			style = "compact",
			top_down = true, -- place notifications from top to bottom
			date_format = "%R", -- time format for notifications
			-- format for footer when more lines are available
			-- `%d` is replaced with the number of lines.
			-- only works for styles with a border
			---@type string|boolean
			more_format = " ↓ %d lines ",
			refresh = 100, -- refresh at most every 50ms
		},
		terminal = {
			bo = {
				filetype = "snacks_terminal",
			},
			stack = true, -- when enabled, multiple split windows with the same position will be stacked together (useful for terminals)
		},
		-- quickfile = { enabled = true },
		scope = {
			underline = true,
		},
		scroll = {
			enabled = true,
		},
		statuscolumn = {
			left = { "sign" },
			right = { "git" },
			git = {
				patterns = { "MiniDiffSign" },
			},
			refresh = 150, -- refresh at most every 50ms
		},
		styles = {
			input = {
				backdrop = 45,
			},
			notification = {
				border = "rounded",
				zindex = 100,
				ft = "markdown",
				wo = {
					winblend = 5,
					wrap = false,
					conceallevel = 2,
					colorcolumn = "",
				},
				bo = { filetype = "snacks_notif" },
			},
		},
		rename = { enabled = true },
		-- words = { enabled = true },
	},
}
