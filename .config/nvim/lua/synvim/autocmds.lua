-- vim.api.nvim_create_autocmd("TextYankPost", {
--   group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
--   pattern = "*",
--   desc = "highlight selection on yank",
--   callback = function()
--     vim.highlight.on_yank({ higroup = "HLYank", timeout = 200, visual = true })
--   end,
-- })

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

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("AutoFormat", { clear = true }),
  pattern = "*",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if #clients > 0 then
      vim.lsp.buf.format({ bufnr = bufnr, async = false })
    else
      vim.cmd("normal! gg=G")
    end
  end,
})

local augroup = vim.api.nvim_create_augroup("FloatingHelp", { clear = true })

--- Open a buffer in a centered floating window.
---@param buf integer
local function open_float(buf)
  local width                = math.floor(vim.o.columns * 0.8)
  local height               = math.floor(vim.o.lines * 0.8)

  local win                  = vim.api.nvim_open_win(buf, true, {
    relative  = "editor",
    width     = width,
    height    = height,
    row       = math.floor((vim.o.lines - height) / 2 - 1),
    col       = math.floor((vim.o.columns - width) / 2),
    border    = "rounded",
    title     = " Help ",
    title_pos = "center",
  })

  -- Clean up visuals inside the float
  vim.wo[win].number         = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn     = "no"
  vim.wo[win].statuscolumn   = ""
  vim.wo[win].wrap           = false
  vim.wo[win].linebreak      = false
end

vim.api.nvim_create_autocmd("BufWinEnter", {
  group    = augroup,
  desc     = "Open every help buffer in a floating window",
  callback = function(args)
    local buf = args.buf

    -- Only act on help buffers
    if vim.bo[buf].buftype ~= "help" then
      return
    end

    local win = vim.api.nvim_get_current_win()
    local cfg = vim.api.nvim_win_get_config(win)

    -- If it's already floating, leave it alone
    -- (e.g. following a tag inside the float)
    if cfg.relative ~= "" then
      return
    end

    -- Safety: don't close the last window
    if #vim.api.nvim_list_wins() < 2 then
      return
    end

    -- Close the auto-created split; the buffer stays loaded
    vim.api.nvim_win_close(win, false)

    -- Re-open the same buffer in a centered float
    open_float(buf)
  end,
})
