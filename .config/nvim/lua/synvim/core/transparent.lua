-- SynVim Transparent Backgrounds
-- Make all floating windows and UI elements transparent

local M = {}

M.setup = function()
  -- Set transparency for common highlight groups
  local transparent_groups = {
    "Normal",
    "NormalFloat",
    "FloatBorder",
    "WhichKeyFloat",
    "BarbequeNormalNC",
    "BarbequeNormal",
    "NvimTreeNormal",
    "NvimTreeNormalNC",
    "BufferLineFill",
    "LualineC",
    "LualineY",
  }

  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
  end
end

return M
