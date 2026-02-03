-- ~/.config/nvim/lua/plugins/neogit.lua

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- Required
    "sindrets/diffview.nvim",        -- Diff integration
    "nvim-telescope/telescope.nvim", -- Fuzzy finder integration
  },
  cmd = "Neogit",                    -- Lazy load on command
  keys = {
    -- Lazy load on keybindings
    { "<leader>gg", function() require("neogit").open() end, desc = "󰊢 Neogit Status" },
    { "<leader>gc", function() require("neogit").open({ "commit" }) end, desc = " Neogit Commit" },
    { "<leader>gp", function() require("neogit").open({ "push" }) end, desc = " Neogit Push" },
    { "<leader>gl", function() require("neogit").open({ "pull" }) end, desc = " Neogit Pull" },
    { "<leader>gB", function() require("neogit").open({ "branch" }) end, desc = " Neogit Branch" },
    { "<leader>gd", function() require("neogit").open({ "diff" }) end, desc = " Neogit Diff" },
    { "<leader>gS", function() require("neogit").open({ "stash" }) end, desc = "󰆓 Neogit Stash" },
    { "<leader>gr", function() require("neogit").open({ "rebase" }) end, desc = " Neogit Rebase" },
    { "<leader>gm", function() require("neogit").open({ "merge" }) end, desc = " Neogit Merge" },
    { "<leader>gf", function() require("neogit").open({ "fetch" }) end, desc = "󰇚 Neogit Fetch" },
    { "<leader>gL", function() require("neogit").open({ "log" }) end, desc = " Neogit Log" },
    { "<leader>gR", function() require("neogit").open({ "reset" }) end, desc = "󰜉 Neogit Reset" },
    { "<leader>gC", function() require("neogit").open({ "cherry_pick" }) end, desc = " Neogit Cherry Pick" },
    { "<leader>gw", function() require("neogit").open({ "worktree" }) end, desc = " Neogit Worktree" },
  },
  opts = {
    -- ╭──────────────────────────────────────────────────────────╮
    -- │                    Core Settings                         │
    -- ╰──────────────────────────────────────────────────────────╯
    kind = "tab",                  -- "tab", "split", "vsplit", "floating", "replace", "auto"
    disable_hint = false,
    disable_context_highlighting = false,
    disable_signs = false,
    disable_commit_confirmation = false,
    disable_insert_on_commit = "auto", -- "auto", true, false

    -- Filewatcher settings (performance critical)
    filewatcher = {
      interval = 1000,             -- Check every second
      enabled = true,
    },

    -- Graph style for log view
    graph_style = "unicode",       -- "ascii", "unicode"

    -- Remember window settings
    remember_settings = true,

    -- Auto refresh on focus
    auto_refresh = true,

    -- Sort branches
    sort_branches = "-committerdate",

    -- Notification settings (performance)
    notification_icon = "󰊢",

    -- Use telescope for selections
    use_default_keymaps = true,

    -- Auto show console on error only
    auto_show_console = true,
    console_timeout = 2000,

    -- Status buffer behavior
    status = {
      recent_commit_count = 10,
      HEAD_padding = 10,
      HEAD_folded = false,
      mode_padding = 3,
      mode_text = {
        M = "modified",
        N = "new file",
        A = "added",
        D = "deleted",
        C = "copied",
        U = "updated",
        R = "renamed",
        DD = "unmerged",
        AU = "unmerged",
        UD = "unmerged",
        UA = "unmerged",
        DU = "unmerged",
        AA = "unmerged",
        UU = "unmerged",
        ["?"] = "untracked",
      },
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                   Commit Editor                          │
    -- ╰──────────────────────────────────────────────────────────╯
    commit_editor = {
      kind = "tab",
      show_staged_diff = true,
      staged_diff_split_kind = "vsplit",  -- "split", "vsplit", "auto"
      spell_check = true,
    },

    commit_select_view = {
      kind = "tab",
    },

    commit_view = {
      kind = "vsplit",
      verify_commit = vim.fn.executable("gpg") == 1,
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                   Log View Settings                      │
    -- ╰──────────────────────────────────────────────────────────╯
    log_view = {
      kind = "tab",
    },

    rebase_editor = {
      kind = "auto",
    },

    reflog_view = {
      kind = "tab",
    },

    merge_editor = {
      kind = "auto",
    },

    description_editor = {
      kind = "auto",
    },

    tag_editor = {
      kind = "auto",
    },

    preview_buffer = {
      kind = "floating",
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                   Popup Settings                         │
    -- ╰──────────────────────────────────────────────────────────╯
    popup = {
      kind = "split",
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                      Git Signs                           │
    -- ╰──────────────────────────────────────────────────────────╯
    signs = {
      hunk = { "", "" },
      item = { "", "" },
      section = { "", "" },
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                    Integrations                          │
    -- ╰──────────────────────────────────────────────────────────╯
    integrations = {
      telescope = true,
      diffview = true,
      fzf_lua = false,             -- Set to true if you prefer fzf-lua
      mini_pick = false,
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                     Sections                             │
    -- ╰──────────────────────────────────────────────────────────╯
    sections = {
      -- Upstream / Downstream sections
      untracked = {
        folded = false,
        hidden = false,
      },
      unstaged = {
        folded = false,
        hidden = false,
      },
      staged = {
        folded = false,
        hidden = false,
      },
      stashes = {
        folded = true,
        hidden = false,
      },
      unpulled_upstream = {
        folded = true,
        hidden = false,
      },
      unmerged_upstream = {
        folded = false,
        hidden = false,
      },
      unpulled_pushRemote = {
        folded = true,
        hidden = false,
      },
      unmerged_pushRemote = {
        folded = false,
        hidden = false,
      },
      recent = {
        folded = true,
        hidden = false,
      },
      rebase = {
        folded = true,
        hidden = false,
      },
      sequencer = {
        folded = false,
        hidden = false,
      },
      bisect = {
        folded = false,
        hidden = false,
      },
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                    Ignored Settings                      │
    -- ╰──────────────────────────────────────────────────────────╯
    ignored_settings = {
      "NeogitPushPopup--hierarchical",
      "NeogitPushPopup--force-with-lease",
      "NeogitPushPopup--force",
      "NeogitPullPopup--hierarchical",
      "NeogitCommitPopup--hierarchical",
      "NeogitLogPopup--hierarchical",
      "NeogitBranchPopup--hierarchical",
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                    Highlight Groups                      │
    -- ╰──────────────────────────────────────────────────────────╯
    highlight = {
      italic = true,
      bold = true,
      underline = true,
    },

    -- ╭──────────────────────────────────────────────────────────╮
    -- │                    Mappings                              │
    -- ╰──────────────────────────────────────────────────────────╯
    mappings = {
      -- Finder (Telescope/fzf) mappings
      finder = {
        ["<cr>"] = "Select",
        ["<c-c>"] = "Close",
        ["<esc>"] = "Close",
        ["<c-n>"] = "Next",
        ["<c-p>"] = "Previous",
        ["<down>"] = "Next",
        ["<up>"] = "Previous",
        ["<tab>"] = "MultiselectToggleNext",
        ["<s-tab>"] = "MultiselectTogglePrevious",
        ["<c-j>"] = "NOP",
        ["<ScrollWheelDown>"] = "ScrollWheelDown",
        ["<ScrollWheelUp>"] = "ScrollWheelUp",
        ["<ScrollWheelLeft>"] = "NOP",
        ["<ScrollWheelRight>"] = "NOP",
        ["<LeftMouse>"] = "MouseClick",
        ["<2-LeftMouse>"] = "NOP",
      },

      -- Popup panel mappings
      popup = {
        ["?"] = "HelpPopup",
        ["A"] = "CherryPickPopup",
        ["B"] = "BranchPopup",
        ["b"] = "BranchPopup",
        ["c"] = "CommitPopup",
        ["d"] = "DiffPopup",
        ["D"] = "DiffPopup",
        ["f"] = "FetchPopup",
        ["i"] = "IgnorePopup",
        ["l"] = "LogPopup",
        ["m"] = "MergePopup",
        ["M"] = "RemotePopup",
        ["p"] = "PullPopup",
        ["P"] = "PushPopup",
        ["r"] = "RebasePopup",
        ["t"] = "TagPopup",
        ["v"] = "RevertPopup",
        ["w"] = "WorktreePopup",
        ["X"] = "ResetPopup",
        ["Z"] = "StashPopup",
      },

      -- Status buffer mappings
      status = {
        -- Stage/unstage operations
        ["1"] = "Depth1",
        ["2"] = "Depth2",
        ["3"] = "Depth3",
        ["4"] = "Depth4",

        -- Navigation
        ["j"] = "MoveDown",
        ["k"] = "MoveUp",
        ["<c-d>"] = "MoveDown",
        ["<c-u>"] = "MoveUp",

        -- Toggles
        ["<tab>"] = "Toggle",
        ["za"] = "Toggle",
        ["zo"] = "Toggle",
        ["zc"] = "Toggle",
        ["x"] = "Discard",
        ["s"] = "Stage",
        ["S"] = "StageUnstaged",
        ["<c-s>"] = "StageAll",
        ["K"] = "Untrack",
        ["u"] = "Unstage",
        ["U"] = "UnstageStaged",

        -- Viewing
        ["<cr>"] = "GoToFile",
        ["<c-x>"] = "VSplitOpen",
        ["<c-v>"] = "SplitOpen",
        ["<c-t>"] = "TabOpen",
      }
    }
  }
}
