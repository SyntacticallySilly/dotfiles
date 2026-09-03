-- restore cursor to file position in previous editing session
vim.api.nvim_create_augroup("SynVim", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
	group = "SynVim",
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd.normal({ args = { "zz" }, bang = true })
			end)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = "SynVim",
	pattern = { "markdown", "man" },
	callback = function()
		vim.opt_local.wrap = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = "SynVim",
	pattern = "*",
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
	group = "SynVim",
	callback = function()
		vim.opt.listchars = { eol = "↩", tab = "  ", trail = "╴", multispace = "    " }
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	group = "SynVim",
	callback = function()
		vim.opt.listchars = { eol = " ", tab = "  ", trail = "╴", multispace = "    " }
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "quickfix", "nvim-undotree" },
	group = "SynVim",
	callback = function()
		vim.keymap.set("n", "q", "<cmd>quit<cr>")
	end,
})

-- vim.api.nvim_create_autocmd("CmdlineEnter", {
-- 	once = true,
-- 	callback = function()
-- 		require("lua.scripts.range_highlight").setup({})
-- 	end,
-- })

vim.api.nvim_create_autocmd("FileType", {
	group = "SynVim",
	pattern = { "gitcommit", "text" },
	callback = function()
		vim.opt_local.wrap = true
	end,
})

vim.api.nvim_create_autocmd("User", {
	group = "SynVim",
	pattern = "MiniFilesBufferUpdate",
	callback = function(args)
		local lines = vim.api.nvim_buf_get_lines(args.data.buf_id, 0, -1, false)
		---@diagnostic disable-next-line
		for i, line in ipairs(lines) do
			-- Use vim.loop.fs_stat() to get size, mtime, etc.
			-- Set extmarks with virtual text
		end
	end,
})

vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local spinner = { "", "", "", "", "", "" }
		---@diagnostic disable-next-line: param-type-mismatch
		vim.notify(vim.lsp.status(), "info", {
			id = "lsp_progress",
			title = "LSP Progress",
			opts = function(notif)
				notif.icon = ev.data.params.value.kind == "end" and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})

vim.api.nvim_create_autocmd("User", {
	group = "SynVim",
	pattern = "MiniFilesActionRename",
	callback = function(event)
		require("snacks").rename.on_rename_file(event.data.from, event.data.to)
	end,
})
