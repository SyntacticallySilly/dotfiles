-- SynVim Dashboard Plugin
-- Modern startup screen with custom ASCII

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  -- enabled = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local db = require("dashboard")

    -- Custom SynVim ASCII logo
    local logo = {
      "                                                                        ",
      "  █████████                        █████   █████  ███                  ",
      " ███░░░░░███                      ░░███   ░░███  ░░░                   ",
      "░███    ░░░  █████ ████ ████████   ░███    ░███  ████  █████████████  ",
      "░░█████████ ░░███ ░███ ░░███░░███  ░███    ░███ ░░███ ░░███░░███░░███ ",
      " ░░░░░░░░███ ░███ ░███  ░███ ░███  ░░███   ███   ░███  ░███ ░███ ░███ ",
      " ███    ░███ ░███ ░███  ░███ ░███   ░░░█████░    ░███  ░███ ░███ ░███ ",
      "░░█████████  ░░███████  ████ █████    ░░███      █████ █████░███ █████",
      " ░░░░░░░░░    ░░░░░███ ░░░░ ░░░░░      ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ ",
      "              ███ ░███                                                 ",
      "             ░░██████                                                  ",
      "              ░░░░░░                                                   ",
      "                                                                        ",
    }

    -- Obsidian vault picker
    local function open_obsidian_vault()
      local ok_obsidian, obsidian = pcall(require, "obsidian")
      if not ok_obsidian then
        vim.notify("Obsidian not installed", vim.log.levels.ERROR)
        return
      end

      local client = obsidian.get_client()
      local workspaces = client.opts.workspaces

      if #workspaces == 1 then
        require("mini.files").open(workspaces[1].path, true)
      else
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local conf = require("telescope.config").values

        pickers
          .new({}, {
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
                require("mini.files").open(selection.value.path, true)
              end)
              return true
            end,
          })
          :find()
      end
    end

    db.setup({
      theme = "doom",
      config = {
        header = logo,
        center = {
          {
            icon = "󰮗 ",
            icon_hl = "DashboardIcon",
            desc = "Find files",
            desc_hl = "DashboardDesc",
            key = "f",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = "Telescope find_files",
          },
          {
            icon = "󱎝 ",
            icon_hl = "DashboardIcon",
            desc = "Recent files",
            desc_hl = "DashboardDesc",
            key = "r",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = "Telescope oldfiles",
          },
          {
            icon = "󰉖 ",
            icon_hl = "DashboardIcon",
            desc = "File Explorer",
            desc_hl = "DashboardDesc",
            key = "e",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = function()
              require("mini.files").open(vim.loop.cwd(), true)
            end,
          },
          {
            icon = "󱎸 ",
            icon_hl = "DashboardIcon",
            desc = "Find text",
            desc_hl = "DashboardDesc",
            key = "g",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = "Telescope live_grep",
          },
          {
            icon = "󰺿 ",
            icon_hl = "DashboardIcon",
            desc = "Obsidian vault",
            desc_hl = "DashboardDesc",
            key = "o",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = open_obsidian_vault,
          },
          {
            icon = "󰢻 ",
            desc = "Config",
            desc_hl = "DashboardDesc",
            key = "c",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = function()
              require("mini.files").open(vim.fn.stdpath("config"), true)
            end,
          },
          {
            icon = "󰒲 ",
            icon_hl = "DashboardIcon",
            desc = "Lazy (Plugins)",
            desc_hl = "DashboardDesc",
            key = "l",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = "Lazy",
          },
          {
            icon = "󰋕 ",
            icon_hl = "DashboardIcon",
            desc = "Check health",
            desc_hl = "DashboardDesc",
            key = "h",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = "checkhealth",
          },
          {
            icon = "󰩈 ",
            icon_hl = "DashboardIcon",
            desc = "Quit",
            desc_hl = "DashboardDesc",
            key = "q",
            key_hl = "DashboardKey",
            key_format = " [%s]",
            action = "qa",
          },
        },
        footer = function()
          local ok_lazy, lazy = pcall(require, "lazy")
          if not ok_lazy then
            return { "SYNVIM - Perfect Neovim for Termux" }
          end

          local stats = lazy.stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

          return {
            "",
            "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
            "Neovim loaded " .. stats.loaded .. " plugins in " .. ms .. "ms",
            "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
          }
        end,
      },
      hide = {
        tabline = true,
        winbar = true,
      },
    })

    -- Custom Catppuccin Mocha colors
  end,
}
