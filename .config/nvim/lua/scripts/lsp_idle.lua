-- lsp_idle.lua
local M = {}

local timers = {} -- client_id -> uv_timer
local TIMEOUT_MS = 3 * 60 * 1000

local function clear_timer(client_id)
	local t = timers[client_id]
	if t then
		if not t:is_closing() then
			t:stop()
			t:close()
		end
		timers[client_id] = nil
	end
end

local function count_attached_buffers(client)
	local n = 0
	for _ in pairs(client.attached_buffers or {}) do
		n = n + 1
	end
	return n
end

local function schedule_stop(client)
	clear_timer(client.id) -- reset if one's already pending

	vim.notify(
		("[lsp-idle] last buffer for %s closed, stopping in 3 min if idle"):format(client.name),
		vim.log.levels.INFO
	)

	local timer = vim.uv.new_timer()
	timers[client.id] = timer

	timer:start(TIMEOUT_MS, 0, function()
		vim.schedule(function()
			-- re-check: might have re-attached to a new buffer since scheduling
			local c = vim.lsp.get_client_by_id(client.id)
			if c and count_attached_buffers(c) == 0 then
				vim.notify(("[lsp-idle] stopping %s (idle)"):format(c.name), vim.log.levels.INFO)
				vim.lsp.stop_client(c.id)
			end
			clear_timer(client.id)
		end)
	end)
end

function M.setup()
	local group = vim.api.nvim_create_augroup("LspIdleStop", { clear = true })

	vim.api.nvim_create_autocmd("LspDetach", {
		group = group,
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client then
				return
			end

			-- LspDetach fires before the buffer is fully removed from
			-- client.attached_buffers in some paths, so check on the next tick
			vim.schedule(function()
				local c = vim.lsp.get_client_by_id(args.data.client_id)
				if c and count_attached_buffers(c) == 0 then
					schedule_stop(c)
				end
			end)
		end,
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		callback = function(args)
			-- a new buffer attached to this client, cancel any pending stop
			clear_timer(args.data.client_id)
		end,
	})
end

return M
