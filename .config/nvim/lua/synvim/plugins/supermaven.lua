return {
  "supermaven-inc/supermaven-nvim",
  cmd = "SupermavenToggle",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-y>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = { cpp = true }, -- or { "cpp", }
      color = {
        suggestion_color = "#ffffff",
        cterm = 244,
      },
      log_level = "info",                -- set to "off" to disable logging completely
      disable_inline_completion = false, -- disables inline completion for use with cmp
    })
  end,
}
