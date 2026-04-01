local M = {}

local uv = vim.uv or vim.loop

local function zpack_counts()
  local ok, state = pcall(require, "zpack.state")
  if not ok then
    return 0, 0, 0
  end

  local total = 0
  local lazy = 0

  for _, name in ipairs(state.registered_plugin_names or {}) do
    if name ~= "zpack.nvim" then
      total = total + 1
    end
  end

  for name, unloaded in pairs(state.unloaded_plugin_names or {}) do
    if unloaded and name ~= "zpack.nvim" then
      lazy = lazy + 1
    end
  end

  return total, math.max(total - lazy, 0), lazy
end

function M.capture()
  local start = vim.g.synvim_start_time
  if type(start) ~= "number" then
    return nil
  end

  local total, loaded, lazy = zpack_counts()
  local stats = {
    elapsed_ms = (uv.hrtime() - start) / 1e6,
    total = total,
    loaded = loaded,
    lazy = lazy,
  }

  local ok, loader = pcall(require, "zpack.module_loader")
  if ok and type(loader.get_profile) == "function" then
    local profile = loader.get_profile()
    stats.loader_ms = (profile.total_time or 0) * 1000
  end

  vim.g.synvim_startup_stats = stats
  return stats
end

function M.get()
  return vim.g.synvim_startup_stats or M.capture()
end

function M.format()
  local stats = M.get()
  if not stats then
    return " Startup stats unavailable"
  end

  return (" %d/%d plugins loaded in %.2f ms"):format(stats.loaded, stats.total, stats.elapsed_ms)
end

function M.dashboard_item()
  return {
    align = "center",
    text = {
      { M.format(), hl = "footer" },
    },
  }
end

function M.setup()
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
      M.capture()

      vim.schedule(function()
        pcall(function()
          require("snacks").dashboard.update()
        end)
      end)
    end,
  })
end

return M
