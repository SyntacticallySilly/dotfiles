-- SynVim Colorful Menu Plugin
-- Beautiful LSP completion menu

return {
  "xzbdmw/colorful-menu.nvim",
  dependencies = { "saghen/blink.cmp" },
  event = "InsertEnter",
  
  opts = {
    ls = {
      lua_ls = {
        arguments_hl = "@comment",
      },
      pyright = {
        extra_info_hl = "@comment",
      },
      fallback = true,
      fallback_extra_info_hl = "@comment",
    },
    fallback_highlight = "@variable",
    max_width = 0.4,  -- 40% of window width
  },
  
  config = function(_, opts)
    require("colorful-menu").setup(opts)
    
    -- Integrate with blink.cmp
    require("blink.cmp").setup({
      completion = {
        menu = {
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },
    })
  end,
}
