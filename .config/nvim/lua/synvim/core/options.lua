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
vim.opt.winborder = 'rounded'
vim.opt.showmatch = false
vim.opt.inccommand = "nosplit"
vim.opt.wildmenu = false
-- vim.opt.winborder = "rounded"
-- vim.lsp.set_log_level("off")
vim.opt.number = true                               -- Line numbers
vim.opt.relativenumber = true                       -- Relative line numbers
vim.opt.tabstop = 2                                 -- Tab width
vim.opt.shiftwidth = 0                              -- Indentation width
vim.opt.expandtab = true                            -- Use spaces instead of tabs
vim.opt.smartindent = true                          -- Smart indentation
vim.opt.wrap = false                                -- Don't wrap long lines
vim.opt.ignorecase = true                           -- Case-insensitive search
vim.opt.smartcase = true                            -- Smart case sensitivity
vim.opt.hlsearch = true                             -- Highlight search matches
vim.opt.incsearch = true                            -- Incremental search
vim.opt.undofile = true                             -- Persistent undo
vim.opt.backup = false                              -- No backup files
vim.opt.swapfile = false                            -- No swap files
vim.opt.splitbelow = true                           -- Split below
vim.opt.splitright = true                           -- Split right
vim.opt.cursorline = true                           -- Highlight current line
vim.opt.termguicolors = true                        -- True color support
vim.opt.scrolloff = 10                              -- Keep 8 lines visible when scrolling
vim.opt.sidescrolloff = 10                          -- Keep 8 columns visible when scrolling
vim.opt.updatetime = 300                            -- Faster update time (better performance)
vim.opt.timeoutlen = 250                            -- Timeout for key sequences
vim.opt.cmdheight = 0
vim.opt.undolevels = 2000                           -- More undo history (default is 1000)
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Undo directory
vim.opt.foldmethod = "expr"                         -- Use expression for folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"     -- Use treesitter for folding
vim.opt.foldlevel = 99                              -- Start with all folds open
vim.opt.laststatus = 3
vim.opt.mousemoveevent = true
vim.opt.statuscolumn = "%s%=%l%r%=%#StatColSep#│"
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.spell = false
vim.opt.list = false
vim.opt.fillchars = { eob = ' ', fold = '*', foldopen = '-', foldclose = '+', foldsep = ' ' }
vim.opt.pumheight = 8 -- Limit completion menu height
vim.opt.pumblend = 60
