-- SynVim Alpha Plugin
-- Startup dashboard with SynVim logo

return {
  "goolord/alpha-nvim",
  lazy = false,
  priority = 1000,

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- SynVim ANSI Logo
    local logo = {
      " ███████ ██    ██ ███    ██ ██    ██ ██ ███    ███ ",
      " ██       ██  ██  ████   ██ ██    ██ ██ ████  ████ ",
      " ███████   ████   ██ ██  ██ ██    ██ ██ ██ ████ ██ ",
      "      ██    ██    ██  ██ ██  ██  ██  ██ ██  ██  ██ ",
      " ███████    ██    ██   ████   ████   ██ ██      ██ ",
      "",
    }

    dashboard.section.header.val = logo

    -- Helper function to handle Obsidian vault selection
    local function open_obsidian_vault()
      local ok_obsidian, obsidian = pcall(require, "obsidian")
      if not ok_obsidian then
        vim.notify("Obsidian not installed", vim.log.levels.ERROR)
        return
      end

      local client = obsidian.get_client()
      local workspaces = client.opts.workspaces

      if #workspaces == 1 then
        -- Only one vault, open file browser in that path
        vim.cmd("Telescope file_browser path=" .. workspaces[1].path)
      else
        -- Multiple vaults, show Telescope picker
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local conf = require("telescope.config").values

        pickers.new({}, {
          prompt_title = "Select Obsidian Vault",
          finder = finders.new_table({
            results = workspaces,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry.name,
                ordinal = entry.name,
              }
            end,
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              vim.cmd("Telescope file_browser path=" .. selection.value.path)
            end)
            return true
          end,
        }):find()
      end
    end

    -- Menu buttons
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find files", ":Telescope find_files<CR>"),
      dashboard.button("n", "  New file", ":enew<CR>"),
      dashboard.button("e", "  File Explorer", ":Telescope file_browser<CR>"),
      dashboard.button("o", "  Obsidian vault", open_obsidian_vault),
      dashboard.button("p", "  Practice", ":VimBeGood<CR>"),
      dashboard.button("c", "  Config", ":Telescope file_browser path=" .. vim.fn.stdpath("config") .. "<CR>"),
      dashboard.button("l", "  Lazy", ":Lazy<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    -- Footer
    dashboard.section.footer.val = { "SynVim - Perfect Neovim for Termux" }

    dashboard.config.opts.noautocmd = true

    alpha.setup(dashboard.config)
  end,
}
