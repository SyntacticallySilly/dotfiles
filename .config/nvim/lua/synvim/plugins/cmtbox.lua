return {
  "LudoPinelli/comment-box.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cond = function()
    -- Calculate comment percentage in current buffer
    local function get_comment_percentage()
      local buf = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local total_lines = #lines
      
      if total_lines == 0 then return 0 end
      
      -- Get comment string for current filetype
      local commentstring = vim.bo[buf].commentstring
      if not commentstring or commentstring == "" then return 0 end
      
      -- Extract comment pattern (remove %s placeholder)
      local comment_pattern = commentstring:gsub("%%s.*", ""):gsub("%s+$", "")
      comment_pattern = vim.pesc(comment_pattern) -- Escape special chars
      
      local comment_lines = 0
      for _, line in ipairs(lines) do
        local trimmed = line:match("^%s*(.-)%s*$")
        if trimmed ~= "" and trimmed:match("^" .. comment_pattern) then
          comment_lines = comment_lines + 1
        end
      end
      
      return (comment_lines / total_lines) * 100
    end
    
    -- Defer calculation to allow filetype detection
    vim.defer_fn(function()
      local percentage = get_comment_percentage()
      if percentage >= 30 then
        require("lazy").load({ plugins = { "comment-box.nvim" } })
      end
    end, 50)
    
    return false -- Don't load immediately
  end,
  keys = {
    { "<Leader>cb", "<Cmd>CBccbox<CR>", mode = { "n", "v" }, desc = "Comment box" },
  },
  opts = {},
}
