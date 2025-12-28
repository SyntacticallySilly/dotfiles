-- SynVim Markdown Plugin
-- Configurable markdown tools (tadmccorkle)

return {
  "tadmccorkle/markdown.nvim",
  ft = "markdown",

  opts = {
    mappings = {
      inline_surround_toggle = "gs",
      inline_surround_toggle_line = "gss",
      inline_surround_delete = "ds",
      inline_surround_change = "cs",
      link_add = "gl",
      link_follow = "gx",
      go_curr_heading = "]c",
      go_parent_heading = "]p",
      go_next_heading = "]]",
      go_prev_heading = "[[",
    },

    inline_surround = {
      emphasis = {
        key = "i",
        txt = "*",
      },
      strong = {
        key = "b",
        txt = "**",
      },
      strikethrough = {
        key = "s",
        txt = "~~",
      },
      code = {
        key = "c",
        txt = "`",
      },
    },

    link = {
      paste = {
        enable = true,  -- Convert URLs to links on paste
      },
    },

    toc = {
      omit_heading = "toc omit heading",
      omit_section = "toc omit section",
      markers = { "-" },
    },

    on_attach = function(bufnr)
      local map = vim.keymap.set
      local opts = { buffer = bufnr }

      -- Additional markdown keymaps
      map({ 'n', 'i' }, '<M-l><M-o>', '<Cmd>MDListItemBelow<CR>', opts)
      map({ 'n', 'i' }, '<M-L><M-O>', '<Cmd>MDListItemAbove<CR>', opts)
      map('n', '<M-c>', '<Cmd>MDTaskToggle<CR>', opts)
      map('x', '<M-c>', ':MDTaskToggle<CR>', opts)

      -- Visual mode shortcuts for bold/italic
      local function toggle(key)
        return "<Esc>gv<Cmd>lua require'markdown.inline'"
          .. ".toggle_emphasis_visual'" .. key .. "'<CR>"
      end

      map("x", "<C-b>", toggle("b"), opts)
      map("x", "<C-i>", toggle("i"), opts)
    end,
  },

  config = function(_, opts)
    require("markdown").setup(opts)
  end,
}
