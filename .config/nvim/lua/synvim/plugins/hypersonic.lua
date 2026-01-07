-- SynVim Hypersonic Plugin
-- Interactive regex explanation and live substitution preview

return {
  "tomiis4/Hypersonic.nvim",
  event = "CmdlineEnter",
  cmd = "Hypersonic",
  keys = {
    { "<leader>re", "<cmd>Hypersonic<cr>", mode = { "n", "v" }, desc = "Regex Explainer" },
  },

  config = function()
    require("hypersonic").setup({
      -- Border style for floating window
      border = "rounded",
      
      -- Window transparency (0-100)
      winblend = 0,
      
      -- Add padding inside window
      add_padding = true,
      
      -- Highlight group for regex matches
      hl_group = "IncSearch",
      
      -- Wrapping characters for regex display
      wrapping = '"',
      
      -- Enable live explanation in command-line mode (/, ?, :s/)
      enable_cmdline = true,
    })

    -- Enable live substitution preview (Neovim built-in)
    -- Shows changes as you type :s/pattern/replacement/
    vim.opt.inccommand = "split"

    -- Custom highlights (theme adaptive)
    local function setup_highlights()
      -- Hypersonic window
      vim.api.nvim_set_hl(0, "HypersonicBorder", { fg = "#89b4fa" })
      vim.api.nvim_set_hl(0, "HypersonicNormal", { bg = "#1e1e2e" })
      
      -- Regex match highlights (brighter for visibility)
      vim.api.nvim_set_hl(0, "HypersonicMatch", { fg = "#11111b", bg = "#f9e2af", bold = true })
      
      -- Explanation text
      vim.api.nvim_set_hl(0, "HypersonicExplanation", { fg = "#cdd6f4", italic = true })
      vim.api.nvim_set_hl(0, "HypersonicValue", { fg = "#a6e3a1", bold = true })
      vim.api.nvim_set_hl(0, "HypersonicChildren", { fg = "#89dceb" })
      
      -- Live substitution preview (built-in)
      vim.api.nvim_set_hl(0, "Substitute", { fg = "#11111b", bg = "#f38ba8", bold = true })
      vim.api.nvim_set_hl(0, "IncSearch", { fg = "#11111b", bg = "#a6e3a1", bold = true })
    end

    setup_highlights()

    -- Re-apply on colorscheme change
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = setup_highlights,
    })

    -- Keymaps for common substitute operations (with live preview)
    vim.keymap.set("n", "<leader>rs", ":%s/\\v", { desc = "Substitute (Very Magic)" })
    vim.keymap.set("v", "<leader>rs", ":s/\\v", { desc = "Substitute Selection (Very Magic)" })
    
    -- Smart substitute: word under cursor
    vim.keymap.set("n", "<leader>rw", function()
      local word = vim.fn.expand("<cword>")
      vim.cmd(":%s/\\v\\<" .. word .. "\\>//g")
      vim.fn.feedkeys("hi", "n") -- Move cursor before /g for replacement
    end, { desc = "Substitute Word Under Cursor" })
    
    -- Substitute in visual selection
    vim.keymap.set("v", "<leader>rr", ":s/\\v", { desc = "Replace in Selection" })

    -- Quick regex testing keybinds
    vim.keymap.set("n", "<leader>rt", function()
      local line = vim.api.nvim_get_current_line()
      vim.cmd("Hypersonic " .. line)
    end, { desc = "Test Regex on Current Line" })

    -- Visual mode: explain selected regex
    vim.keymap.set("v", "<leader>re", function()
      vim.cmd("'<,'>Hypersonic")
    end, { desc = "Explain Selected Regex" })

    -- Auto-trigger Hypersonic when entering search mode
    vim.api.nvim_create_autocmd("CmdlineEnter", {
      callback = function()
        local cmdtype = vim.fn.getcmdtype()
        -- Trigger on / or ? (search) but not on : (command)
        if cmdtype == "/" or cmdtype == "?" then
          vim.defer_fn(function()
            -- Hypersonic's cmdline mode is auto-enabled
            -- Just ensure highlights are good
            setup_highlights()
          end, 50)
        end
      end,
    })

    -- Notification on Hypersonic invocation
    local original_cmd = vim.api.nvim_create_user_command
    vim.api.nvim_create_user_command("HypersonicExplain", function(opts)
      vim.cmd("Hypersonic " .. (opts.args or ""))
      vim.notify("🔍 Regex explanation active", vim.log.levels.INFO, { timeout = 1000 })
    end, { nargs = "?", desc = "Explain regex with notification" })

    -- Helpful tips in statusline (optional)
    -- Shows when in substitute mode
    vim.api.nvim_create_autocmd("CmdlineEnter", {
      callback = function()
        if vim.fn.getcmdtype() == ":" then
          local cmdline = vim.fn.getcmdline()
          if vim.startswith(cmdline, "s/") or vim.startswith(cmdline, "%s/") then
            vim.notify("💡 Live preview enabled", vim.log.levels.INFO, { 
              timeout = 500,
              render = "compact"
            })
          end
        end
      end,
    })

    -- Documentation helper command
    vim.api.nvim_create_user_command("RegexHelp", function()
      local help_text = {
        "╔═══════════════════════════════════════════╗",
        "║        Hypersonic & Regex Cheatsheet     ║",
        "╠═══════════════════════════════════════════╣",
        "║ <leader>re - Explain regex               ║",
        "║ <leader>rs - Start substitute            ║",
        "║ <leader>rw - Substitute word under cursor║",
        "║ <leader>rt - Test regex on current line  ║",
        "╠═══════════════════════════════════════════╣",
        "║ \\v - Very magic mode (recommended)       ║",
        "║ \\d - Digit       \\s - Whitespace        ║",
        "║ \\w - Word char   \\< \\> - Word boundary  ║",
        "║ + - 1 or more    * - 0 or more           ║",
        "║ ? - 0 or 1       {n,m} - n to m times    ║",
        "║ [abc] - a,b, or c   [^abc] - not a,b,c   ║",
        "║ () - Group       | - Or                  ║",
        "╠═══════════════════════════════════════════╣",
        "║ Substitute flags:                         ║",
        "║ /g - All matches   /i - Case insensitive ║",
        "║ /c - Confirm each  /n - Report only      ║",
        "╚═══════════════════════════════════════════╝",
      }
      
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, help_text)
      vim.bo[buf].modifiable = false
      vim.bo[buf].filetype = "hypersonic-help"
      
      local width = 47
      local height = #help_text
      local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = "minimal",
        border = "rounded",
      })
      
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf })
      vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf })
    end, { desc = "Show Regex Help" })

    -- Add to keybind
    vim.keymap.set("n", "<leader>rh", "<cmd>RegexHelp<cr>", { desc = "Regex Help" })
  end,
}
