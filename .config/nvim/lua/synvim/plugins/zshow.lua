return {
  'sairyy/zshow.nvim',
  cmd = "ZShow",
  init = function()
    vim.g.zshow_opts = {
      width = 0.8,  -- window width as a % of neovim's width
      height = 0.8, -- window height as a % of neovim's height

      formatting = {
        listchars = { ' ', '' }, -- characters to use in listings based on nesting level
        show_version = true, -- display git commit SHA
        short_sha = true, -- use short commit SHA if `show_version = true`
      },

      win_config = {
        zindex = 50,
        title = ' Plugins ',
        title_pos = 'center',
      },
    }
  end
}
