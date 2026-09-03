return {
	"stevearc/resession.nvim",
	config = function()
		local resession = require("resession")
		resession.setup()
		-- Resession does NOTHING automagically, so we have to set up some keymaps
		vim.keymap.set("n", "<leader>rs", resession.save, { desc = "Session save" })
		vim.keymap.set("n", "<leader>rl", resession.load, { desc = "Session load" })
		vim.keymap.set("n", "<leader>rd", resession.delete, { desc = "Session delete" })
	end,
}
