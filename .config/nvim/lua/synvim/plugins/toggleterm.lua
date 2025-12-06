-- SynVim ToggleTerm Plugin
-- Robust floating terminal for Termux

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<C-/>", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Terminal", mode = { "n", "t" } },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical Terminal" },
    { "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", desc = "Tab Terminal" },
  },

  opts = {
    -- Size settings
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,

    -- Opening behavior
    open_mapping = [[<C-/>]],
    hide_numbers = true,
    shade_terminals = false, -- Better for transparent themes
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,

    -- Floating window settings
    float_opts = {
      border = "curved",
      width = function()
        return math.floor(vim.o.columns * 0.9)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.8)
      end,
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },

    -- Window options
    winbar = {
      enabled = false,
    },

    -- Terminal highlights (adapts to theme)
    highlights = {
      Normal = {
        link = "Normal",
      },
      NormalFloat = {
        link = "NormalFloat",
      },
      FloatBorder = {
        link = "FloatBorder",
      },
    },

    -- Performance
    on_create = function()
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.signcolumn = "no"
    end,
  },

  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Terminal mode keymaps (easy exit)
    function _G.set_terminal_keymaps()
      local opts_map = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-><C-n>]], opts_map)
      vim.keymap.set("t", "jk", [[<C-><C-n>]], opts_map)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts_map)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts_map)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts_map)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts_map)
      vim.keymap.set("t", "<C-/>", "<cmd>close<CR>", opts_map)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    -- Custom terminal functions
    local Terminal = require("toggleterm.terminal").Terminal

    -- Python REPL
    local python = Terminal:new({
      cmd = "python",
      direction = "float",
      hidden = true,
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
    })

    function _PYTHON_TOGGLE()
      python:toggle()
    end

    -- Node REPL
    local node = Terminal:new({
      cmd = "node",
      direction = "float",
      hidden = true,
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
    })

    function _NODE_TOGGLE()
      node:toggle()
    end

    -- Custom keymaps for specific terminals
    vim.keymap.set("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "Python Terminal" })
    vim.keymap.set("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", { desc = "Node Terminal" })

    -- Send current line/selection to terminal
    vim.keymap.set("n", "<leader>ts", function()
      require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count })
    end, { desc = "Send Line to Terminal" })

    vim.keymap.set("v", "<leader>ts", function()
      require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = vim.v.count })
    end, { desc = "Send Selection to Terminal" })
  end,
}
