-- SynVim Mini.animate Plugin
-- Smooth animations for cursor, scroll, and resize

return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  
  opts = function()
    -- Don't animate in these cases for performance
    local mouse_scrolled = false
    for _, scroll in ipairs({ "Up", "Down" }) do
      local key = "<ScrollWheel" .. scroll .. ">"
      vim.keymap.set({ "", "i" }, key, function()
        mouse_scrolled = true
        return key
      end, { expr = true })
    end
    
    local animate = require("mini.animate")
    return {
      -- Cursor path animation
      cursor = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
        path = animate.gen_path.line({
          predicate = function()
            return true
          end,
        }),
      },
      
      -- Scroll animation
      scroll = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        subscroll = animate.gen_subscroll.equal({
          predicate = function(total_scroll)
            if mouse_scrolled then
              mouse_scrolled = false
              return false
            end
            return total_scroll > 1
          end,
        }),
      },
      
      -- Window resize animation
      resize = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
      },
      
      -- Disable open/close animations (can be laggy on Termux)
      open = { enable = false },
      close = { enable = false },
    }
  end,
}
