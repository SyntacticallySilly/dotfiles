return {
  "qwavies/smart-backspace.nvim",
  event = {"InsertEnter", "CmdlineEnter"},
  opts = {
    enabled = true, -- enables/disables smart-backspace
    silent = true, -- if set to false, it will send a notification if smart-backspace is toggled
    disabled_filetypes = { -- filetypes to automatically disable smart-backspace
      "py",
      "hs",
      "md",
      "txt",
    }
  }
}
