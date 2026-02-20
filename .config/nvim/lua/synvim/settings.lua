-- SynVim Core Settings
-- Performance-focused for Termux

-- Leader key (must be set before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = "  "

-- Behavior settings
-- vim.opt.hidden = true                  -- Allow hidden buffers
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior
-- Basic settings
vim.opt.autoread = true
vim.opt.autoindent = true
vim.opt.softtabstop = 2
-- vim.opt.showmatch = true
-- vim.loader.enable()
vim.opt.inccommand = "split"
vim.opt.winborder = "rounded"
-- vim.lsp.set_log_level("off")
vim.opt.number = true                               -- Line numbers
vim.opt.relativenumber = true                       -- Relative line numbers
vim.opt.tabstop = 2                                 -- Tab width
vim.opt.shiftwidth = 2                              -- Indentation width
vim.opt.expandtab = true                            -- Use spaces instead of tabs
vim.opt.smartindent = true                          -- Smart indentation
vim.opt.wrap = false                                -- Don't wrap long lines
vim.opt.ignorecase = true                           -- Case-insensitive search
vim.opt.smartcase = true                            -- Smart case sensitivity
vim.opt.hlsearch = true                             -- No search highlight by default
vim.opt.incsearch = true                            -- Incremental search
vim.opt.undofile = true                             -- Persistent undo
vim.opt.backup = false                              -- No backup files
vim.opt.swapfile = false                            -- No swap files
vim.opt.splitbelow = true                           -- Split below
vim.opt.splitright = true                           -- Split right
vim.opt.cursorline = true                           -- Highlight current line
vim.opt.termguicolors = true                        -- True color support
vim.opt.scrolloff = 8                               -- Keep 8 lines visible when scrolling
vim.opt.sidescrolloff = 8                           -- Keep 8 columns visible when scrolling
vim.opt.updatetime = 200                            -- Faster update time (better performance)
vim.opt.timeoutlen = 250                            -- Timeout for key sequences
vim.opt.undolevels = 2000                           -- More undo history (default is 1000)
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Undo directory
-- vim.opt.foldmethod = "expr"                        -- Use expression for folding
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"    -- Use treesitter for folding
-- vim.opt.foldlevel = 99                             -- Start with all folds open
vim.opt.laststatus = 3
vim.opt.mousemoveevent =  true
vim.opt.spell = false
-- vim.opt.ttyfast = true    -- Assume fast terminal connection
-- Reduce memory usage
-- vim.opt.maxmempattern = 2000
vim.opt.shadafile = "NONE" -- Disable shada during editing, save on exit
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '-', nbsp = '␣' }

-- -- Faster completion
vim.opt.pumheight = 8 -- Limit completion menu height

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

local function floating_help(topic)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  
  -- Create a scratch buffer for the help text
  local buf = vim.api.nvim_create_buf(false, true)
  
  -- Open the floating window
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded",
  })
  
  -- Load the help topic into this buffer
  vim.cmd("help " .. topic)
end

-- Create a custom command :H that opens in a float
vim.api.nvim_create_user_command("H", function(opts)
  floating_help(opts.args)
end, { nargs = 1, complete = "help" })


-- Yank to system clipboard (but NOT delete operations)
-- This keeps delete operations in default registers
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.operator == "y" then
      vim.fn.setreg("+", vim.fn.getreg('"'))
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 1
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "text" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
  end,
})

-- Load keymaps (after all settings are configured)
require("synvim.keymaps").setup()
