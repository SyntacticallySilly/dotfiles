-- SynVim Statuscol Plugin
-- Beautiful and functional status column

return {
  "luukvbaal/statuscol.nvim",
  event = { "BufReadPost", "BufNewFile" },
  
  config = function()
    local builtin = require("statuscol.builtin")
    
    require("statuscol").setup({
      relculright = true, -- Place relative line numbers on right side
      segments = {
        -- Diagnostics/Signs column
        {
          sign = {
            namespace = { "diagnostic/signs" },
            maxwidth = 1,
            colwidth = 2,
            auto = false,
            fillchar = " ",
          },
          click = "v:lua.ScSa",
        },
        
        -- Line numbers
        {
          text = { builtin.lnumfunc, " " },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScLa",
        },
        
        -- Git signs (from gitsigns.nvim)
        {
          sign = {
            namespace = { "gitsigns" },
            maxwidth = 1,
            colwidth = 1,
            auto = false,
            fillchar = " ",
          },
          click = "v:lua.ScSa",
        },
        
        -- Fold column
        {
          text = { builtin.foldfunc, " " },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScFa",
        },
      },
      
      -- Clickable line numbers
      clickmod = "c", -- Ctrl+click
      clickhandlers = {
        Lnum = builtin.lnum_click,
        FoldClose = builtin.foldclose_click,
        FoldOpen = builtin.foldopen_click,
        FoldOther = builtin.foldother_click,
        DapBreakpointRejected = builtin.toggle_breakpoint,
        DapBreakpoint = builtin.toggle_breakpoint,
        DapBreakpointCondition = builtin.toggle_breakpoint,
        DiagnosticSignError = builtin.diagnostic_click,
        DiagnosticSignWarn = builtin.diagnostic_click,
        DiagnosticSignInfo = builtin.diagnostic_click,
        DiagnosticSignHint = builtin.diagnostic_click,
        GitSignsTopdelete = builtin.gitsigns_click,
        GitSignsUntracked = builtin.gitsigns_click,
        GitSignsAdd = builtin.gitsigns_click,
        GitSignsChange = builtin.gitsigns_click,
        GitSignsChangedelete = builtin.gitsigns_click,
        GitSignsDelete = builtin.gitsigns_click,
      },
    })
    
    -- Disable statuscol for specific filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        "TelescopePrompt",
      },
      callback = function()
        vim.opt_local.statuscolumn = ""
      end,
    })
  end,
}
