return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    -- Mini.icons - Replaces nvim-web-devicons
    require("mini.icons").setup({
      style = "glyph", -- 'glyph' or 'ascii'
      default = {},
      directory = {},
      extension = {},
      file = {},
      filetype = {},
      lsp = {},
      os = {},
    })
    -- Mock nvim-web-devicons for compatibility with other plugins
    MiniIcons.mock_nvim_web_devicons()

    -- Mini.ai - Enhanced text objects
    require("mini.ai").setup({
      mappings = {
        around = "a",
        inside = "i",
        around_next = "gan",
        inside_next = "gin",
        around_last = "gal",
        inside_last = "gil",
        goto_left = "g[",
        goto_right = "g]",
      },
      n_lines = 500,
      search_method = "cover_or_next",
      custom_textobjects = nil,
    })

    -- Mini.bracketed - Bracket navigation
    require("mini.bracketed").setup({
      buffer     = { suffix = "b", options = {} },
      comment    = { suffix = "c", options = {} },
      conflict   = { suffix = "x", options = {} },
      diagnostic = { suffix = "d", options = {} },
      file       = { suffix = "f", options = {} },
      indent     = { suffix = "i", options = {} },
      jump       = { suffix = "j", options = {} },
      location   = { suffix = "l", options = {} },
      oldfile    = { suffix = "o", options = {} },
      quickfix   = { suffix = "q", options = {} },
      treesitter = { suffix = "t", options = {} },
      undo       = { suffix = "u", options = {} },
      window     = { suffix = "w", options = {} },
      yank       = { suffix = "y", options = {} },
    })

    -- Mini.pairs - Replaces autopairs
    require("mini.pairs").setup({
      modes = { insert = true, command = false, terminal = false },
      mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
        ["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\]." },
        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
        [">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\]." },
        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
      },
    })

    -- Mini.comment - Replaces comments
    require("mini.comment").setup({
      options = {
        custom_commentstring = nil,
        ignore_blank_line = false,
        start_of_line = false,
        pad_comment_parts = true,
      },
      mappings = {
        comment = "gc",
        comment_line = "gcc",
        comment_visual = "gc",
        textobject = "gc",
      },
    })

    -- Mini.surround - Replaces surround
    require("mini.surround").setup({
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
      n_lines = 20,
      search_method = "cover_or_next",
    })

    -- Mini.cursorword - Highlight word under cursor
    -- require("mini.cursorword").setup({
    --   delay = 100,
    -- })

    -- Disable cursorword for certain filetypes
    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = {
    --     "help",
    --     "alpha",
    --     "dashboard",
    --     "neo-tree",
    --     "Trouble",
    --     "lazy",
    --     "mason",
    --     "notify",
    --     "toggleterm",
    --     "lazyterm",
    --     "TelescopePrompt",
    --   },
    --   callback = function()
    --     vim.b.minicursorword_disable = true
    --   end,
  end,
}
