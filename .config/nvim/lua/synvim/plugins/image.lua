return {
  "3rd/image.nvim",
  build = false,
  ft = { "markdown", "vimwiki" }, -- lazy load on markdown filetypes
  opts = {
    backend = "sixel", -- or "ueberzug" or "sixel"
    processor = "magick_cli",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" },
      },
    },
  },
}
