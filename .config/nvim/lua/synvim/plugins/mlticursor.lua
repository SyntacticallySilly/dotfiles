return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  event = "VeryLazy",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    local set = vim.keymap.set

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Basic Cursor Addition
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    -- Add cursors above/below with Ctrl+j/k (more ergonomic than arrow keys)
    set({"n", "v"}, "<c-k>", function() mc.lineAddCursor(-1) end,
      { desc = "Add cursor above" })
    set({"n", "v"}, "<c-j>", function() mc.lineAddCursor(1) end,
      { desc = "Add cursor below" })

    -- Skip lines with leader
    set({"n", "v"}, "<leader>k", function() mc.lineSkipCursor(-1) end,
      { desc = "Skip cursor above" })
    set({"n", "v"}, "<leader>j", function() mc.lineSkipCursor(1) end,
      { desc = "Skip cursor below" })

    -- Match word/selection under cursor
    set({"n", "v"}, "<c-n>", function() mc.matchAddCursor(1) end,
      { desc = "Add cursor to next match" })
    set({"n", "v"}, "<c-p>", function() mc.matchAddCursor(-1) end,
      { desc = "Add cursor to prev match" })

    -- Skip matches
    set({"n", "v"}, "<leader>s", function() mc.matchSkipCursor(1) end,
      { desc = "Skip next match" })
    set({"n", "v"}, "<leader>S", function() mc.matchSkipCursor(-1) end,
      { desc = "Skip prev match" })

    -- Add all matches in document
    set({"n", "v"}, "<leader>A", mc.matchAllAddCursors,
      { desc = "Add cursors to all matches" })

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Mouse Support
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    set("n", "<c-leftmouse>", mc.handleMouse, { desc = "Toggle cursor with mouse" })
    set("n", "<c-leftdrag>", mc.handleMouseDrag)
    set("n", "<c-leftrelease>", mc.handleMouseRelease)

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Advanced Features
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    -- Add cursor to each line in text object (e.g., 'gaip' for paragraph)
    set("n", "ga", mc.addCursorOperator, { desc = "Add cursors by operator" })

    -- Split/match cursors by regex in visual mode
    set("v", "S", mc.splitCursors, { desc = "Split selections by regex" })
    set("v", "M", mc.matchCursors, { desc = "Match selections by regex" })

    -- Align cursor columns
    set("n", "<leader>a", mc.alignCursors, { desc = "Align cursor columns" })

    -- Transpose cursor selections
    set("v", "<leader>t", function() mc.transposeCursors(1) end,
      { desc = "Transpose selections forward" })
    set("v", "<leader>T", function() mc.transposeCursors(-1) end,
      { desc = "Transpose selections backward" })

    -- Append/insert for visual line selections
    set("v", "I", mc.insertVisual, { desc = "Insert at visual selections" })
    set("v", "A", mc.appendVisual, { desc = "Append at visual selections" })

    -- Restore accidentally cleared cursors
    set("n", "<leader>gv", mc.restoreCursors, { desc = "Restore cursors" })

    -- Clone and disable cursors
    set({"n", "v"}, "<leader><c-q>", mc.duplicateCursors,
      { desc = "Duplicate and disable cursors" })

    -- Toggle cursor disable
    set({"n", "v"}, "<c-q>", mc.toggleCursor, { desc = "Toggle cursor" })

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Multi-Cursor Mode Keymaps (only active with multiple cursors)
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    mc.addKeymapLayer(function(layerSet)
      -- Navigate between cursors with h/l
      layerSet({"n", "v"}, "H", mc.prevCursor, { desc = "Previous cursor" })
      layerSet({"n", "v"}, "L", mc.nextCursor, { desc = "Next cursor" })

      -- Delete current cursor
      layerSet({"n", "v"}, "<leader>x", mc.deleteCursor,
        { desc = "Delete cursor" })

      -- Clear/enable cursors with escape
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end, { desc = "Clear/enable cursors" })

      -- Quick access to common operations in multicursor mode
      layerSet("n", "q", mc.clearCursors, { desc = "Clear cursors" })
    end)

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Aesthetic Highlight Groups
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    local hl = vim.api.nvim_set_hl

    -- Active cursor: vibrant and noticeable
    hl(0, "MultiCursorCursor", {
      bg = "#89b4fa",
      fg = "#1e1e2e",
      bold = true
    })

    -- Visual selection: matches your theme's visual mode
    hl(0, "MultiCursorVisual", { link = "Visual" })

    -- Sign column indicator
    hl(0, "MultiCursorSign", {
      fg = "#89b4fa",
      bg = "NONE",
      bold = true
    })

    -- Match preview: subtle highlight for upcoming matches
    hl(0, "MultiCursorMatchPreview", {
      bg = "#313244",
      underline = true
    })

    -- Disabled cursor: dimmed but visible
    hl(0, "MultiCursorDisabledCursor", {
      bg = "#45475a",
      fg = "#6c7086"
    })

    hl(0, "MultiCursorDisabledVisual", {
      bg = "#313244",
      fg = "#6c7086"
    })

    hl(0, "MultiCursorDisabledSign", {
      fg = "#45475a",
      bg = "NONE"
    })
  end,
}
