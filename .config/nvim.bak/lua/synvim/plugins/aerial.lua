-- SynVim Aerial Plugin
-- Code outline window with LSP + Treesitter support

return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = {
    "AerialToggle",
    "AerialOpen",
    "AerialClose",
    "AerialNav",
  },
  keys = {
    { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Toggle Aerial" },
    { "<leader>A", "<cmd>AerialNavToggle<cr>", desc = "Aerial Nav" },
    { "[a", "<cmd>AerialPrev<cr>", desc = "Prev Symbol" },
    { "]a", "<cmd>AerialNext<cr>", desc = "Next Symbol" },
  },

  opts = {
    -- Backends (priority order)
    backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },

    -- Layout settings
    layout = {
      max_width = { 40, 0.3 }, -- 40 cols or 30% of window
      width = nil, -- Auto-size
      min_width = 25,
      default_direction = "right", -- or "prefer_left", "right", "left", "float"
      placement = "edge", -- "window" or "edge"
      resize_to_content = true,
      preserve_equality = false,
    },

    -- Attach mode
    attach_mode = "window", -- "window", "global"

    -- Close aerial on select
    close_on_select = false,

    -- Keymaps in aerial window
    keymaps = {
      ["?"] = "actions.show_help",
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.jump",
      ["<2-LeftMouse>"] = "actions.jump",
      ["<C-v>"] = "actions.jump_vsplit",
      ["<C-s>"] = "actions.jump_split",
      ["p"] = "actions.scroll",
      ["<C-j>"] = "actions.down_and_scroll",
      ["<C-k>"] = "actions.up_and_scroll",
      ["{"] = "actions.prev",
      ["}"] = "actions.next",
      ["[["] = "actions.prev_up",
      ["]]"] = "actions.next_up",
      ["q"] = "actions.close",
      ["o"] = "actions.tree_toggle",
      ["za"] = "actions.tree_toggle",
      ["O"] = "actions.tree_toggle_recursive",
      ["zA"] = "actions.tree_toggle_recursive",
      ["l"] = "actions.tree_open",
      ["zo"] = "actions.tree_open",
      ["L"] = "actions.tree_open_recursive",
      ["zO"] = "actions.tree_open_recursive",
      ["h"] = "actions.tree_close",
      ["zc"] = "actions.tree_close",
      ["H"] = "actions.tree_close_recursive",
      ["zC"] = "actions.tree_close_recursive",
      ["zr"] = "actions.tree_increase_fold_level",
      ["zR"] = "actions.tree_open_all",
      ["zm"] = "actions.tree_decrease_fold_level",
      ["zM"] = "actions.tree_close_all",
      ["zx"] = "actions.tree_sync_folds",
      ["zX"] = "actions.tree_sync_folds",
    },

    -- Lazy loading symbols (performance optimization)
    lazy_load = true,

    -- Disable on large buffers (performance)
    disable_max_lines = 10000,
    disable_max_size = 2000000, -- 2MB

    -- Filter symbols
    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Module",
      "Method",
      "Struct",
      "Trait",
      "Field",
      "Property",
    },

    -- Highlight settings
    highlight_mode = "split_width", -- "split_width", "full_width", "last", "none"
    highlight_closest = true,
    highlight_on_hover = false,
    highlight_on_jump = 300, -- ms

    -- Fold code when navigating
    autojump = false,

    -- Icons
    icons = {
      Array = " ",
      Boolean = "󰨙 ",
      Class = " ",
      Constant = " ",
      Constructor = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Function = "󰊕 ",
      Interface = " ",
      Key = " ",
      Method = "󰊕 ",
      Module = " ",
      Namespace = "󰦮 ",
      Null = " ",
      Number = "󰎠 ",
      Object = " ",
      Operator = " ",
      Package = " ",
      Property = " ",
      String = " ",
      Struct = " ",
      TypeParameter = " ",
      Variable = "󰀫 ",
    },

    -- Show box around symbols (beautiful borders)
    show_guides = true,
    guides = {
      mid_item = "├─",
      last_item = "└─",
      nested_top = "│ ",
      whitespace = "  ",
    },

    -- Floating window settings (for AerialNav)
    float = {
      border = "rounded",
      relative = "cursor",
      max_height = 0.9,
      height = nil,
      min_height = { 8, 0.1 },
      override = function(conf, source_winid)
        return conf
      end,
    },

    -- AerialNav settings (miller column view)
    nav = {
      border = "rounded",
      max_height = 0.9,
      min_height = { 10, 0.1 },
      max_width = 0.5,
      min_width = { 0.2, 20 },
      win_opts = {
        cursorline = true,
        winblend = 0,
      },
      autojump = false,
      preview = false,
      keymaps = {
        ["<CR>"] = "actions.jump",
        ["<2-LeftMouse>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-s>"] = "actions.jump_split",
        ["h"] = "actions.left",
        ["l"] = "actions.right",
        ["<C-c>"] = "actions.close",
        ["q"] = "actions.close",
      },
    },

    -- LSP priority (when multiple servers provide symbols)
    lsp = {
      diagnostics_trigger_update = true,
      update_when_errors = true,
      update_delay = 300, -- ms
      priority = {
        rust_analyzer = 10,
        lua_ls = 9,
        gopls = 9,
        jdtls = 9,
        clangd = 9,
      },
    },

    -- Treesitter extensions
    treesitter = {
      update_delay = 300, -- ms
    },

    -- Markdown configuration
    markdown = {
      update_delay = 300,
    },

    -- Auto-open aerial
    open_automatic = false,

    -- Close behavior
    close_automatic_events = {},

    -- Post parse symbol hook (for customization)
    post_parse_symbol = function(bufnr, item, ctx)
      return true
    end,

    -- Post add all symbols hook
    post_add_all_symbols = function(bufnr, items, ctx)
      return items
    end,

    -- On attach callback
    on_attach = function(bufnr)
      -- Buffer-local keymaps
      vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", {
        buffer = bufnr,
        desc = "Aerial Prev",
      })
      vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", {
        buffer = bufnr,
        desc = "Aerial Next",
      })
    end,

    -- On first symbols callback
    on_first_symbols = function(bufnr)
      -- Optional: auto-open on first symbols
      -- require("aerial").open()
    end,
  },

  config = function(_, opts)
    require("aerial").setup(opts)


    -- Telescope integration
    pcall(require("telescope").load_extension, "aerial")

    -- Optional: Add to lualine
    -- In your lualine config, add to sections:
    -- sections = {
    --   lualine_x = { "aerial" },
    -- }
  end,
}
