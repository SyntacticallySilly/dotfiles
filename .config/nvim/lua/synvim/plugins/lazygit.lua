-- SynVim LazyGit Plugin
-- Robust Git TUI integration

return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>tg", "<cmd>LazyGit<cr>", desc = "LazyGit"}
  --   { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  --   { "<leader>gc", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
  --   { "<leader>gf", "<cmd>LazyGitFilter<cr>", desc = "LazyGit Filter" },
  },

  config = function()
    -- LazyGit configuration
    vim.g.lazygit_floating_window_winblend = 0 -- transparency
    vim.g.lazygit_floating_window_scaling_factor = 0.9 -- 90% of screen
    vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary for better window management
    vim.g.lazygit_use_neovim_remote = 1 -- allow lazygit to open files in current nvim instance

    -- Custom LazyGit config for Termux (if lazygit installed)
    local lazygit_config = vim.fn.expand("~/.config/lazygit/config.yml")

    -- Auto-create lazygit config if it doesn't exist
    if vim.fn.filereadable(lazygit_config) == 0 then
      local config_dir = vim.fn.expand("~/.config/lazygit")

      local config_content = [[
gui:
  theme:
    activeBorderColor:
      - '#89b4fa'
      - bold
    inactiveBorderColor:
      - '#45475a'
    searchingActiveBorderColor:
      - '#f9e2af'
      - bold
    selectedLineBgColor:
      - '#313244'
    selectedRangeBgColor:
      - '#313244'
  nerdFontsVersion: "3"
  showFileTree: true
  showRandomTip: false
  showCommandLog: false
  sidePanelWidth: 0.3333

git:
  paging:
    colorArg: always
    pager: delta --dark --paging=never

  merging:
    manualCommit: false
    args: ''

os:
  editPreset: 'nvim'

refresher:
  refreshInterval: 10
  fetchInterval: 60

update:
  method: never

notARepository: 'quit'
]]

      local file = io.open(lazygit_config, "w")
      if file then
        file:write(config_content)
        file:close()
      end
    end

    -- Autocmd to handle LazyGit better
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        if vim.fn.bufname("%"):match("lazygit") then
          vim.opt_local.signcolumn = "no"
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.foldcolumn = "0"
        end
      end,
    })

    -- Close lazygit on successful commit
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit*",
      callback = function()
        vim.cmd("checktime")
        vim.cmd("bdelete!")
      end,
    })
  end,
}
