-- SynVim SchemaStore plugin
-- JSON/TOML/YAML schemas with lazy loading

return {
  "b0o/SchemaStore.nvim",
  -- Only load when these filetypes are opened
  ft = { "json", "jsonc", "toml", "yaml", "yml" },
}
