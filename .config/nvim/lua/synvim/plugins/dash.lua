-- SynVim Dashboard Plugin
-- Modern startup screen with custom ASCII

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  -- enabled = false,
  dependencies = { "nvim-mini/mini.icons" },

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
            return { "SynVim - Perfect Neovim for Termux" }
          end

          local stats = lazy.stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

          return {
            "Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            "Todos : Ask ai to make a floating terminal impl to remove Fterm.",
          }
        end,
      },
      hide = {
        tabline = true,
        winbar = true,
        statusline = false,
      },
    })
  end,
}
