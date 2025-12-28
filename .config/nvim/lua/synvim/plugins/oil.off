-- SynVim Oil Plugin
-- Beautiful file explorer with barbecue breadcrumbs and smart window behavior

return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "refractalize/oil-git-status.nvim",
  },
  cmd = "Oil",
  keys = {
    {
      "<leader>e",
      function()
        -- Smart open: sidebar if buffer exists, floating if not
        local oil = require("oil")

        -- Check if there's an actual buffer open
        local has_real_buffer = false
        local special_filetypes = {
          "oil", "alpha", "dashboard", "neo-tree", "Trouble",
          "lazy", "mason", "notify", "toggleterm", "TelescopePrompt", "",
        }

        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          local bt = vim.bo[buf].buftype

          if bt == "" and not vim.tbl_contains(special_filetypes, ft) then
            has_real_buffer = true
            break
          end
        end

        if has_real_buffer then
          -- Open in slimmer sidebar (35 columns) on the RIGHT
          vim.cmd("vsplit")
          vim.cmd("wincmd L")  -- Move to far right instead of left
          vim.api.nvim_win_set_width(0, 35)

          -- Add rounded border to the sidebar
          vim.wo.winhl = "Normal:Normal,FloatBorder:FloatBorder"
          vim.wo.fillchars = "vert:┊,horiz:─,horizup:┴,horizdown:┬,vertleft:┤,vertright:├,verthoriz:┼"

          oil.open()
        else
          -- Open in floating window
          oil.open_float()
        end
      end,
      desc = "Oil (Smart)",
    },
    {
      "<leader>E",
      function()
        require("oil").open_float()
      end,
      desc = "Oil (Float)",
    },
    {
      "<leader>ui",
      function()
        -- Toggle detailed info (permissions, size, mtime)
        local oil = require("oil")
        local config = require("oil.config")

        if vim.g.oil_detailed_view then
          -- Switch to simple view (no icon)
          config.columns = { "icons" }
          vim.g.oil_detailed_view = false
        else
          -- Switch to detailed view
          config.columns = { "permissions", "size", "mtime" }
          vim.g.oil_detailed_view = true
        end

        -- Refresh to apply changes
        oil.discard_all_changes()
      end,
      desc = "Toggle Oil Details",
    },
  },

  opts = {
    -- Columns to display (no icon column - removed emojis)
    columns = { "icon" },

    -- Buffer options
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },

    -- Window options
    win_options = {
      wrap = false,
      signcolumn = "yes:2",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
      number = false,
      relativenumber = false,
    },

    -- Default file explorer
    default_file_explorer = true,
    restore_win_options = true,
    skip_confirm_for_simple_edits = true,
    delete_to_trash = false,
    prompt_save_on_select_new_entry = true,

    -- Keymaps in oil buffer
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open vertical split" },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open horizontal split" },
      ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in tab" },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = "cd to tab" },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
      ["q"] = "actions.close",
      ["<Esc>"] = "actions.close",

      -- Toggle detailed view with 'gd' (no notifications)
      ["gd"] = {
        callback = function()
          local oil = require("oil")
          local config = require("oil.config")

          if vim.g.oil_detailed_view then
            config.columns = { "icon" }
            vim.g.oil_detailed_view = false
          else
            config.columns = { "permissions", "size", "mtime" }
            vim.g.oil_detailed_view = true
          end

          oil.discard_all_changes()
        end,
        desc = "Toggle details",
      },
    },

    use_default_keymaps = true,
    watch_for_changes = true,

    -- View options
    view_options = {
      show_hidden = false,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, ".")
      end,
      is_always_hidden = function(name, bufnr)
        return false
      end,
    },

    -- Floating window (larger for better usability)
    float = {
      padding = 2,
      max_width = 100,
      max_height = 35,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },

    -- Preview window
    preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = 0.9,
      min_height = { 5, 0.1 },
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      update_on_cursor_moved = true,
    },

    progress = {
      max_filename_length = 0,
      minimized_progress_notification = false,
    },

    ssh = {
      border = "rounded",
    },

    constrain_cursor = "editable",
    experimental_watch_for_changes = false,

    keymaps_help = {
      border = "rounded",
    },
  },

  config = function(_, opts)
    require("oil").setup(opts)

    -- Initialize detailed view state
    vim.g.oil_detailed_view = false

    -- Git integration setup (with error handling)
    local git_status_ok, git_status = pcall(require, "oil-git-status")
    if git_status_ok then
      local status_ok, status_const = pcall(require, "oil-git-status.status")
      if status_ok then
        local StatusType = status_const.StatusType
        git_status.setup({
          show_ignored = false,
          symbols = {
            [StatusType.Added] = " ",
            [StatusType.Copied] = " ",
            [StatusType.Deleted] = " ",
            [StatusType.Ignored] = " ",
            [StatusType.Modified] = " ",
            [StatusType.Renamed] = " ",
            [StatusType.TypeChanged] = " ",
            [StatusType.Unmodified] = " ",
            [StatusType.Unmerged] = " ",
            [StatusType.Untracked] = "󰴠 ",
            [StatusType.External] = " ",
          },
        })

        -- Git status highlights
        vim.api.nvim_set_hl(0, "OilGitStatusAdded", { fg = "#a6e3a1", bold = true })
        vim.api.nvim_set_hl(0, "OilGitStatusModified", { fg = "#f9e2af", bold = true })
        vim.api.nvim_set_hl(0, "OilGitStatusDeleted", { fg = "#f38ba8", bold = true })
        vim.api.nvim_set_hl(0, "OilGitStatusUntracked", { fg = "#89dceb" })
        vim.api.nvim_set_hl(0, "OilGitStatusIgnored", { fg = "#6c7086" })
      end
    end

    -- Configure barbecue to show directory path in oil buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        -- Enable barbecue for oil buffers
        local barbecue_ok, barbecue = pcall(require, "barbecue.ui")
        if barbecue_ok then
          barbecue.toggle(true)
        end

        -- Custom refresh keymap (no notification spam)
        vim.keymap.set("n", "<C-r>", function()
          require("oil.actions").refresh.callback()
        end, { buffer = true, desc = "Refresh Oil" })
      end,
    })

    -- Removed OilEnter notification to prevent spam
  end,
}
