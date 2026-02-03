-- SynVim Conform Plugin
-- Modern formatter that handles indentation properly

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  
  opts = {
    formatters_by_ft = {
      python = { "black", "isort" },  -- Add Python formatters
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      rust = { "rustfmt" },
      go = { "gofmt" },
      ["*"] = { "trim_whitespace" },
    },
    
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { 
        timeout_ms = 500, 
        lsp_fallback = true,
      }
    end,
    
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  
  init = function()
    vim.api.nvim_create_user_command("FormatToggle", function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      if vim.g.disable_autoformat then
        vim.notify("Format on save disabled", vim.log.levels.INFO)
      else
        vim.notify("Format on save enabled", vim.log.levels.INFO)
      end
    end, { desc = "Toggle format on save" })
  end,
}
