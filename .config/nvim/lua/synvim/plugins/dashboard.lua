-- SynVim Dashboard Plugin
-- Modern startup screen with custom ASCII

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
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
      -- "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
      --             "Perfect Neovim for Termux",
      -- "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
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
        require("neo-tree.command").execute({
          dir = workspaces[1].path,
          position = "float",
        })
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
              require("neo-tree.command").execute({
                dir = selection.value.path,
                position = "left",
              })
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
            require("neo-tree.command").execute({
              toggle = true,
              position = "left",
            })
          end,
        },
        {
          icon = " ",
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
          icon = "󰺀 ",
          icon_hl = "DashboardIcon",
          desc = "Practice",
          desc_hl = "DashboardDesc",
          key = "p",
          key_hl = "DashboardKey",
          key_format = " [%s]",
          action = "VimBeGood",
        },
        {
          icon = " ",
          icon_hl = "DashboardIcon",
          desc = "Switch theme",
          desc_hl = "DashboardDesc",
          key = "t",
          key_hl = "DashboardKey",
          key_format = " [%s]",
          action = function()
            require("synvim.theme-switcher").switch_theme()
          end,
        },
        {
          icon = "󰢻 ",
          desc = "Config",
          desc_hl = "DashboardDesc",
          key = "c",
          key_hl = "DashboardKey",
          key_format = " [%s]",
          action = function()
            require("neo-tree.command").execute({
              dir = vim.fn.stdpath("config")
            })
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
        -- {
        --   icon = " ",
        --   icon_hl = "DashboardIcon",
        --   desc = "Mason (LSP)",
        --   desc_hl = "DashboardDesc",
        --   key = "m",
        --   key_hl = "DashboardKey",
        --   key_format = " [%s]",
        --   action = "Mason",
        -- },
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
      statusline = true,
      tabline = true,
      winbar = true,
    },
  })

  -- Custom Catppuccin Mocha colors
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "dashboard",
    callback = function()
      vim.b.miniindentscope_disable = true
      vim.b.minicursorword_disable = true
      vim.opt_local.colorcolumn = ""
    end,
  })
end,
}
