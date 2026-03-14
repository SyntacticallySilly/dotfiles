return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    "moyiz/blink-emoji.nvim",
    "rafamadriz/friendly-snippets",
    -- "onsails/lspkind.nvim",
  },
  version = "1.*",

  opts = {
    keymap = {
      preset = "enter",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
    },
    snippets = { preset = 'default' },
    cmdline = {
      enabled = true,
      completion = { list = { selection = { preselect = false, auto_insert = true } }, menu = { auto_show = true, draw = { columns = { { "label" } } } } },
      sources = { 'cmdline', 'buffer', 'path' },
    },
    completion = {
      keyword = { range = 'prefix' },
      trigger = {
        show_on_backspace_in_keyword = true,
      },
      accept = {
        -- Write completions to the `.` register
        dot_repeat = true,
        -- Create an undo point when accepting a completion item
        create_undo_point = true,
      },

      list = { selection = { preselect = true, auto_insert = true } },
      menu = {
        scrollbar = false,
        border = 'none',
        auto_show = true,

        draw = {
          snippet_indicator = "@",
          treesitter = { 'lsp', 'buffer' },
          columns = {
            { "label" },
            { "label_description", "kind", "kind_icon", gap = 1, "source_name" }
          },
        },
      },
      ghost_text = {
        enabled = false,
        show_with_selection = false,
        show_without_selection = false,
        show_with_menu = false,
        show_without_menu = false,
      },
      documentation = {
        auto_show = true,
        -- Delay before showing the documentation window
        auto_show_delay_ms = 500,
        -- Delay before updating the documentation window when selecting a new item,
        -- while an existing item is still visible
        update_delay_ms = 250,
        -- Whether to use treesitter highlighting, disable if you run into performance issues
        treesitter_highlighting = true,
        -- Draws the item in the documentation window, by default using an internal treesitter based implementation
        draw = function(opts) opts.default_implementation() end,
        window = {
          min_width = 10,
          max_width = 80,
          max_height = 20,
          border = 'rounded', -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
          winblend = 10,
          -- Note that the gutter will be disabled when border ~= 'none'
          scrollbar = true,
          -- Which directions to show the documentation window,
          -- for each of the possible menu window directions,
          -- falling back to the next direction when there's not enough space
        }
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'emoji', 'buffer' },
      providers = {
        lsp = {
          name = "LSP",
          module = 'blink.cmp.sources.lsp',
          fallbacks = { 'buffer' },
        },
        path = {
          module = 'blink.cmp.sources.path',
          opts = {
            trailing_slash = true,
            label_trailing_slash = true,
            get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
            show_hidden_files_by_default = true,
            -- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
            ignore_root_slash = false,
            -- Maximum number of files/directories to return. This limits memory use and responsiveness for very large folders.
            max_entries = 10000,
          },
        },
        snippets = {
          module = 'blink.cmp.sources.snippets',
          opts = {
            -- Whether to use show_condition for filtering snippets
            use_show_condition = true,
            -- Whether to show autosnippets in the completion list
            show_autosnippets = true,
            -- Whether to prefer docTrig placeholders over trig when expanding regTrig snippets
            prefer_doc_trig = false,
            -- Whether to put the snippet description in the label description
            use_label_description = false,
          }
        },
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = {
            insert = true,   -- Insert emoji (default) or complete its name
            ---@type string|table|fun():table
            trigger = function()
              return { ":" }
            end,
          },
          should_show_items = function()
            return vim.tbl_contains(
            -- Enable emoji completion only for git commits and markdown.
            -- By default, enabled for all file-types.
              { "gitcommit", "markdown" },
              vim.o.filetype
            )
          end,
        }
      }
    },
    fuzzy = {
      -- Controls which implementation to use for the fuzzy matcher.
      --
      -- 'prefer_rust_with_warning' (Recommended) If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available, emitting a warning message.
      -- 'prefer_rust' If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available.
      -- 'rust' Always use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Error if not available.
      -- 'lua' Always use the Lua implementation, doesn't download any prebuilt binaries
      --
      -- See the prebuilt_binaries section for controlling the download behavior
      implementation = 'rust',

      -- Allows for a number of typos relative to the length of the query
      -- Set this to 0 to match the behavior of fzf
      -- Note, this does not apply when using the Lua implementation.
      max_typos = function(keyword) return math.floor(#keyword / 4) end,

      -- Frecency tracks the most recently/frequently used items and boosts the score of the item
      -- Note, this does not apply when using the Lua implementation.
      frecency = {
        -- Whether to enable the frecency feature
        enabled = true,
        -- Location of the frecency database
        path = vim.fn.stdpath('state') .. '/blink/cmp/frecency.dat',
        -- UNSAFE!! When enabled, disables the lock and fsync when writing to the frecency database.
        -- This should only be used on unsupported platforms (e.g. alpine, termux)
        unsafe_no_lock = false,
      },

      -- Proximity bonus boosts the score of items matching nearby words
      -- Note, this does not apply when using the Lua implementation.
      use_proximity = true,

      -- Controls which sorts to use and in which order, falling back to the next sort if the first one returns nil
      -- You may pass a function instead of a string to customize the sorting
      --
      -- Optionally, set the table of sorts via a function instead: sorts = function() return { 'exact', 'score', 'sort_text' } end
      sorts = {
        -- (optionally) always prioritize exact matches
        -- 'exact',

        -- pass a function for custom behavior
        -- function(item_a, item_b)
        --   return item_a.score > item_b.score
        -- end,

        'score',
        'sort_text',
      },

      prebuilt_binaries = {
        -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`,
        -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
        -- Disabled by default when `fuzzy.implementation = 'lua'`
        download = true,

        -- Ignores mismatched version between the built binary and the current git sha, when building locally
        ignore_version_mismatch = false,

        -- When downloading a prebuilt binary, force the downloader to resolve this version. If this is unset
        -- then the downloader will attempt to infer the version from the checked out git tag (if any).
        --
        -- Beware that if the fuzzy matcher changes while tracking main then this may result in blink breaking.
        force_version = nil,

        -- When downloading a prebuilt binary, force the downloader to use this system triple. If this is unset
        -- then the downloader will attempt to infer the system triple from `jit.os` and `jit.arch`.
        -- Check the latest release for all available system triples
        --
        -- Beware that if the fuzzy matcher changes while tracking main then this may result in blink breaking.
        force_system_triple = nil,

        -- Extra arguments that will be passed to curl like { 'curl', ..extra_curl_args, ..built_in_args }
        extra_curl_args = {},

        proxy = {
          -- When downloading a prebuilt binary, use the HTTPS_PROXY environment variable
          from_env = true,

          -- When downloading a prebuilt binary, use this proxy URL. This will ignore the HTTPS_PROXY environment variable
          url = nil,
        },
      },
    }
  },
}
