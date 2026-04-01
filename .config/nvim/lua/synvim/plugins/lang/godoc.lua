return {
  "fredrikaverpil/godoc.nvim",
  sem_version = "*",
  dependencies = {
    { "folke/snacks.nvim" },                                         -- optional
  },
  build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
  cmd = { "GoDoc" },                                                 -- optional
  ft = "godoc",                                                      -- optional
  lazy = true,
  opts = {},                                                         -- see further down below for configuration
}
