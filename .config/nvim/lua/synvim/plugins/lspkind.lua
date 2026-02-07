-- SynVim lspkind Plugin
-- VSCode-like icons in completion menu

return {
  "onsails/lspkind.nvim",
  event = "InsertEnter",

  config = function()
    local lspkind = require("lspkind")

    lspkind.init({
      mode = "symbol_text",  -- Show icon + text
      preset = "default",

      symbol_map = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "󰶱",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "󰕳",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "󰼢",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      },
    })
  end,
}
