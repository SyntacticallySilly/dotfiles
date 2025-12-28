-- SynVim Twilight Plugin
-- Dims inactive code blocks for better focus

return {
  "folke/twilight.nvim",
  cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  keys = {
    { "<leader>ut", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
  },

  opts = {
    -- Dimming settings
    dimming = {
      alpha = 0.25, -- Amount of dimming (0 = no dim, 1 = fully dimmed)
      color = { "Normal", "#ffffff" }, -- Uses theme's Normal highlight
      term_bg = "#000000", -- For terminal backgrounds
      inactive = false, -- Dim inactive windows
    },

    -- Context settings (how much to keep visible)
    context = 10, -- Lines of context around cursor

    -- Treesitter integration
    treesitter = true, -- Use treesitter to understand code blocks

    -- Expand context based on syntax
    expand = {
      "function",
      "method",
      "table",
      "if_statement",
      "function_definition",
      "function_declaration",
      "class",
      "struct",
      "impl_item",
      "for_statement",
      "while_statement",
    },

    -- Exclude certain filetypes
    exclude = {
      "alpha",
      "dashboard",
      "neo-tree",
      "Trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
      "lazyterm",
      "TelescopePrompt",
      "help",
      "checkhealth",
    },
  },

  config = function(_, opts)
    require("twilight").setup(opts)

    -- Auto-enable Twilight when entering Zen mode (if you have it)
    vim.api.nvim_create_autocmd("User", {
      pattern = "ZenMode",
      callback = function()
        if vim.g.zen_mode_active then
          vim.cmd("Twilight")
        else
          vim.cmd("TwilightDisable")
        end
      end,
    })

    -- Optional: Dim on specific modes
    -- Uncomment to auto-enable when entering visual mode
    --[[
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "*:v",
      callback = function()
        vim.cmd("TwilightEnable")
      end,
    })
    
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "v:*",
      callback = function()
        vim.cmd("TwilightDisable")
      end,
    })
    ]]--
  end,
}
