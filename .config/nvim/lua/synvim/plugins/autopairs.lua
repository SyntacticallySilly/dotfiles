-- SynVim Autopairs Plugin
-- Auto-close brackets, quotes, and more

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  
  opts = {
    check_ts = true,  -- Use treesitter for better pair detection
    ts_config = {
      lua = { "string" },  -- Don't add pairs in lua string treesitter nodes
      javascript = { "template_string" },
    },
    disable_filetype = { "TelescopePrompt", "vim" },
    fast_wrap = {
      map = "<M-e>",  -- Alt+e to fast wrap
      chars = { "{", "[", "(", '"', "'" },
      pattern = [=[[%'%"%>%]%)%}%,]]=],
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "Search",
      highlight_grey = "Comment",
    },
  },
  
  config = function(_, opts)
    local autopairs = require("nvim-autopairs")
    autopairs.setup(opts)
    
    -- Integration with nvim-cmp
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
