-- lua/plugins/heirline.lua
return {
	"rebelot/heirline.nvim",
	event = "BufReadPre",
	enabled = false,
	dependencies = { "nvim-mini/mini.nvim" },
	config = function()
		-- TODO: FIX DIAG ICONS & ERRORS
		-- TODO: add surrounding circle icons & stuff.
		-- TODO: gitsigns -> mini.diff

		-- utility vars for easier configuration
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		-- colors setup
		local colors = {
			bright_bg = utils.get_highlight("Folded").bg,
			bright_fg = utils.get_highlight("Folded").fg,
			red = utils.get_highlight("DiagnosticError").fg,
			dark_red = utils.get_highlight("DiffDelete").bg,
			green = utils.get_highlight("Variable").fg,
			blue = utils.get_highlight("Function").fg,
			gray = utils.get_highlight("NonText").fg,
			orange = utils.get_highlight("Constant").fg,
			purple = utils.get_highlight("Statement").fg,
			cyan = utils.get_highlight("Special").fg,
			diag_warn = utils.get_highlight("DiagnosticWarn").fg,
			diag_error = utils.get_highlight("DiagnosticError").fg,
			diag_hint = utils.get_highlight("DiagnosticHint").fg,
			diag_info = utils.get_highlight("DiagnosticInfo").fg,
			git_del = utils.get_highlight("diffDeleted").fg,
			git_add = utils.get_highlight("diffAdded").fg,
			git_change = utils.get_highlight("diffChanged").fg,
		}
		require("heirline").load_colors(colors)
		---

		-- vim mode indicator
		local ViMode = {
			init = function(self)
				self.mode = vim.fn.mode(1) -- :h mode()
			end,
			static = {

				mode_colors = {
					n = colors.red,
					i = colors.green,
					v = colors.cyan,
					V = colors.cyan,
					["\22"] = colors.cyan,
					c = colors.orange,
					s = colors.purple,
					S = colors.purple,
					["\19"] = colors.purple,
					R = "orange",
					r = "orange",
					["!"] = "red",
					t = "red",
				},
			},
			provider = function(self)
				return "%2(" .. self.mode_names[self.mode] .. "%)"
			end,
			-- Same goes for the highlight. Now the foreground will change according to the current mode.
			hl = function(self)
				local mode = self.mode:sub(1, 1) -- get only the first mode character
				return { fg = self.mode_colors[mode], bold = true }
			end,
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}
		-- filename & stuff ykyk
		local FileNameBlock = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
		}

		local FileIcon = {
			init = function(self)
				local filename = self.filename
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		local FileName = {
			provider = function(self)
				-- for options, see :h filename-modifers
				local filename = vim.fn.fnamemodify(self.filename, ":.")
				if filename == "" then
					return ""
				end
				-- now, if the filename would occupy more than 1/4th of the available
				-- space, we trim the file path to its initials
				-- See Flexible Components section below for dynamic truncation
				if not conditions.width_percent_below(#filename, 0.25) then
					filename = vim.fn.pathshorten(filename)
				end
				return filename
			end,
			hl = { fg = utils.get_highlight("Directory").fg },
		}

		local FileFlags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = "~",
				hl = { fg = "green" },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = "",
				hl = { fg = "orange" },
			},
		}

		local FileNameModifer = {
			hl = function()
				if vim.bo.modified then
					-- use `force` because we need to override the child's hl foreground
					return { bold = true, force = true }
				end
			end,
		}

		FileNameBlock = utils.insert(
			FileNameBlock,
			FileIcon,
			utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
			FileFlags,
			{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
		)
		---
		-- do i really need to explain ts?

		local Ruler = {
			-- %l = current line number
			-- %c = column number
			provider = "%l:%c",
		}
		---
		-- Shows active lsp server for the current buffer
		local LSPActive = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach" },

			-- Or complicate things a bit and get the servers names
			provider = function()
				local names = {}
				for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " [" .. table.concat(names, " ") .. "]"
			end,
			hl = { fg = colors.green },
		}
		---
		-- for alignment, duh.
		local Align = { provider = "%=" }
		local Space = { provider = "  " }
		---

		--- random bs go
		local SearchCount = {
			condition = function()
				return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
			end,
			init = function(self)
				local ok, search = pcall(vim.fn.searchcount)
				if ok and search.total then
					self.search = search
				end
			end,
			provider = function(self)
				local search = self.search
				return string.format("[%d/%d]", search.current, math.min(search.total, search.maxcount))
			end,
		}

		local MacroRec = {
			condition = function()
				return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
			end,
			provider = " ",
			hl = { fg = "orange", bold = true },
			utils.surround({ "[", "]" }, nil, {
				provider = function()
					return vim.fn.reg_recording()
				end,
				hl = { fg = "green", bold = true },
			}),
			update = {
				"RecordingEnter",
				"RecordingLeave",
			},
		}

		local TablineBufnr = {
			provider = function(self)
				return tostring(self.bufnr) .. ". "
			end,
			hl = "Comment",
		}

		-- we redefine the filename component, as we probably only want the tail and not the relative path
		local TablineFileName = {
			provider = function(self)
				-- self.filename will be defined later, just keep looking at the example!
				local filename = self.filename
				filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
				return filename
			end,
			hl = function(self)
				return { bold = self.is_active or self.is_visible, italic = true }
			end,
		}

		-- this looks exactly like the FileFlags component that we saw in
		-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
		-- also, we are adding a nice icon for terminal buffers.
		local TablineFileFlags = {
			{
				condition = function(self)
					return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
				end,
				provider = "[+]",
				hl = { fg = "green" },
			},
			{
				condition = function(self)
					return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
						or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
				end,
				provider = function(self)
					if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
						return "  "
					else
						return ""
					end
				end,
				hl = { fg = "orange" },
			},
		}

		-- Here the filename block finally comes together
		local TablineFileNameBlock = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(self.bufnr)
			end,
			hl = function(self)
				if self.is_active then
					return "TabLineSel"
				-- why not?
				-- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
				--     return { fg = "gray" }
				else
					return "TabLine"
				end
			end,
			on_click = {
				callback = function(_, minwid, _, button)
					if button == "m" then -- close on mouse middle click
						vim.schedule(function()
							vim.api.nvim_buf_delete(minwid, { force = false })
						end)
					else
						vim.api.nvim_win_set_buf(0, minwid)
					end
				end,
				minwid = function(self)
					return self.bufnr
				end,
				name = "heirline_tabline_buffer_callback",
			},
			TablineBufnr,
			FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
			TablineFileName,
			TablineFileFlags,
		}

		-- a nice "x" button to close the buffer
		local TablineCloseButton = {
			condition = function(self)
				return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
			end,
			{ provider = " " },
			{
				provider = "",
				hl = { fg = "gray" },
				on_click = {
					callback = function(_, minwid)
						vim.schedule(function()
							vim.api.nvim_buf_delete(minwid, { force = false })
							vim.cmd.redrawtabline()
						end)
					end,
					minwid = function(self)
						return self.bufnr
					end,
					name = "heirline_tabline_close_buffer_callback",
				},
			},
		}

		-- The final touch!
		local TablineBufferBlock = utils.surround({ "", "" }, function(self)
			if self.is_active then
				return utils.get_highlight("TabLineSel").bg
			else
				return utils.get_highlight("TabLine").bg
			end
		end, { TablineFileNameBlock, TablineCloseButton })

		-- and here we go
		local BufferLine = utils.make_buflist(
			TablineBufferBlock,
			{ provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
			{ provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
			-- by the way, open a lot of buffers and try clicking them ;)
		)

		local StatusLine = {
			{ ViMode },
			{ Space },
			{ MacroRec },
			{ Space },
			{ FileNameBlock },
			{ Space },
			-- { Diagnostics },
			{ Align },
			{ Ruler },
			{ Space },
			{ SearchCount },
			{ Space },
			{ LSPActive },
		}

		local TabLine = {
			{ BufferLine },
		}

		-- the winbar parameter is optional!
		require("heirline").setup({
			statusline = StatusLine,
			tabline = TabLine,
			opts = {
				disable_window_cb = true,
				colors = colors,
			},
		})
	end,
}
